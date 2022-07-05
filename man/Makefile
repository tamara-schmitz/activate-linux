PREFIX ?= /usr/local
DESTDIR ?=
MANDIR ?= $(PREFIX)/share/man

RM = rm
PANDOC = pandoc

MAN = activate-linux.1

all: $(MAN)

$(MAN): activate-linux.1.md
	pandoc activate-linux.1.md -s -t man -o $(MAN)
	gzip -f $(MAN)

install: $(MAN)
	install -Dm0644 $(MAN) $(DESTDIR)$(MANDIR)/man1/$(MAN).gz

uninstall:
	$(RM) -f $(DESTDIR)$(MANDIR)/man1/$(MAN)

clean:
	$(RM) -f $(MAN)

test: $(MAN)
	man -l $(MAN)

.PHONY: all clean install uninstall test
