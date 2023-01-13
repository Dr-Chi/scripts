import random
import time
from datetime import datetime
from pynput import mouse, keyboard

# Disable cursor's screen corner failsafe
mouse.Listener.FAILSAFE = False

# Print a message to indicate that the script is running
print("...")

# Start listening to input events
#store the last input event time in the mouse listener
with mouse.Listener(on_move=lambda x, y: time.time(),on_click=lambda x, y, button, pressed: time.time(),on_scroll=lambda x, y, dx, dy: time.time()) as mouse_listener:
    #store the last input event time in the keyboard listener
    with keyboard.Listener(on_press=lambda key: time.time(),on_release=lambda key: time.time()) as keyboard_listener:
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
                if time.time() - mouse_listener.last_input_time > 30:
                    # left-click the mouse
                    mouse.Controller().click(mouse.Button.left)
                #get the current time
                now = datetime.now()
                # check if the current hour is between 8 and 15 or if the current hour and minute is greater than or equal to the random hour and minute
                if not (8 <= now.hour < 15) or (now.hour, now.minute) >= (random.randint(15, 17), random.randint(0, 59)):
                    print("End ",datetime.now().strftime("%H:%M:%S"))
                    break
        except KeyboardInterrupt:
            print("End ",datetime.now().strftime("%H:%M:%S"))
