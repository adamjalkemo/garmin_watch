DEVELOPER_KEY_PATH ?= developer_key.der

DEVICE ?= fr235
APP ?= hello_world

APP_PATH = apps/$(APP)

CFLAGS += -d $(DEVICE)
CFLAGS += -y developer_key.der
CFLAGS += -f $(APP_PATH)/monkey.jungle
#CFLAGS += -e
CFLAGS += -w
#CFLAGS += -r

ifeq (, $(shell which monkeyc))
	PATH := $(shell realpath ~/.Garmin/ConnectIQ/Sdks/*/bin):$(PATH)
endif

PROG := $(APP).prg

.PHONY: all
all: $(PROG)

$(PROG): $(shell find $(APP_PATH))
	monkeyc $(CFLAGS) -o $@

.PHONY: connectiq
simulate: $(PROG)
	pidof simulator || connectiq 2>&1 > /dev/null &
	monkeydo $(PROG) $(DEVICE)

.PHONY: clean
clean:
	rm -f $(PROG) $(PROG).debug.xml