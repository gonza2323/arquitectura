void setup() {
  pinMode(3, INPUT);
  pinMode(12,OUTPUT);
}

void loop() {
  if (digitalRead(3) == HIGH){
    for(int i=0;i<=40;i+=1){
      if (i%2!=0){
        digitalWrite(12,HIGH);
        delay(50);
      }else{
        digitalWrite(12,LOW);
        delay(50);
      }
    }
    digitalWrite(12,HIGH);
    delay(1000);
    digitalWrite(12,LOW);
    }
  }