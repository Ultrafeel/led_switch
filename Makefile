CC=gcc
CFLAGS=-c -Wall
LDFLAGS=
LIBSRCES=libhello.c libgoodbye.c 
LIBS1=libhello libgoodbye 
SOURCES=hello.c
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=hello
RM := rm
all: main

# libs


#$(SOURCES) $(EXECUTABLE)

main: $(EXECUTABLE)
libs: $(LIBS1)

	
$(EXECUTABLE): $(OBJS) 
	$(CC) $(LDFLAGS) $(OBJS) -o $@


clean:
	@echo $(OBJS)  $(EXECUTABLE)
	-$(RM)  -rf $(OBJS)  $(EXECUTABLE)
	
.PHONY: clean main libs



OBJDIR := objdir
OBJS := $(addprefix $(OBJDIR)/,$(OBJECTS))

#%.o: %.c _!
#	$(CC) $(CFLAGS) $< -o $@

$(OBJDIR)/%.o : %.c
	$(CC) $(CFLAGS)  $<

#all: $(OBJS)

$(OBJS): | $(OBJDIR)

$(OBJDIR):
	mkdir $(OBJDIR)


