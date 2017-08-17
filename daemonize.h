#ifndef _daemonize_h_
     #define _daemonize_h_
     
//#pragma once

char const  * get_hello();
//void openlog(char * m, int t);

void syslog(int , char const* message);
void skeleton_daemon();
#endif
