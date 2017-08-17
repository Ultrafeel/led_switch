#.SUFFIXES:
#.SUFFIXES: .a .c .o
#CC=gcc
MCFLAGS:=-c  -ggdb3  -Wall $(CFLAGS) 
#LDFLAGS=


SOURCES=led_switch.c daemonize.c
OBJDIR:=objdir

OUT_TARG_DIR := target_bin/bin
OBJS=$(OBJDIR)/led_switch.o $(OBJDIR)/daemonize.o
EXECUTABLE=led_switch
RM := rm

.PHONY: clean main  do-target

all:  main
main: $(OUT_TARG_DIR)/$(EXECUTABLE)


	
$(OUT_TARG_DIR)/$(EXECUTABLE): $(OBJS) | $(OUT_TARG_DIR) 
	$(LD) $(OBJS)  -lc $(LDFLAGS) --dynamic-linker=/lib/ld-uClibc.so.1 -o $(OUT_TARG_DIR)/$(EXECUTABLE)


# -Wl,-trace-symbol=bye  

$(OBJDIR)/lib%.o:lib%.c lib%.h | $(OBJDIR)
	$(CC) -I. $(MCFLAGS) -c -o $@ $<

# %.h $(LIBS_OB) $(LIBSRCH)
#$(OBJS):led_switch.c $(LIBSRCH) | $(OBJDIR)
$(OBJDIR)/%.o:%.c    | $(OBJDIR)
	$(CC) -I. $(MCFLAGS) -c -o $@ $<


$(OBJDIR):
	mkdir $(OBJDIR)

$(OUT_TARG_DIR):
	mkdir -p $(OUT_TARG_DIR)
#$(addprefix $(OBJDIR)/,led_switch.c)
#make --trace -w

clean:
	-$(RM)  -rfv   $(OBJS) ./$(OUT_TARG_DIR)/$(EXECUTABLE) \
 $(EXECUTABLE).o $(EXECUTABLE)  
	-@$(RM) -dfv $(OUT_TARG_DIR) $(OBJDIR) 
