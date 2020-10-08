DEVELOPER_KEY_PATH ?= developer_key.der

CFLAGS += -d fr235
CFLAGS += -y developer_key.der
CFLAGS += -f apps/Strings/monkey.jungle
CFLAGS += -e
CFLAGS += -w
#CFLAGS += -r


something.iq:
	monkeyc $(CFLAGS) -o $@


.PHONY: clean
clean:
	rm something.iq