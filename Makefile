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
OBJECTS = $(patsubst src/%, obj/%, $(patsubst %.c, %.o, $(SOURCES)))

GENERATORS := $(wildcard src/*.cgen)
OBJECTS += $(patsubst src/%, obj/%, $(patsubst %.cgen, %.o, $(GENERATORS)))

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

%.c: %.cgen
	@echo " GEN\t" $(<)
	@sh $(<) > $(@)

obj/%.o: src/%.c
	@echo "  CC\t" $(<)
	@$(CC) -c $(<) -o $(@) $(CFLAGS)

$(BINARY): $(OBJECTS)
	@echo "LINK\t" $(^)
	@$(CC) $(^) -o $(@) $(LDFLAGS)

install: $(BINARY)
	install -Dm0755 $(BINARY) $(DESTDIR)$(PREFIX)/$(BINDIR)/$(BINARY)

uninstall:
	$(RM) -f $(DESTDIR)$(PREFIX)/$(BINDIR)/$(BINARY)

clean:
	$(RM) -f $(OBJECTS) $(BINARY)

test: $(BINARY)
	./$(BINARY)

.PHONY: all clean install test
