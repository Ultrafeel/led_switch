CC=gcc
CFLAGS=-c -Wall -g
LDFLAGS=
LIBSRCH=libhello.h libgoodbye.h 
  
SOURCES=hello.c
OBJDIR:=objdir
OBJS=$(OBJDIR)/hello.o
LIBS1=libhello.a libgoodbye.a
LIBS_O=$(LIBS1:.a=.o)
LIBS_OB=$(addprefix $(OBJDIR)/,$(LIBS_O))
EXECUTABLE=hello
RM := rm

all: main

main: $(EXECUTABLE)
libs: $(LIBS1)

$(EXECUTABLE): $(OBJS) $(LIBS1)
	$(CC) $(OBJS) -L. -lhello -L. -lgoodbye  $(LDFLAGS)  -o $@

# -Wl,-trace-symbol=bye  
.PHONY: clean main libs

$(OBJDIR)/%.o:%.c $(LIBSRCH) | $(OBJDIR)
	$(CC) -I. $(CFLAGS) -c -o $@ $<
	
%.o:%.c $(LIBSRCH)
	$(CC) -I. $(CFLAGS) -c -o $@ $<

%.a:%.o
	ar rcsv $@ $<

#$(OBJS): 

$(OBJDIR):
	mkdir $(OBJDIR)

#$(addprefix $(OBJDIR)/,hello.c)
#make --trace -w

clean:
	@echo clean : $(OBJS)  $(EXECUTABLE) $(LIBS1)
	-$(RM)  -rfv $(OBJS)  $(EXECUTABLE)  $(LIBS1)  $(LIBS_OB) $(LIBS1:.a=.so)

