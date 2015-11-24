# see https://www.gnu.org/prep/standards/html_node/Makefile-Conventions.html

INSTALL = /usr/bin/install
INSTALL_DATA = $(INSTALL) -m 644
INSTALL_PROGRAM = $(INSTALL)

prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datarootdir = $(prefix)/share

install:
	mkdir -p $(DESTDIR)$(datarootdir)/applications
	$(INSTALL_DATA) jackline.desktop $(DESTDIR)$(datarootdir)/applications
	mkdir -p $(DESTDIR)$(bindir)
	$(INSTALL_PROGRAM) jackline-gtk $(DESTDIR)$(bindir)

uninstall:
	$(RM) -f $(DESTDIR)$(datarootdir)/applications/jackline.desktop
	-rmdir -p $(DESTDIR)$(datarootdir)/applications
	$(RM) $(DESTDIR)$(bindir)/jackline-gtk
	-rmdir -p $(DESTDIR)$(bindir)
