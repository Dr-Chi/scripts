import random
import time
from datetime import datetime
from pynput import mouse, keyboard
from time import sleep
import pyautogui

# Disable pyautogui's screen corner failsafe; otherwise we get an error if the cursor ever happens to reach a corner
pyautogui.FAILSAFE = False

# Print a message to indicate that the script is running
print("...")

# Initialize a variable to keep track of the direction the cursor is moving
forward = True

# Initialize a variable to store the time of the last input event
last_input_time = time.time()

# Define a function to check for input events
def on_move(x, y):
    global last_input_time
    last_input_time = time.time()

# Define a function to check for input events
def on_click(x, y, button, pressed):
    global last_input_time
    last_input_time = time.time()

# Define a function to check for input events
def on_scroll(x, y, dx, dy):
    global last_input_time
    last_input_time = time.time()

# Define a function to check for input events
def on_press(key):
    global last_input_time
    last_input_time = time.time()

# Define a function to check for input events
def on_release(key):
    global last_input_time
    last_input_time = time.time()

# Start listening to input events
with mouse.Listener(on_move=on_move,on_click=on_click,on_scroll=on_scroll) as mouse_listener:
    with keyboard.Listener(on_press=on_press,on_release=on_release) as keyboard_listener:
        try:
            while True:
                # Get the current position of the cursor
                xpos = pyautogui.position()[0]
                ypos = pyautogui.position()[1]
                pyautogui.moveTo(xpos,ypos)

                # Calculate the new position for the cursor, based on the direction it's moving
                new_pos = xpos - 1
                if forward:
                    new_pos = xpos + 1

                # Change the direction of the cursor's movement
                forward = not forward

                # Move the cursor to the new position
                pyautogui.moveTo(new_pos, ypos)

                # Generate a random sleep time between 30 and 240 seconds
                #sleep_time = 3 # For testing
                sleep_time = random.randint(30,240)

                # Wait for the random sleep time
                sleep(sleep_time)

                # check if 30 seconds has passed since the last input event
                if time.time() - last_input_time > 30:
                    # left-click the mouse
                    pyautogui.click(button='left')

                # Check the current time
                now = datetime.now()

                # Print out the mouse position; for diagnostics
                #print(pyautogui.position())

                # check if the current hour is between 8 and 15
                if not (8 <= now.hour < 15):
                    # generate random minute between 0 and 59
                    random_min = random.randint(0,59)
                    # generate random hour between 15 and 17
                    random_hour = random.randint(15,17)
                    # check if current hour and minute is greater than or equal to the random hour and minute
                    if now.hour >= random_hour and now.minute >= random_min:
                        current_time = datetime.now().strftime("%H:%M:%S")
                        print("End ",current_time," (",random_hour,":",random_min,")")
                        break

        # If the user interrupts the script (e.g. by pressing ctrl-c), print a message and exit
        except KeyboardInterrupt:
            current_time = datetime.now().strftime("%H:%M:%S")
            print("End ",current_time)
