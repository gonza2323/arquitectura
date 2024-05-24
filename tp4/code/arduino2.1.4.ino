void setup() {
  pinMode(2, INPUT);
  pinMode(3, INPUT);
  pinMode(7,OUTPUT);
  pinMode(12,OUTPUT);

  attachInterrupt(digitalPinToInterrupt(2), pulsador1, FALLING);
  attachInterrupt(digitalPinToInterrupt(3), pulsador2, FALLING);
}

void loop() {}

void pulsador1(){
  if (digitalRead(2) == HIGH){
    for(int i=0;i<=40;i+=1){
      if (i%2!=0){
        digitalWrite(7,HIGH);
        for(int j=0;j<=5;j++){
          delayMicroseconds(10000);
        }
        
      }else{
        digitalWrite(7,LOW);
        for(int j=0;j<=5;j++){
          delayMicroseconds(10000);
        }
      }
    }
    digitalWrite(7,HIGH);
    for(int j=0;j<=100;j++){
          delayMicroseconds(10000);
        }
    digitalWrite(7,LOW);
  }
}

void pulsador2(){
  if (digitalRead(3) == HIGH){
    for(int i=0;i<=40;i+=1){
      if (i%2!=0){
        digitalWrite(12,HIGH);
        for(int j=0;j<=5;j++){
          delayMicroseconds(10000);
        }
      }else{
        digitalWrite(12,LOW);
        for(int j=0;j<=5;j++){
          delayMicroseconds(10000);
        }
      }
    }
    digitalWrite(12,HIGH);
    for(int j=0;j<=100;j++){
          delayMicroseconds(10000);
        }
    digitalWrite(12,LOW);
  }
}