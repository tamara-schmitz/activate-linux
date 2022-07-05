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
	cd man; make $(MFLAGS) all || true

%.c: %.cgen
	@echo -e " GEN\t" $(<)
	@sh $(<) > $(@)

obj/%.o: src/%.c
	@echo -e "  CC\t" $(<)
	@$(CC) -c $(<) -o $(@) $(CFLAGS)

$(BINARY): $(OBJECTS)
	@echo -e "LINK\t" $(^)
	@$(CC) $(^) -o $(@) $(LDFLAGS)

install: $(BINARY)
	install -Dm0755 $(BINARY) $(DESTDIR)$(PREFIX)/$(BINDIR)/$(BINARY)
	cd man; make $(MFLAGS) install || true

uninstall:
	$(RM) -f $(DESTDIR)$(PREFIX)/$(BINDIR)/$(BINARY)
	cd man; make $(MFLAGS) uninstall || true

clean:
	$(RM) -f $(OBJECTS) $(BINARY)
	cd man; make $(MFLAGS) clean

test: $(BINARY)
	./$(BINARY)

testman:
	cd man; make $(MFLAGS) test


.PHONY: all clean install uninstall test testman

