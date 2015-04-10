# rcabiennale
Interactive Installation for Christina Mamakos to be exhibited at RCA Biennale 2015 in London

## Manual

### Components
- Sensor attached to cables (Red: 5V, Black: GND, Yellow: Signal)
- Arduino (see back of wooden box for plug-in instructions)
- Mac Mini (needs USB Keyboard and USB Mouse, projector as a screen)
- Projector

### Physical Setup
1. Mount the sensor to a microphone stand
  1. The sensor must face towards the audience
  2. It must be placed directly on the wall/projection area
  3. It must stand free and at a height of at least 1.5m from the ground floor
  4. Ensure that the sensor is fixed well to the microphone stand and is directed correctly
2. Connect the sensor wires to Arduino
  1. Insert 5V Red cable into Arduino 5V pin (most left plug)
  2. Insert GND Black cable into Arduino GND (one of the GND plugs in the middle)
  3. Insert Signal Yellow cable into Arduino A0 (most right plug)
  4. Ensure all cables are fixed and do not wobble
  5. **NEVER** plug in 5V into GND or vice versa!
3. Connect Arduino to Mac Mini with USB cable
  1. Arduino draws power from USB, so no external power supply is needed
4. Connect keyboard, mouse and projector to Mac Mini
  1. Power up Mac Mini
  2. Login with user "rcabiennale" and password "rcabiennale" (both without the quotes)
  3. On the desktop there is a folder called "Christina", containing a link to the application, code and to this document
5. Double click the "christina.pde" file, this is the application and will open in Processing
  1. Inside the code there are only two parameters that might (only might!) need to be changed, that is the line `boolean isFullscreen = true;` and `int arduinoPort = 5;`
  2. Setting isFullscreen to "false" (without brackets) will launch app in a window
  3. Setting arduinoPort to some other number will change the port on which to connect to Arduino (most certainly not needed)
6. *Press the "Play" button* on the top left of the Processing window
7. The app will open and start reacting to audience