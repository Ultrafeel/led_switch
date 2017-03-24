#.SUFFIXES:
#.SUFFIXES: .c .o

CC=gcc
CFLAGS=-c -Wall 
#-gfull
LDFLAGS=
LIBSRCH=libhello.h libgoodbye.h 
  
SOURCES=hello.c
#OBJECTS=$(SOURCES:.c=.o)
OBJDIR:=objdir
OBJS=$(OBJDIR)/hello.o
LIBS1=libhello.a libgoodbye.a
LIBSO=$(LIBS1:.a=.o)
EXECUTABLE=hello
RM := rm
#all: $(OBJS) $(SOURCES)
all: main
	#echo order-only!: $(filter order-only, $(.FETAURES))
# libs


#$(SOURCES) $(EXECUTABLE)

main: $(EXECUTABLE)
libs: $(LIBS1)

#$(LIBS1):  -Wl,-trace-symbol=some_ref 
#	-L.-lgoodbye -L. -lhello   $(LIBSO) 
$(EXECUTABLE): $(OBJS) $(LIBS1) 
	$(CC)  -Wl,-trace-symbol=some_ref $(LIBSO) $(LDFLAGS) $(OBJS) -o $@
	#ld  --warn-common -L.  -lgoodbye -L. -lhello $(LDFLAGS) $(OBJS) -o $@
# -static -Wl,--warn-common 
.PHONY: clean main libs

$(OBJDIR)/%.o:%.c $(LIBSRCH)
	$(CC) -I. $(CFLAGS) -c -o $@ $<

%.a:%.o
	ar rcsv $@ $<
#$(CC) $(CFLAGS) -c -o	


$(OBJS): | $(OBJDIR)

$(OBJDIR):
	mkdir $(OBJDIR)


#hello.c $(OBJDIR)/

#$(addprefix $(OBJDIR)/,hello.c)
#make --trace -w
#%.o: %.c $(OBJECTS)
#	$(CC) $(CFLAGS) $< -o $@
#	@echo objs receipe for: $<  $@

#
clean:
	@echo clean : $(OBJS)  $(EXECUTABLE) $(LIBS1)
	-$(RM)  -rfv $(OBJS)  $(EXECUTABLE)  $(LIBS1)
	
