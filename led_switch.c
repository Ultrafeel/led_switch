//#include "libhello.h"
//#include "libgoodbye.h"
/* blink.c
 * http://elinux.org/RPi_GPIO_Code_Samples#sysfs
 * Raspberry Pi GPIO example using sysfs interface.
 * Guillermo A. Amaral B. <g@maral.me>
 *
 * This file blinks GPIO 4 (P1-07) while reading GPIO 24 (P1_18).
 */
 
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <poll.h>
#include <errno.h>
#include <string.h>
#include "daemonize.h"
#define IN  0
#define OUT 1
 
#define LOW  0
#define HIGH 1
 
#define PIN  17 /* P1-11 */
#define POUT 18  /* P1-12 */
 
 
void peror(char const* str)
{
	fprintf(stderr, "error: %s . errno = %d, err description: %s\n", str, errno, strerror(errno));
}
static int
GPIOExport(int pin)
{
#define BUFFER_MAX 3
	char buffer[BUFFER_MAX];
	ssize_t bytes_written;
	int fd;
 
	fd = open("/sys/class/gpio/export", O_WRONLY);
	if (-1 == fd) {
		fprintf(stderr, "Failed to open export for writing!\n");
		return(-1);
	}
 
	bytes_written = snprintf(buffer, BUFFER_MAX, "%d", pin);
	write(fd, buffer, bytes_written);
	close(fd);
	return(0);
}
 
static int
GPIOUnexport(int pin)
{
	char buffer[BUFFER_MAX];
	ssize_t bytes_written;
	int fd;
 
	fd = open("/sys/class/gpio/unexport", O_WRONLY);
	if (-1 == fd) {
		fprintf(stderr, "Failed to open unexport for writing!\n");
		return(-1);
	}
 
	bytes_written = snprintf(buffer, BUFFER_MAX, "%d", pin);
	write(fd, buffer, bytes_written);
	close(fd);
	return(0);
}
#define DIRECTION_MAX 35
 
static int
GPIODirection(int pin, int dir)
{
	static const char s_directions_str[]  = "in\0out";
 
	char path[DIRECTION_MAX];
	int fd;
 
	snprintf(path, DIRECTION_MAX, "/sys/class/gpio/gpio%d/direction", pin);
	fd = open(path, O_WRONLY);
	if (-1 == fd) {
		fprintf(stderr, "Failed to open gpio direction for writing!\n");
		return(-1);
	}
 
	if (-1 == write(fd, &s_directions_str[IN == dir ? 0 : 3], IN == dir ? 2 : 3)) {
		fprintf(stderr, "Failed to set direction!\n");
		return(-1);
	}
 
	close(fd);
	return(0);
}
 
static int
GPIORead(int pin)
{
#define VALUE_MAX 30
	char path[VALUE_MAX];
	char value_str[3];
	int fd;
 
	snprintf(path, VALUE_MAX, "/sys/class/gpio/gpio%d/value", pin);
	fd = open(path, O_RDONLY);
	if (-1 == fd) {
		fprintf(stderr, "Failed to open gpio value for reading!\n");
		return(-1);
	}
 
	if (-1 == read(fd, value_str, 3)) {
		fprintf(stderr, "Failed to read value!\n");
		return(-1);
	}
 
	close(fd);
 
	return(atoi(value_str));
}
 
static int
GPIOWrite(int pin, int value)
{
	static const char s_values_str[] = "01";
 
	char path[VALUE_MAX];
	int fd;
 
	snprintf(path, VALUE_MAX, "/sys/class/gpio/gpio%d/value", pin);
	fd = open(path, O_WRONLY);
	if (-1 == fd) {
		fprintf(stderr, "Failed to open gpio value for writing!\n");
		return(-1);
	}
 
	if (1 != write(fd, &s_values_str[LOW == value ? 0 : 1], 1)) {
		fprintf(stderr, "Failed to write value!\n");
		return(-1);
	}
 
	close(fd);
	return(0);
}

static int
GPIOSetEvent(int pin, char * eventType)
{
	char path[VALUE_MAX];
	int fd;
	int sl;
 
	snprintf(path, VALUE_MAX, "/sys/class/gpio/gpio%d/edge", pin);
	fd = open(path, O_WRONLY);
	if (-1 == fd) {
		fprintf(stderr, "Failed to open gpio edge for writing!\n");
		return(-1);
	}
	sl = strlen(eventType);
	if (sl != write(fd, eventType, strlen(eventType))) {
		perror( "Failed to write edge!\n");
		return(-1);
	}
 
	close(fd);
	return(0);
}


void poll_pin() {
	
	
	struct pollfd fdlist[1];
	int fd;
	int n;
	int nErr =0;
	char path[VALUE_MAX];
	//char value_str[3];
	printf(" poll pin! %d , %d", POLLPRI , POLLERR);
	GPIOSetEvent(PIN, "both");
 
	snprintf(path, VALUE_MAX, "/sys/class/gpio/gpio%d/value", PIN);

	fd = open(path, O_RDONLY);
	if (-1 == fd) {
		fprintf(stderr, "Failed to open  %s for poll!\n", path);
		return ;
	}
	fdlist[0].fd = fd;
	fdlist[0].events = POLLPRI | POLLERR;
	while (1) {
		int ret;
		char value[4];
		fdlist[0].revents = 0;
		
		lseek(fd, 0, SEEK_SET);    /* consume any prior interrupt */
		read(fd, value, sizeof value);
		
		ret = poll(fdlist, 1, -1);

		if (ret > 0) {
			//if (fdlist[0].revents == POLLERR)
			//{
				//printf("poll e2 %hd %dhh\n", fdlist[0].revents, fdlist[0].revents == POLLERR);
				//if (++nErr > 55)
					//break;
				//continue;
			//}	
			
			lseek(fd, 0, SEEK_SET);    /* consume any prior interrupt */
	
			n = read(fd, &value, sizeof(value)); 
			
			if (n <= 0)
			{
				printf("read er ret=%d, revenets = %hx, errno=%d\n", n, fdlist[0].revents, errno);
				if (++nErr > 55)
					break;
				continue;
			}
			else
			{
				printf("Button pressed: read %d bytes, value=%c;%x.\n", n, 
			value[0], (int)value[1]); 	
				GPIOWrite(POUT, value[0]=='1' ? HIGH : LOW);
			}
	
		}  else {
			perror("poll");
			return;
		}
 
	}
}


int daemon_main(void)
{
	printf(" led_switch hello: \n");
	
	/*
	 * Enable GPIO pins
	 */
	if (-1 == GPIOExport(POUT) || -1 == GPIOExport(PIN))
		return(1);
 
	/*
	 * Set GPIO directions
	 */
	if (-1 == GPIODirection(POUT, OUT) || -1 == GPIODirection(PIN, IN))
		return(2);
 
 
	poll_pin();
	/*
	 * Disable GPIO pins
	 */
	if (-1 == GPIOUnexport(POUT) || -1 == GPIOUnexport(PIN))
		return(4);
 
	return(0);
}
int main(void)
{
	int ret;
	skeleton_daemon();
	
	ret = daemon_main();
	// LOG_NOTICE
	syslog (0, "First led_switch daemon terminated.");
    //closelog();

    return ret;
}
