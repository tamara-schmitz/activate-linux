CC ?= clang
CFLAGS ?= -Og -Wall -Wpedantic -Wextra
PREFIX ?= /usr/local
BINDIR ?= bin
DESTDIR ?=

PKGS := \
	x11 xfixes xinerama xrandr \
	wayland-client cairo

RM = rm

SOURCES := $(wildcard src/*.c)
OBJECTS = $(patsubst %.c, %.o, $(SOURCES))

GENERATORS := $(wildcard src/*.cgen)
GENERATEDSRCS = $(patsubst %.cgen, %.gen.c, $(GENERATORS))
OBJECTS += $(patsubst %.c, %.o, $(GENERATEDSRCS))

NAME := $(shell uname -s)
CFLAGS := \
	$(CFLAGS) \
	$(shell pkg-config --cflags $(PKGS))

LDFLAGS := \
	$(LDFLAGS) \
	$(shell pkg-config --libs $(PKGS))

ifeq ($(NAME),Linux)
	BINARY := activate-linux
endif

ifeq ($(NAME),Darwin)
	BINARY := activate-macos
endif

all: $(BINARY)

%.gen.c: %.cgen
	sh $< > $@

%.o: %.c
	$(CC) -c $(<) -o $(@) $(CFLAGS)

$(BINARY): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(@) $(LDFLAGS)

install: $(BINARY)
	install -Dm0755 $(BINARY) $(DESTDIR)$(PREFIX)/$(BINDIR)/$(BINARY)

uninstall:
	$(RM) -f $(DESTDIR)$(PREFIX)/$(BINDIR)/$(BINARY)

clean:
	$(RM) -f $(OBJECTS) $(GENERATEDSRCS) $(BINARY)

test: $(BINARY)
	./$(BINARY)

.PHONY: all clean install test
