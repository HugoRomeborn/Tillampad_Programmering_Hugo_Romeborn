Clock and Temperature Project
Overview
This project, created by Hugo Romeborn, is a clock and temperature monitoring system that displays the current time using a DS3231 real-time clock module and shows the time on a 1306 OLED display. It also measures ambient temperature with an analog temperature sensor, displaying the temperature on both the OLED screen and a 9g servo motor. Users can set timers and alarms, which will trigger a sound notification from a piezo buzzer upon completion.

Components
DS3231 RTC Module - Keeps track of accurate time.
1306 OLED Display - Displays time and temperature.
Analog Temperature Sensor - Measures ambient temperature.
9g Servo Motor - Visually represents the temperature by rotating based on temperature values.
Piezo Buzzer - Emits sound for alarm and timer notifications.
Buttons (x3) - Allows user interaction to set timers and alarms.
Libraries
The following libraries are required for this project:

RTClib for interfacing with the DS3231 RTC module.
Wire for I2C communication.
U8glib for controlling the OLED display.
Servo for operating the servo motor.
Pin Connections
Temperature Sensor (tmpPin) - Analog pin A1
Button 1 (btn1) - Digital pin 11
Button 2 (btn2) - Digital pin 12
Button 3 (btn3) - Digital pin 13
Piezo Buzzer (piezoPin) - Digital pin 8
Servo Motor - Digital pin 9 (for controlling servo)
Functions
Time and Temperature Display
getTime() - Retrieves the current time from the DS3231 RTC module and formats it as a string.
getTemp() - Reads the analog temperature sensor and calculates the corresponding temperature in Celsius.
OLED Display
oledWrite, oledWrite2, oledWrite3 - Draws text on the OLED display, supporting one, two, or three lines of text.
Servo Motor Control
servoWrite - Maps the temperature to a corresponding servo angle, visually indicating temperature.
Timer and Alarm
mainMenu() - Main menu interface for setting timers and alarms.
setTimer() - Configures a countdown timer.
alarm() - Sets an alarm for a specific time.
checkTimer() - Checks if the timer has finished and triggers an alarm if it has.
checkAlarm() - Checks if the current time matches the set alarm time and triggers an alarm if it does.
soundAlarm() - Activates the piezo buzzer as a sound notification.
stopAlarmSound() - Stops the piezo buzzer if the button is pressed.
Setup and Usage
Hardware Setup - Connect all components to the appropriate pins.
Library Installation - Install the required libraries (RTClib, U8glib, Servo) in your Arduino IDE.
Compile and Upload - Compile the code and upload it to your Arduino board.
Interaction - Use the buttons to set alarms and timers, and view the time and temperature on the OLED display.
Notes
Ensure correct calibration of the temperature sensor to obtain accurate readings.
The timer and alarm functions allow you to use the device as both a clock and a temperature-based notification system.
Author
Hugo Romeborn - 2024-10-25
