SHELL:=/bin/bash
EXEC = whetstone
OBJS = whetstone.o

CFLAGS += -DNO_PROTOTYPES=1
LDLIBS += -lm

ifndef IP
IP=10.100.4.50
endif

ifndef ITT
ITT=30000
endif

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

results:
	cflags=`echo $(CFLAGS) | sed -e 's:-O[0-3s]::g' -e 's/[[:space:]][[:space:]]*/ /g'`; \
	echo "^ Flags  ^  size  ^  Loops  ^  Duration (seconds) ^  Double Precision Whetstones MIPS  ^"; \
	( for level in -O{s,0,1,2,3}{" "," -fomit-frame-pointer"}{" "," -ffast-math"}{" "," -mfast-fp"} ; do \
	    echo -n "| ''$${level}'' " | sed 's/ [ ]*/ /g' | sed "s/ '' /''/"; \
	    rm -f *.elf *.gdb *.o $(EXEC); \
	    $(MAKE) -s --no-print-directory all CFLAGS="$${cflags} $${level} -w"; \
	    if [ -n "$${BR2_BFIN_FDPIC}" ] ; then \
		$(CROSS)strip $(EXEC); \
	    fi;\
	    ls -l $(EXEC) | awk '{ORS = ""; print "  | " $$5 "  | $(ITT)  |  "}'; \
	    rcp $(EXEC) root@$(IP):/var/$(EXEC) ; \
	    tmp=`rsh -l root $(IP) /var/$(EXEC) $(ITT)`; \
	    echo $$tmp | awk '{print $$6 "  |  " $$13 "  |"}'; \
	  done; \
	)

clean:
	-rm -f *.elf *.gdb *.o $(EXEC)

.PHONY: all clean results
