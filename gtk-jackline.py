#!/usr/bin/env python
 
import gtk
import vte

import pynotify

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler, FileModifiedEvent, LoggingEventHandler

WATCH_FILENAME = "/home/panton/.config/ocaml-xmpp-client/"
COMMAND = "/home/panton/.opam/4.02.2/bin/jackline"
PROGNAME = "gtkJackline"

gtk.gdk.threads_init()    

pynotify.init(PROGNAME)

class notifyChange(FileSystemEventHandler):
    def on_modified(self, event):
        if event.src_path.endswith("/notification.state"):
            state = file(event.src_path, "r").read()
            n = pynotify.Notification(PROGNAME, state)
            n.set_urgency(pynotify.URGENCY_NORMAL)
            n.show()

event_handler = LoggingEventHandler()
observer = Observer()
observer.schedule(notifyChange(), WATCH_FILENAME, recursive=True)
observer.start()

v = vte.Terminal()
v.connect("child-exited", lambda term: gtk.main_quit())
v.fork_command(COMMAND)

window = gtk.Window()
window.add(v)
window.connect('delete-event', lambda window, event: gtk.main_quit())
window.set_title(PROGNAME)
window.set_wmclass (PROGNAME, PROGNAME)
windowicon = window.render_icon(gtk.STOCK_UNDERLINE, gtk.ICON_SIZE_LARGE_TOOLBAR)
window.set_icon(windowicon)
window.show_all()

gtk.main()

observer.stop()
observer.join()