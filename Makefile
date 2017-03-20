.SUFFIXES:
.SUFFIXES: .c .o

CC=gcc
CFLAGS=-c -Wall
LDFLAGS=
LIBSRCES=libhello.c libgoodbye.c 
LIBS1=libhello libgoodbye 
SOURCES=hello.c
OBJECTS=$(SOURCES:.c=.o)
OBJDIR:=objdir
OBJS=$(OBJDIR)/hello.o
EXECUTABLE=hello
RM := rm
all: main
	echo order-only $(filter order-only, $(.FETAURES))
# libs


#$(SOURCES) $(EXECUTABLE)

main: $(EXECUTABLE)
libs: $(LIBS1)

	
$(EXECUTABLE): $(OBJS) 
	$(CC) $(LDFLAGS) $(OBJS) -o $@


clean:
	@echo clean : $(OBJS)  $(EXECUTABLE)
	-$(RM)  -rf $(OBJS)  $(EXECUTABLE)
	
.PHONY: clean main libs






#hello.c $(OBJDIR)/

#$(addprefix $(OBJDIR)/,hello.c)

#%.o: %.c $(OBJECTS)
#	$(CC) $(CFLAGS) $< -o $@
#	@echo objs receipe for: $<  $@

#
$(OBJDIR)/%.o:%.c
	$(CC) $(CFLAGS) -c -o $@ $<



#all: $(OBJS) $(SOURCES)

$(OBJS): | $(OBJDIR)

$(OBJDIR):
	mkdir $(OBJDIR)


