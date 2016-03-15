# see https://www.gnu.org/prep/standards/html_node/Makefile-Conventions.html

CHECKINSTALL = /usr/bin/checkinstall
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

checkinstall-deb:
	echo "GTK wrapper around the jackline IM client" > description-pak
	$(CHECKINSTALL) --nodoc -y --deldesc \
	  --maintainer infinity0@pwned.gg \
	  --pkgname "jackline-gtk" --pkgversion "0.0" \
	  --requires "python-gi, gir1.2-gtk-3.0, gir1.2-vte-2.91, gir1.2-notify-0.7, sound-theme-freedesktop" \
	  $(MAKE) prefix=/usr install
	-@test -e /usr/bin/jackline || echo \
	  "You should run \`install -T jackline.opam /usr/local/bin/jackline\` since we" \
	  "haven't yet packaged jackline properly".
