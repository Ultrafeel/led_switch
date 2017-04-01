#.SUFFIXES:
#.SUFFIXES: .a .c .o
CC=gcc
CFLAGS=-c -Wall
LDFLAGS=
LIBSRCH=libhello.h libgoodbye.h 
  
SOURCES=hello.c
OBJDIR:=objdir
LIBDIR:=libraries
OUT_TARG_DIR := target_bin/bin
OBJS=$(OBJDIR)/hello.o
LIBS_FILENAMES=libhello.so libgoodbye.a
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


# -fpic
#          Generate position-independent code (PIC) suitable for use in a
#         shared library, if supported for the target machine. 
$(OBJDIR)/lib%.o:lib%.c lib%.h | $(OBJDIR)
	$(CC) -I. $(CFLAGS) -fpic -o $@ $<

# %.h $(LIBS_OB) $(LIBSRCH)
#$(OBJDIR)/%.o:%.c
$(OBJS):hello.c $(LIBSRCH) | $(OBJDIR)
	$(CC) -I. $(CFLAGS) -c -o $@ $<

$(LIBDIR)/%.so:$(OBJDIR)/%.o  |$(LIBDIR)
	$(CC) -shared -o $@ $<

$(LIBDIR)/%.a:$(OBJDIR)/%.o  |$(LIBDIR)
	ar rcsv $@ $<

#$(OBJS): 

$(LIBDIR):
	@mkdir $(LIBDIR)

$(OBJDIR):
	mkdir $(OBJDIR)

$(OUT_TARG_DIR):
	mkdir -p $(OUT_TARG_DIR)
#$(addprefix $(OBJDIR)/,hello.c)
#make --trace -w

clean:
	@echo clean : $(OBJS)  $(EXECUTABLE) $(LIBS1)
	-$(RM)  -rfv   $(OBJS) ./$(OUT_TARG_DIR)/$(EXECUTABLE) $(EXECUTABLE).o $(EXECUTABLE)  $(LIBS1) $(LIBS_FILENAMES) $(LIBS_OB) $(LIBSRCH:.h=.a) $(LIBSRCH:.h=.so)

