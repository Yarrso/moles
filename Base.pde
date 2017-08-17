class Base
{
  Time time;
  int life;
  int ro;
  int meter;
  int wordsize;
  PFont word;
  PImage clockR,Life;
  Base(int r)
  {
    clockR = loadImage( "img/clockR.png" ); 
    Life = loadImage( "img/life.png" ); 
    time= new Time(r);
    life=3;
    if(r==3)
    {
      life=4;
    }
    ro=r;
    meter=0;
    wordsize=32;
    word=createFont("img/word.ttf",wordsize);
  }
  void init()
  {
    time= new Time(ro);
    life=3;
    if(ro==3)
    {
      life=4;
    }
    meter=0;
  }
  void display()
  {
    for(int i=0;i<life;i++)
    {
      image(Life,10+i*70,20,60,60);
    }
    image(round[ro],645,15,142,70);
    meter=groundhog.I();
    fill(255,241,0);
    textFont(word,120);
    if(meter<10)
    {
      text(meter,655,580);
    }
    else
    {
      text(meter,580,580);
    }
    fill(255,255,255);
    textFont(word,60);
    text('m',730,580);
    time.timeChange();
    textFont(word,60);
    text(time.minute,330,70);
    text(':',370,70);
    text(time.secondTens,400,70);
    text(time.secondOnes,440,70);
  }
}