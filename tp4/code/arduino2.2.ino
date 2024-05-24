
const int TRIGGER_PULSE_TIME = 15;
const int TRIGGER_PIN = 5;
const int ECHO_PIN = 4;
const int ALARM_TOGGLE_PIN = 2;
const int ALARM_CALC_INTERVAL = 800;
const int ACTIVATION_DISTANCE = 100;

bool alarmActivated = false;
bool buttonPressed = false;
unsigned long timePressed = 0;
bool buttonActive = true;
bool LEDsOn = false;

void setup() {
    Serial.begin(9600);
    pinMode(TRIGGER_PIN, OUTPUT);
    pinMode(ECHO_PIN, INPUT);
    pinMode(ALARM_TOGGLE_PIN, INPUT);
    
    for(int pin = 6; pin <= 13; pin++)
        pinMode(pin, OUTPUT);
    
    buttonPressed = digitalRead(ALARM_TOGGLE_PIN);
    
    attachInterrupt(digitalPinToInterrupt(ALARM_TOGGLE_PIN),
                    buttonToggleRoutine,
                    CHANGE);
}

void buttonToggleRoutine() {
    buttonActive = true;
    buttonPressed = !buttonPressed;  
    if (buttonPressed)
        timePressed = millis();
}

void loop() {
    handleInput();
    
    float distance = getDistance();
    
    Serial.print(distance, 1);
    Serial.print(" cm. ");
    
    if (alarmActivated) {
        Serial.println("Alarma activada.");
        if (distance && distance < ACTIVATION_DISTANCE) {
        Serial.println("INTRUSO DETECTADO!");
        toggleLEDs();
        }
        else
        turnOffLEDs();
    }
    else
        Serial.println("Alarma desactivada.");
    
    delay(ALARM_CALC_INTERVAL);
}

void handleInput() {
    if (buttonPressed && buttonActive) {
        unsigned long currentTime = millis();
        if (currentTime - timePressed > 5000) {
        alarmActivated = !alarmActivated;
        buttonActive = false;
        turnOffLEDs();
        }
    } 
}

float getDistance() {
    digitalWrite(TRIGGER_PIN, LOW);
    delayMicroseconds(TRIGGER_PULSE_TIME);
    digitalWrite(TRIGGER_PIN, HIGH);
    delayMicroseconds(TRIGGER_PULSE_TIME);
    digitalWrite(TRIGGER_PIN, LOW);
    
    return pulseIn(ECHO_PIN, HIGH, 350 * 58) / 58.0;
}

void toggleLEDs() {
    LEDsOn = !LEDsOn;
    for(int i = 6; i <= 13; i++)
        digitalWrite(i, LEDsOn);
}

void turnOffLEDs() {
    LEDsOn = false;
    for(int i = 6; i <= 13; i++)
        digitalWrite(i, LOW);
}