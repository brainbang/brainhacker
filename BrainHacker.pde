/*

Delta waves 1⁄2Hz to 4Hz 2.2Hz deep unconscious, intuition and insight
Theta waves 4Hz to 8Hz 6.0Hz subconscious, creativity, deep relaxation
Alpha waves 8Hz to 13Hz 11.1Hz spacey and dreamy, receptive and passive
Beta waves 13Hz to 30Hz 14.4Hz conscious thought, external focus

*/

// uncomment to output current hertz to serial
// #define DEBUG

// http://code.google.com/p/arduino-tone/
#include <Tone.h>

// current brainwave-scoped freq
float hertz = 0;

// carrier frequency
float baseFreq = float(NOTE_C3);

// pin for analog speed control
int speedPot = 0;

// LED's are on these pins
int ledR = 8; // atmega pin 14, use 1K resistor
int ledL = 7; // atmega pin 13, use 1K resistor

// speakers are on these pins
int audR = 6; // atmega pin 11, use 1K resistor
int audL = 5; // atmega pin 12, use 1K resistor

int ledState = LOW;             // ledState used to set the LED
long previousLEDMillis = 0;     // will store last time LED was updated

Tone toneL;
Tone toneR;

void setup(){
#ifdef DEBUG
  Serial.begin(9600);
#endif

  pinMode(ledR, OUTPUT);
  pinMode(ledL, OUTPUT);

  toneL.begin(audL);
  toneR.begin(audR);
}

void loop(){
  // current brainwave-scoped freq, based on analog pot
  hertz = float(map(analogRead(speedPot), 0, 1023, 5, 300)) / 10.00;

#ifdef DEBUG
  Serial.println(hertz);
#endif

  // AUDIO
  toneL.play(baseFreq - (hertz/2.00));
  toneR.play(baseFreq + (hertz/2.00));

  // VISUAL
  if ((millis() - previousLEDMillis) > (1000.00 / (hertz * 2.00))) {
    previousLEDMillis = millis();
    ledState = !ledState;
    digitalWrite(ledL, ledState);
    digitalWrite(ledR, !ledState);
  }

}
