import random
import time
from datetime import datetime
from pynput import mouse, keyboard

# Print a message to indicate that the script is running
print("...")

# generate random ending time
end_hour = random.randint(15,17) # generate random hour between 15 and 17
end_min = random.randint(0,59) # generate random minute between 0 and 59

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
            #initialize the x and y position of the cursor
            x_prev, y_prev = mouse.Controller().position
            while True:
                #get the current position of the cursor
                x, y = mouse.Controller().position
                #determine the direction of the cursor
                x_prev, y_prev = x, y
                #move the cursor
                mouse.Controller().position = (x+1 if x < x_prev else x-1, y)
                #generate a random sleep time between 30 and 240 seconds
                time.sleep(random.randint(30,240))
                # check if 30 seconds has passed since the last input event
                if time.time() - last_input_time > 30:
                    # left-click the mouse
                    mouse.Controller().click(mouse.Button.left)
                #get the current time
                now = datetime.now()
                # check if the current hour is between 8 and 15 or if the current hour and minute is greater than or equal to the random hour and minute
                if not (8 <= now.hour < 15) or (now.hour, now.minute) >= (end_hour, end_min):
                    print("End ",datetime.now().strftime("%H:%M:%S"))
                    break
        except KeyboardInterrupt:
            print("End ",datetime.now().strftime("%H:%M:%S"))
