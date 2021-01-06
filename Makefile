DEVELOPER_KEY_PATH ?= developer_key.der
GARMIN_MOUNT_POINT ?= /media/adam/GARMIN

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

.PHONY: simulate
simulate: $(PROG)
	pidof simulator || connectiq 2>&1 > /dev/null &
	monkeydo $(PROG) $(DEVICE)

.PHONY: deploy
deploy: $(PROG)
	cp $(PROG) $(GARMIN_MOUNT_POINT)/GARMIN/APPS/

.PHONY: clean
clean:
	rm -f $(PROG) $(PROG).debug.xml
