  const int motorL1 = 48;
const int motorL2 = 49;
const int motorR1 = 51;
const int motorR2 = 50;
const int enA = 11;
const int enB = 10;
int pinA = 3;                              // Rotary encoder Pin A
int pinB = 2; 

int counter=0;// Rotary encoder Pin B
int pinAstateCurrent = LOW;                // Current state of Pin A
int pinAStateLast = pinAstateCurrent;      // Last read value of Pin A

const int frontEchoPin = 4;
const int frontTriggerPin = 5;
const int leftEchoPin = 13;
const int leftTriggerPin = 12;
const int rightEchoPin = 8;
const int rightTriggerPin = 7;

int l,f,r;

volatile float maxFrontDistance = 30.00;
volatile float frontDuration, frontDistanceCm, leftDuration, leftDistanceCm, rightDuration, rightDistanceCm;
volatile float maxLeftDistance, maxRightDistance = 20.00;

unsigned long timeA,timeB;
  
void setup() {
  Serial.begin (9600);

  pinMode(frontTriggerPin, OUTPUT);
  pinMode(frontEchoPin, INPUT);
  pinMode(leftTriggerPin, OUTPUT);
  pinMode(leftEchoPin, INPUT);
  pinMode(rightTriggerPin, OUTPUT);
  pinMode(rightEchoPin, INPUT);
  
  timeA=millis();
  
  pinMode(motorL1, OUTPUT);
  pinMode(motorL2, OUTPUT);
  pinMode(motorR1, OUTPUT);
  pinMode(motorR2, OUTPUT);

  analogWrite(enA,80);
  analogWrite(enB,160);// Initialise the serial monitor
    
  pinMode (pinA, INPUT);                   // Set PinA as input
  pinMode (pinB, INPUT);                   // Set PinB as input

  // Atach a CHANGE interrupt to PinB and exectute the update function when this change occurs.
  attachInterrupt(digitalPinToInterrupt(pinB), update, CHANGE);  
}

void loop() {
  timeB=millis();

  checkFrontDistance();
  if (frontDistanceCm < maxFrontDistance) {
    //Serial.println("Too close");
    checkLeftDistance();
    delay(20);
    checkRightDistance();
    delay(20);
    if (leftDistanceCm < rightDistanceCm)
      moveRight(counter);
    else if (leftDistanceCm > rightDistanceCm) {
      moveLeft(counter);
    }
  }
  else {
    //Serial.println("OK");
    moveForward();
  }
  // left distance check
  checkLeftDistance();
  if (leftDistanceCm < maxLeftDistance) {
    //Serial.println("Left too close");
    delay(20);
    checkLeftDistance();
    delay(20);
    checkRightDistance();
    delay(20);
    if (leftDistanceCm > rightDistanceCm)
      moveForward();
    else if (leftDistanceCm < rightDistanceCm) {
      moveRight();
    }
  }
  // right distance check
  checkRightDistance();
  if (rightDistanceCm < maxRightDistance) {
    //Serial.println("Right too close");
    delay(20);
    checkRightDistance();
    delay(20);
    checkLeftDistance();
    delay(20);
    if (rightDistanceCm > leftDistanceCm)
      moveForward();
    else if (rightDistanceCm < leftDistanceCm) {
      moveLeft();
    }
  }
    //Serial.print("Counter A: ");
//    Serial.print(counter); 
//    Serial.print(","); 
    l=leftDistanceCm;
//    Serial.print(l); 
//    Serial.print(","); 
    f=frontDistanceCm;
//    Serial.print(f);
//    Serial.print(",");  
    r=rightDistanceCm;
//    Serial.print(r); 
//    Serial.print("\n"); 
      String s1 = String(counter) + "," + String(l) + "," + String(f) + "," + String(r);
      Serial.println(s1);
      

//    if (timeA+5000<timeB)
//    {
//    digitalWrite(motorL1, LOW);
//    digitalWrite(motorL2, LOW);
//    digitalWrite(motorR1, LOW);
//    digitalWrite(motorR2, LOW);
//    Serial.println("Counter A: ");
//    Serial.print(counter);
//    delay(100000);
//    } 
    
}
//
//void update() {
//
//  /* WARNING: For this example I've used Serial.println within the interrupt callback. The Serial 
//   * library already uses interrupts which could cause errors. Therefore do not use functions 
//   * of the Serial libray in your interrupt callback.
//   */
//
//  // ROTATION DIRECTION
//  pinAstateCurrent = (PIND >> 3 & B00001000 >> 3);    // Read the current state of Pin A
//  
//  // If there is a minimal movement of 1 step
//  if ((pinAStateLast == LOW) && (pinAstateCurrent == HIGH)) {
//    
//    if ((PIND & B00000100)) {  
//      counter++; 
//    } else {
//      counter--;
//    }
//    
//  }
//  
//  pinAStateLast = pinAstateCurrent;        // Store the latest read value in the currect state variable
//  
//}
void update()
{
    
    pinAstateCurrent = digitalRead(pinA);
    if (digitalRead(pinB) != pinAstateCurrent) {
      counter ++;
      //Serial.println("CCW");
    } else {
      counter --;
      //Serial.println("CW");
    }
  
  pinAStateLast = pinAstateCurrent;
}
void checkFrontDistance() {
  digitalWrite(frontTriggerPin, LOW);  
  delayMicroseconds(4);
  digitalWrite(frontTriggerPin, HIGH);  
  delayMicroseconds(10);
  digitalWrite(frontTriggerPin, LOW);
  frontDuration = pulseIn(frontEchoPin, HIGH);  
  frontDistanceCm = frontDuration * 10 / 292 / 2;  
//  Serial.print("Front Distance: ");
//  Serial.print(frontDistanceCm);
//  Serial.println(" cm");
}
void checkLeftDistance() {
  digitalWrite(leftTriggerPin, LOW);  //para generar un pulso limpio ponemos a LOW 4us
  delayMicroseconds(4);
  digitalWrite(leftTriggerPin, HIGH);  //generamos Trigger (disparo) de 10us
  delayMicroseconds(10);
  digitalWrite(leftTriggerPin, LOW);
  leftDuration = pulseIn(leftEchoPin, HIGH);  //medimos el tiempo entre pulsos, en microsegundos
  leftDistanceCm = leftDuration * 10 / 292 / 2;  //convertimos a distancia, en cm
//  Serial.print("Left distance: ");
//  Serial.print(leftDistanceCm);
//  Serial.println(" cm");
}
void checkRightDistance() {
  digitalWrite(rightTriggerPin, LOW);  //para generar un pulso limpio ponemos a LOW 4us
  delayMicroseconds(4);
  digitalWrite(rightTriggerPin, HIGH);  //generamos Trigger (disparo) de 10us
  delayMicroseconds(10);
  digitalWrite(rightTriggerPin, LOW);
  rightDuration = pulseIn(rightEchoPin, HIGH);  //medimos el tiempo entre pulsos, en microsegundos
  rightDistanceCm = rightDuration * 10 / 292 / 2;  //convertimos a distancia, en cm
//  Serial.print("Right distance: ");
//  Serial.print(rightDistanceCm);
//  Serial.println(" cm");
}
void moveBackward() {
  //Serial.println("Backward.");
  digitalWrite(motorL1, HIGH);
  digitalWrite(motorL2, LOW);
  digitalWrite(motorR1, HIGH);
  digitalWrite(motorR2, LOW);
}
void moveForward() {
  //Serial.println("Forward.");
  digitalWrite(motorL1, LOW);
  digitalWrite(motorL2, HIGH);
  digitalWrite(motorR1, LOW);
  digitalWrite(motorR2, HIGH);
}
void moveLeft() {
  //Serial.println("Left.");
  digitalWrite(motorL1, LOW);
  digitalWrite(motorL2, HIGH);
  digitalWrite(motorR1, HIGH);
  digitalWrite(motorR2, LOW);
}
void moveRight() {
  //Serial.println("Right.");
  digitalWrite(motorL1, HIGH);
  digitalWrite(motorL2, LOW);
  digitalWrite(motorR1, LOW);
  digitalWrite(motorR2, HIGH);
}
void moveLeft(int a) {
  
  analogWrite(enB,200);
  Serial.println("Left");
  while(a+1600>counter)
  {
  digitalWrite(motorL1, LOW);
  digitalWrite(motorL2, HIGH);
  digitalWrite(motorR1, LOW);
  digitalWrite(motorR2, LOW);
  }
  analogWrite(enB,160);
}
void moveRight(int a) {
  
  analogWrite(enB,200);
  Serial.println("Right");
  while(a-counter!=1600)
  {
  digitalWrite(motorL1, HIGH);
  digitalWrite(motorL2, LOW);
  digitalWrite(motorR1, LOW);
  digitalWrite(motorR2, LOW);
  }
  analogWrite(enB,160);
}
