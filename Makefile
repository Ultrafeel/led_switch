.SUFFIXES:
.SUFFIXES: .a .c .o
CC=gcc
CFLAGS=-c -Wall -g
LDFLAGS=
LIBSRCH=libhello.h libgoodbye.h 
  
SOURCES=hello.c
OBJDIR:=objdir
LIBDIR:=libraries
OUT_TARG_DIR := target_bin/bin
OBJS=$(OBJDIR)/hello.o
LIBS_FILENAMES=$(LIBSRCH:.h=.a)
LIBS1=$(addprefix $(LIBDIR)/,$(LIBS_FILENAMES))
LIBS_O=$(LIBSRCH:.h=.o)
LIBS_OB=$(addprefix $(OBJDIR)/,$(LIBS_O))
EXECUTABLE=hello
RM := rm

.PHONY: clean main libs do-target

all:  main
main: $(OUT_TARG_DIR)/$(EXECUTABLE)
libs: $(LIBS1)
	
$(OUT_TARG_DIR)/$(EXECUTABLE): $(OBJS) $(LIBS1) $(LIBS_OB) | $(OUT_TARG_DIR) 
	$(CC) $(OBJS) -L$(LIBDIR) -lhello -L$(LIBDIR) -lgoodbye  $(LDFLAGS)  -o $(OUT_TARG_DIR)/$(EXECUTABLE)
#:$@

#echo libso!: $(LIBS_OB)

# -Wl,-trace-symbol=bye  

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

$(OUT_TARG_DIR):
	mkdir $(OUT_TARG_DIR)
#$(addprefix $(OBJDIR)/,hello.c)
#make --trace -w

clean:
	@echo clean : $(OBJS)  $(EXECUTABLE) $(LIBS1)
	-$(RM)  -rfv $(OBJS) ./$(OUT_TARG_DIR)/$(EXECUTABLE) $(EXECUTABLE)  $(LIBS1)  $(LIBS_OB) $(LIBS1:.a=.so) *.a

