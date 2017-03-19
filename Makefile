CC=gcc
CFLAGS=-c -Wall
LDFLAGS=
LIBSRCES=libhello.c libgoodbye.c 
LIBS1=libhello libgoodbye 
SOURCES=hello.c $(SOURCES)
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=hello
RM := rm -rf
all: main

# libs


#$(SOURCES) $(EXECUTABLE)

main: $(EXECUTABLE)
libs: $(LIBS1)

	
$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

#.c.o:
#	$(CC) $(CFLAGS) $< -o $@
clean:
	$(RM)  -rf $(OBJECTS)  $(EXECUTABLE)
