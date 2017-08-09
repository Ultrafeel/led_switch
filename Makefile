#.SUFFIXES:
#.SUFFIXES: .a .c .o
#CC=gcc
MCFLAGS:=-c -g -Wall $(CFLAGS)
#LDFLAGS=
LIBSRCH=libhello.h libgoodbye.h 
  
SOURCES=led_switch.c
OBJDIR:=objdir
LIBDIR:=libraries
OUT_TARG_DIR := target_bin/bin
OBJS=$(OBJDIR)/led_switch.o
LIBS_FILENAMES=$(LIBSRCH:.h=.a)
LIBS1=$(addprefix $(LIBDIR)/,$(LIBS_FILENAMES))
LIBS_O=$(LIBSRCH:.h=.o)
LIBS_OB=$(addprefix $(OBJDIR)/,$(LIBS_O))
EXECUTABLE=led_switch
RM := rm

.PHONY: clean main libs do-target

all:  main
main: $(OUT_TARG_DIR)/$(EXECUTABLE)
libs: $(LIBS1)
	
$(OUT_TARG_DIR)/$(EXECUTABLE): $(OBJS) $(LIBS1) $(LIBS_OB) | $(OUT_TARG_DIR) 
	$(LD) $(OBJS) -L$(LIBDIR) -L$(LIBDIR) -lc $(LDFLAGS) --dynamic-linker=/lib/ld-uClibc.so.1 -o $(OUT_TARG_DIR)/$(EXECUTABLE)
#:$@

#echo libso!: $(LIBS_OB)

# -Wl,-trace-symbol=bye  

$(OBJDIR)/lib%.o:lib%.c lib%.h | $(OBJDIR)
	$(CC) -I. $(MCFLAGS) -c -o $@ $<

# %.h $(LIBS_OB) $(LIBSRCH)
#$(OBJDIR)/%.o:%.c
$(OBJS):led_switch.c $(LIBSRCH) | $(OBJDIR)
	$(CC) -I. $(MCFLAGS) -c -o $@ $<

$(LIBDIR)/%.a:$(OBJDIR)/%.o  |$(LIBDIR)
	ar rcsv $@ $<

#$(OBJS): 

$(LIBDIR):
	@mkdir $(LIBDIR)

$(OBJDIR):
	mkdir $(OBJDIR)

$(OUT_TARG_DIR):
	mkdir -p $(OUT_TARG_DIR)
#$(addprefix $(OBJDIR)/,led_switch.c)
#make --trace -w

clean:
	@echo clean : $(OBJS)  $(EXECUTABLE) $(LIBS1)
	-$(RM)  -rfv   $(OBJS) ./$(OUT_TARG_DIR)/$(EXECUTABLE) \
 $(EXECUTABLE).o $(EXECUTABLE)  $(LIBS1) $(LIBS_FILENAMES) $(LIBS_OB) \
 $(LIBSRCH:.h=.a) $(LIBSRCH:.h=.so) 
	-@$(RM) -dfv $(OUT_TARG_DIR) $(OBJDIR) $(LIBDIR)

