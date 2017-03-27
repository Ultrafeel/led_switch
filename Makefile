CC=gcc
CFLAGS=-c -Wall -g
LDFLAGS=
LIBSRCH=libhello.h libgoodbye.h 
  
SOURCES=hello.c
OBJDIR:=objdir
LIBDIR:=libraries
OBJS=$(OBJDIR)/hello.o
LIBS_FILENAMES=$(LIBSRCH:.h=.a)
LIBS1=$(addprefix $(LIBDIR)/,$(LIBS_FILENAMES))
LIBS_O=$(LIBSRCH:.h=.o)
LIBS_OB=$(addprefix $(OBJDIR)/,$(LIBS_O))
EXECUTABLE=hello
RM := rm

all: main

main: $(EXECUTABLE)
libs: $(LIBS1)
	
$(EXECUTABLE): $(OBJS) $(LIBS1) $(LIBS_OB)
	$(CC) $(OBJS) -L$(LIBDIR) -lhello -L$(LIBDIR) -lgoodbye  $(LDFLAGS)  -o $@

#echo libso!: $(LIBS_OB)

# -Wl,-trace-symbol=bye  
.PHONY: clean main libs

$(OBJDIR)/lib%.o:lib%.c lib%.h | $(OBJDIR)
	$(CC) -I. $(CFLAGS) -c -o $@ $<

# %.h $(LIBS_OB) $(LIBSRCH)
#$(OBJDIR)/%.o:%.c
$(OBJS):hello.c $(LIBSRCH) | $(OBJDIR)
	$(CC) -I. $(CFLAGS) -c -o $@ $<

$(LIBDIR)/%.a:$(OBJDIR)/%.o  |$(LIBDIR)
	ar rcsv $@ $<

#$(OBJS): 

$(LIBDIR):
	@mkdir $(LIBDIR)

$(OBJDIR):
	mkdir $(OBJDIR)

#$(addprefix $(OBJDIR)/,hello.c)
#make --trace -w

clean:
	@echo clean : $(OBJS)  $(EXECUTABLE) $(LIBS1)
	-$(RM)  -rfv $(OBJS)  $(EXECUTABLE)  $(LIBS1)  $(LIBS_OB) $(LIBS1:.a=.so) *.a

