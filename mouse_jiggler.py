import random
from datetime import datetime
from time import sleep
import pyautogui

# Disable pyautogui's screen corner failsafe; otherwise we get an error if the cursor ever happens to reach a corner
pyautogui.FAILSAFE = False

# Print a message to indicate that the script is running
print("...")

# Initialize a variable to keep track of the direction the cursor is moving
forward = True

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
        sleep_time = random.randint(30,240)
        
        # Wait for the random sleep time
        sleep(sleep_time)
        
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
