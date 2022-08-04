RM = rm
PANDOC = pandoc

MANPRE = activate-linux.1
MAN = $(MANPRE).gz

all: $(MAN)

$(MAN): activate-linux.1.md
	pandoc activate-linux.1.md -s -t man -o $(MANPRE)
	gzip -f $(MANPRE)

install: $(MAN)
	install -Dm0644 $(MAN) $(DESTDIR)$(MANDIR)/man1/$(MAN)

uninstall:
	$(RM) -f $(DESTDIR)$(MANDIR)/man1/$(MAN)

clean:
	$(RM) -f $(MAN)

test: $(MAN)
	man -l $(MAN)

.PHONY: all clean install uninstall test
