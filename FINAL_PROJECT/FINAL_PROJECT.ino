#define MQ_CO2 (0)
int mql135;

#include <SoftwareSerial.h>
SoftwareSerial portOne(10, 11); //10 RX, 11 TX

#include "Wire.h"
#define iaqaddress 0x5A

uint16_t predict;
uint8_t statu;
int32_t resistance;
uint16_t tvoc;

#define ADDR_6713  0x15 // default I2C slave address
int data [4];
int CO2ppmValue;

boolean hasRun = false;

#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
#include <avr/power.h> // Required for 16 MHz Adafruit Trinket
#endif

// Which pin on the Arduino is connected to the NeoPixels?
#define PIN1        6
#define PIN2        5
#define PIN3        4
#define PIN4        3

Adafruit_NeoPixel pixel2(1, PIN1, NEO_GRB + NEO_KHZ800);
Adafruit_NeoPixel pixel1(1, PIN2, NEO_GRB + NEO_KHZ800);
Adafruit_NeoPixel pixel3(1, PIN3, NEO_GRB + NEO_KHZ800);
Adafruit_NeoPixel pixel4(1, PIN4, NEO_GRB + NEO_KHZ800);


void setup() {
  Serial.begin(9600);
  Wire.begin();
  portOne.begin(9600);
#if defined(__AVR_ATtiny85__) && (F_CPU == 16000000)
  clock_prescale_set(clock_div_1);
#endif
  pixel1.begin();
  pixel2.begin();
  pixel3.begin();
  pixel4.begin();

}

void loop() {
  pixel1.setPixelColor(0, pixel1.Color(0, 0, 0));
  pixel1.show();
  pixel2.setPixelColor(0, pixel2.Color(0, 0, 0));
  pixel2.show();
  pixel3.setPixelColor(0, pixel3.Color(0, 0, 0));
  pixel3.show();
  pixel4.setPixelColor(0, pixel4.Color(0, 0, 0));
  pixel4.show();

  if (hasRun == false) {
    runFunction();
    Serial.println("finish");
  }
}

void runFunction() {
  Serial.println("mq135");
  while (millis() < 10000) {
    pixel1.setPixelColor(0, pixel1.Color(255, 0, 0));
    pixel1.show();
    mq135();
  }
  Serial.println("iaqcorec");
  while (millis() < 20000) {
    pixel1.setPixelColor(0, pixel1.Color(0, 0, 0));
    pixel1.show();
    pixel2.setPixelColor(0, pixel2.Color(255, 255, 0));
    pixel2.show();
    iaqcorec();
  }
  Serial.println("T6713");
  while (millis() < 70000) {
    pixel2.setPixelColor(0, pixel2.Color(0, 0, 0));
    pixel2.show();
    pixel3.setPixelColor(0, pixel3.Color(0, 255, 0));
    pixel3.show();
    t6713();
  }
  Serial.println("iaqcorec2");
  while (millis() < 80000) {
    pixel3.setPixelColor(0, pixel3.Color(0, 0, 0));
    pixel3.show();
    pixel4.setPixelColor(0, pixel4.Color(255, 0, 255));
    pixel4.show();
    iaqcorec2();
  }
  pixel4.setPixelColor(0, pixel4.Color(0, 0, 0));
  pixel4.show();
  hasRun = true;
}

//mq135 fuctions------------------------------------------------------------
void mq135() {
  mql135 = analogRead(MQ_CO2);
  Serial.println(mql135, DEC);//ppm (partes por millón)
  delay(250);
}

//iaqcorec functions--------------------------------------------------------
void iaqcorec() {
  readAllBytes();
  Serial.println(tvoc);
  delay(250);
}

void readAllBytes()
{
  Wire.requestFrom(iaqaddress, 9); //iaqaddress: the 7-bit address of the device to request bytes from ....... 9: the number of bytes to request
  predict = (Wire.read() << 8 | Wire.read());
  statu = Wire.read();
  resistance = (Wire.read() & 0x00) | (Wire.read() << 16) | (Wire.read() << 8 | Wire.read());
  tvoc = (Wire.read() << 8 | Wire.read());
}

//T6713 functions-----------------------------------------------
void t6713() {
  int co2Value = readC02();
  {
    Serial.println(CO2ppmValue);
  }
  delay(250);
}

int readC02()
{
  Wire.beginTransmission(ADDR_6713);
  Wire.write(0x04); Wire.write(0x13); Wire.write(0x8B); Wire.write(0x00); Wire.write(0x01);
  Wire.endTransmission();
  delay(2000);
  Wire.requestFrom(ADDR_6713, 4);    // request 4 bytes from slave device
  data[0] = Wire.read();
  data[1] = Wire.read();
  data[2] = Wire.read();
  data[3] = Wire.read();
  CO2ppmValue = ((data[2] * 0xFF ) + data[3]);
}

//iaqcorec2 functions-------------------------------------------
void iaqcorec2() {
  readAllBytes();
  Serial.println(predict);
  delay(250);
}
