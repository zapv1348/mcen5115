
#define FANPIN 0
#define CANPIN 1

#define FANPWMPIN 8
#define CANPWMPIN 9
#define FANBLKPIN 10

void setup() {
  pinMode(FANPIN,INPUT);
  pinMode(CANPIN,INPUT);
  pinMode(FANPWMPIN,OUTPUT);
  pinMode(FANBLKPIN,OUTPUT);
  pinMode(CANPWMPIN,OUTPUT);
  pwmWrite(FANPWMPIN,15677);
  delay(3000);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(digitalRead(FANPIN))
  {
    //run fan on arduino it is 61=15677 pwm is initialize, 60=15420 is off, 75=19275 or 80 is on
    //servo is 45=11565 low, and 150=38550 high
    pwmWrite(FANBLKPIN,11565);
    pwmWrite(FANPWMPIN,19275);
    delay(4000);
    pwmWrite(FANBLKPIN,38550);
    pwmWrite(FANPWMPIN,15420);
    delay(1000);
  }
  else
  {
    pwmWrite(FANBLKPIN,11565);
    pwmWrite(FANPWMPIN,15420);
    //turn fan off
  }
  if(digitalRead(CANPWMPIN))
  {
    pwmWrite(CANPWMPIN,65535);
  }
  else
  {
    pwmWrite(CANPWMPIN,0);
  }
}
