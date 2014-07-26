/* 
	FPS_Enroll.ino - Library example for controlling the GT-511C3 Finger Print Scanner (FPS)
	Created by Josh Hawley, July 23rd 2013
	Licensed for non-commercial use, must include this license message
	basically, Feel free to hack away at it, but just give me credit for my work =)
	TLDR; Wil Wheaton's Law

	This sketch will attempt to identify a previously enrolled fingerprint.
*/

#include "FPS_GT511C3.h"
#include "SoftwareSerial.h"
#include <LiquidCrystal.h>
#include <SPI.h>
#include <Ethernet.h>
#include "RestClient.h"

// Hardware setup - FPS connected to:
//	  digital pin 4(arduino rx, fps tx)
//	  digital pin 5(arduino tx - 560ohm resistor fps tx - 1000ohm resistor - ground)
//		this brings the 5v tx line down to about 3.2v so we dont fry our fps

//FPS_GT511C3 fps(15, 14);
FPS_GT511C3 fps(15, 14);
LiquidCrystal lcd(9, 8, 3, 4, 6, 2);
//LiquidCrystal lcd(9, 8, 6, 4, 4, 2);

boolean enroll = false;

//RestClient client = RestClient("enigmatic-meadow-3765.herokuapp.com");
RestClient client = RestClient("enigmatic-meadow-3765.herokuapp.com");

void setup()
{
	Serial.begin(9600);
        lcd.begin(16, 2);

        pinMode(16, OUTPUT);
        pinMode(7, OUTPUT);

        client.dhcp();
  
	delay(100);
	fps.Open();
	fps.SetLED(true);
}

void loop()
{
//  if (enroll) {
//    flashGreen();
//    Serial.println("ENROLL");
//    int enrollid = 0;
//    bool usedid = true;
//     while (usedid == true) {
//      usedid = fps.CheckEnrolled(enrollid);
//      if (usedid==true) enrollid++;
//    }
//    fps.EnrollStart(enrollid);
//    printToLCD("Press finger to", "enroll ID: " + enrollid);
//    while(fps.IsPressFinger() == false) delay(100);
//    bool bret = fps.CaptureFinger(true);
//    int iret = 0;
//    if (bret != false) {
//      fps.SetLED(false);
//      flashGreen();
//      fps.SetLED(true);
//      printToLCD("Remove finger", "");
//      fps.Enroll1();
//      while(fps.IsPressFinger() == true) delay(100);
//      printToLCD("Much good, place", "finger again");
//      delay(1000);
//      while(fps.IsPressFinger() == false) delay(100);
//      bret = fps.CaptureFinger(true);
//      if (bret != false) {
//        fps.SetLED(false);
//        flashGreen();
//        fps.SetLED(true);
//        printToLCD("Remove finger", "");
//        fps.Enroll2();
//        while(fps.IsPressFinger() == true) delay(100);
//        printToLCD("Such amaze, pla-", "ce finger again");
//        while(fps.IsPressFinger() == false) delay(100);
//        bret = fps.CaptureFinger(true);
//        if (bret != false) {
//          fps.SetLED(false);
//          flashGreen();
//          fps.SetLED(true);
//          printToLCD("Remove finger", "");
//          iret = fps.Enroll3();
//          if (iret == 0) {
//            printToLCD("WOW, you be done", "");
//          } else {
//            digitalWrite(7, LOW);
//            digitalWrite(12, HIGH);
//            printToLCD("Error occurred EFF", "");
//          }
//        }
//      }
//    }

//  return;
//  } else {
//    
//  }
//  
  
	// Identify fingerprint test
	if (fps.IsPressFinger())
	{
                Serial.println("FINGER DOWN");
		fps.CaptureFinger(false);
		int id = fps.Identify1_N();
		if (id < 200) {
                        printToLCD("Loading...", "");
                        fps.SetLED(false);
                        digitalWrite(7, LOW);
                        digitalWrite(16, HIGH);

                        String response = "";
                        String es = "false";
//                        if (enroll) {
//                          es = "true";
//                        }
                        
                        String query = "/api/fingerTapped?fingerprint_id=" + String(id) + "&enroll=" + es;
                        char queryBuf[query.length()];
                        query.toCharArray(queryBuf, query.length());
                        int sc = client.get(queryBuf, &response);
                        if (response == "enroll") {
                          enroll = true;
                          return;
                        }
                        
                        lcd.clear();
                        lcd.print(response);
                        Serial.println(response);
                        delay(500);
                        if (response.length() > 16) {
                          for (int position = 0; position  < response.length(); position++) {
                            lcd.scrollDisplayLeft();
                            delay(150);
                          }
                          delay(100);
                        } else {
                          delay(1000);
                        }
                        
                        lcd.clear();
                        digitalWrite(7, HIGH);
                        digitalWrite(16, LOW);
                        fps.SetLED(true);
		}
		else
		{
                  printToLCD("Finger not found", "try again");
                  flashRed();
		}
	}
	else
	{
                digitalWrite(7, HIGH);
                printToLCD("Please place", "finger on reader");
	}
	delay(100);

}

void flashGreen() {
  digitalWrite(7, LOW);
  digitalWrite(16, HIGH);
  delay(1000);
  digitalWrite(7, HIGH);
  digitalWrite(16, LOW);
}

void flashRed() {
  delay(1000);
}

void printToLCD(String lineone, String linetwo) {
  lcd.clear();
  lcd.print(lineone);
  lcd.setCursor(0, 1);
  lcd.print(linetwo);
}
