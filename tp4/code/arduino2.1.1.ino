void setup() {
  pinMode(2, INPUT);
  pinMode(7,OUTPUT);
}

int count=6;

void loop() {
  if (digitalRead(2) == HIGH){
    for(int i=0;i<=4;i+=1){
      if (i%2!=0){
        digitalWrite(7,HIGH);
        delay(0.01);
      }else{
        digitalWrite(7,LOW);
        delay(50);
      }
    }
    digitalWrite(7,HIGH);
    delay(1000);
  }
}