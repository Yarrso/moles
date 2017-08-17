import processing.video.*;
import ddf.minim.*;
int state=1;//1=start 2=start movie 3=1movie 4=1 5=1over
PImage bg, home, start1, start2, gameover, restart1, restart2, skip1, skip2, hit;
Movie start, r1, r2, r3, end;
Minim minim;
AudioPlayer song,ggsong;
AudioSample molehit,click,soildig;
PImage[] soilC=new PImage[5], robotI=new PImage[2], knightI= new PImage[2], dinosaurI =new PImage[2], round= new PImage[4];
int[] powertime= new int[50];
int soilKind;
int hittime;
boolean gameready=false;
Soil[][] soil=new Soil[21][60];
Groundhog groundhog;
Robot[] robot=new Robot[30];
Knight[] knight=new Knight[40];
Dinosaur[] dinosaur=new Dinosaur[35];
Base base;
Power[] power=new Power[50];
Clock[] clock=new Clock[15];
float bgTran;
void setup ()
{
  size(800, 600);
  bg = loadImage( "img/bg.jpg" ); 
  home = loadImage( "img/home.jpg" );
  start1 = loadImage( "img/start1.png" );
  start2 = loadImage( "img/start2.png" );
  gameover= loadImage( "img/gameover.jpg" );
  restart1= loadImage( "img/restart1.png" );
  restart2= loadImage( "img/restart2.png" );
  skip1= loadImage( "img/skip1.png" );
  skip2= loadImage( "img/skip2.png" );
  hit= loadImage( "img/hit.jpg" );
  round[1]=loadImage("img/round1.png");
  round[2]=loadImage("img/round2.png");
  round[3]=loadImage("img/round3.png");
  soilC[0]=loadImage( "img/yellow1.png" ); 
  soilC[1]=loadImage( "img/brown1.png" ); 
  soilC[2]=loadImage( "img/grey1.png" ); 
  soilC[3]=loadImage( "img/black1.png" );
  soilC[4]=loadImage( "img/yellow2.png" );
  robotI[0]=loadImage( "img/robot0.png" );
  robotI[1]=loadImage( "img/robot1.png" );
  knightI[0]=loadImage( "img/knight0.png" );
  knightI[1]=loadImage( "img/knight1.png" );
  dinosaurI[0]=loadImage( "img/dinosaur0.png" );
  dinosaurI[1]=loadImage( "img/dinosaur1.png" );
  start = new Movie(this, "start.mov");
  minim =new Minim(this);
  song= minim.loadFile("data/1.mp3");
  ggsong= minim.loadFile("data/gameover.mp3");
  molehit= minim.loadSample("data/mole.mp3",512);
  click= minim.loadSample("data/click.mp3",512);
  soildig=minim.loadSample("data/soil.mp3",512);
  r1 = new Movie(this, "round1.mov");
  r2 = new Movie(this, "round2.mov");
  r3 = new Movie(this, "round3.mov");
  end = new Movie(this, "end.mov");
  groundhog=new Groundhog();
  song.play();
  song.loop();
  ggsong.play();
  ggsong.loop();
}

void draw ()
{
  switch(state)
  {
  case 1:
    ggsong.pause();
    image(home, 0, 0, 800, 600);
    image(start1, 300, 430, 200, 83 );
    if (mouseX>=300&&mouseX<=500&&mouseY>=430&&mouseY<=513)
    {
      if (mousePressed)
      {
        song.pause();
        click.trigger();
        state= 2;
      } else
      {
        image(start2, 300, 430, 200, 83 );
      }
    }
    break;
  case 2:
    image(start, 0, 0, 800, 600);
    start.play();
    image(skip1, 740, 540, 50, 50 );
    float a=start.time();
    if (a>41||(mouseX>=740&&mouseX<=790&&mouseY>=540&&mouseY<=593))
    {
      if (mousePressed||a>41)
      {
        start.stop();
        state=3;
      } else
      {
        image(skip2, 740, 540, 50, 50 );
      }
    }
    break;
  case 3:
    image(r1, 0, 0, 800, 600);
    r1.play();
    image(skip1, 740, 540, 50, 50 );
    float b=r1.time();
    if (b>17||(mouseX>=740&&mouseX<=790&&mouseY>=540&&mouseY<=593))
    {
      if (mousePressed||b>17)
      {
        r1.stop();
        state=4;
      }
      else
      {
        image(skip2, 740, 540, 50, 50 );
      }
    }
    break;
  case 4:
    round1();
    break;
  case 5:
    gameover(5);
    break;
  case 6:
    image(r2, 0, 0, 800, 600);
    r2.play();
    image(skip1, 740, 540, 50, 50 );
    float c=r2.time();
    if (c>11||(mouseX>=740&&mouseX<=790&&mouseY>=540&&mouseY<=593))
    {
      if (mousePressed||c>11)
      {
        r2.stop();
        state=7;
      } else
      {
        image(skip2, 740, 540, 50, 50 );
      }
    }
    break;
  case 7:
    round2();
    break;
  case 8:
    gameover(8);
    break;
  case 9:
    image(r3, 0, 0, 800, 600);
    r3.play();
    image(skip1, 740, 540, 50, 50 );
    float d=r3.time();
    if (d>9||(mouseX>=740&&mouseX<=790&&mouseY>=540&&mouseY<=593))
    {
      if (mousePressed||d>9)
      {
        r3.stop();
        state=10;
      } else
      {
        image(skip2, 740, 540, 50, 50 );
      }
    }
    break;
  case 10:
    round3();
    break;
  case 11:
    gameover(11);
    break;
  case 12:
    image(end, 0, 0, 800, 600);
    end.play();
    image(skip1, 740, 540, 50, 50 );
    float e=r3.time();
    if (e>16||(mouseX>=740&&mouseX<=790&&mouseY>=540&&mouseY<=593))
    {
      if (mousePressed||e>16)
      {
        end.stop();
        song.rewind();
        song.play();
        state=1;
      } else
      {
        image(skip2, 740, 540, 50, 50 );
      }
    }
    break;
  }
}
void keyPressed() 
{
  groundhog.keyPressed(keyCode) ;
}
void keyReleased() 
{
  groundhog.keyReleased(keyCode) ;
}
void movieEvent(Movie m) 
{
  m.read();
}
void round1()
{  
  if (!gameready)
    {
      song.rewind();
      base= new Base(1);
      for (int i=1; i<60; i++)
      {
        for (int j=1; j<21; j++)
        {
          soil[j][i]=new Soil(j, i, floor(random(3)+1));
        }
      }
      for (int i=0; i<30; i++)
      {
        robot[i]=new Robot();
      }
      for (int i=0; i<15; i++)
      {
        power[i]=new Power();
        clock[i]=new Clock();
      }
      gameready=true;
    }
    image(bg, 0, 0, 800, 600);
    song.play();
    pushMatrix();
    translate(-(groundhog.bgTran-360), -(groundhog.Y-90));
    for (int i=0; i<3; i++)
    {
      image(bg, i*800, 0);
    }
    for (int i=1; i<60; i++)
    {
      for (int j=1; j<21; j++)
      {
        soil[j][i].display();
      }
    }

    for (int i=0; i<30; i++)
    {
      if (!robot[i].evenhit)
      {
        robot[i].shootdisplay();
      }
      if (robot[i].hit())
      {
        molehit.trigger();
        hittime=3;
      }
    }
    hittime--;
    if (hittime>0)
    {
      tint(255, 120);
      imageMode(CENTER);
      image(hit, groundhog.J()*80, 90+groundhog.I()*80, 2000, 2000);
      imageMode(CORNER);
      tint(255, 255);
    }
    strokeWeight(5);
    stroke(255, 0, 0);
    line(0, 90+50*80, 1600, 90+50*80);
    if (hittime==0)
    {
      base.life--;
    }
    for (int i=0; i<30; i++)
    {
      robot[i].display();
    }
    for (int i=0; i<15; i++)
    {
      power[i].display();
      if (power[i].hit())
      {
        power[i].everhit=true;
        powertime[i]=base.time.minute*60+base.time.secondTens*10+base.time.secondOnes;
        groundhog.digSpeed=groundhog.digSpeed*5;
      }
      if (powertime[i]-(base.time.minute*60+base.time.secondTens*10+base.time.secondOnes)>=5&&power[i].everhit)
      {
        power[i].everhit=false;
        groundhog.digSpeed=groundhog.digSpeed/5;
      }
      clock[i].display();
      if (clock[i].hit())
      {
        base.time.secondOnes=base.time.secondOnes+5;
      }
    }
    popMatrix();
    groundhog.display();
    base.display();
    if (base.life<=0||(base.time.minute*60+base.time.secondTens*10+base.time.secondOnes)<=0)
    {
      song.pause();
      base.init();
      groundhog.init();
      gameready=false;
      ggsong.rewind();
      state=5;
    }
    if (base.meter>=50)
    {
      base.init();
      song.pause();
      groundhog.init();
      gameready=false;
      state=6;
    }
}
void round2()
{
  if (!gameready)
    {
      song.rewind();
      base= new Base(2);
      for (int i=1; i<60; i++)
      {
        for (int j=1; j<21; j++)
        {
          soil[j][i]=new Soil(j, i, floor(random(3)+1));
        }
      }
      for (int i=0; i<40; i++)
      {
        knight[i]=new Knight();
      }
      for (int i=0; i<15; i++)
      {
        power[i]=new Power();
        clock[i]=new Clock();
      }
      gameready=true;
    }
    image(bg, 0, 0, 800, 600);
    song.play();
    pushMatrix();
    translate(-(groundhog.bgTran-360), -(groundhog.Y-90));
    for (int i=0; i<3; i++)
    {
      image(bg, i*800, 0);
    }
    for (int i=1; i<60; i++)
    {
      for (int j=1; j<21; j++)
      {
        soil[j][i].display();
      }
    }
    for (int i=0; i<40; i++)
    {
      if (knight[i].hit())
      {
        groundhog.cry=true;
        molehit.trigger();
        hittime=3;
      }
    }
    hittime--;
    if (hittime>0)
    {
      tint(255, 120);
      imageMode(CENTER);
      image(hit, groundhog.J()*80, 90+groundhog.I()*80, 2000, 2000);
      imageMode(CORNER);
      tint(255, 255);
    }
    strokeWeight(5);
    stroke(255, 0, 0);
    line(0, 90+50*80, 1600, 90+50*80);
    if (hittime==0)
    {
      base.life--;
    }
    for (int i=0; i<15; i++)
    {
      power[i].display();
      if (power[i].hit())
      {
        power[i].everhit=true;
        powertime[i]=base.time.minute*60+base.time.secondTens*10+base.time.secondOnes;
        groundhog.digSpeed=groundhog.digSpeed*5;
      }
      if (powertime[i]-(base.time.minute*60+base.time.secondTens*10+base.time.secondOnes)>=5&&power[i].everhit)
      {
        power[i].everhit=false;
        groundhog.digSpeed=groundhog.digSpeed/5;
      }
      clock[i].display();
      if (clock[i].hit())
      {
        base.time.secondOnes=base.time.secondOnes+5;
      }
    }
    for (int i=0; i<40; i++)
    {
      knight[i].display();
    }
    popMatrix();
    groundhog.display();
    base.display();
    if (base.life<=0||(base.time.minute*60+base.time.secondTens*10+base.time.secondOnes)<=0)
    {
      song.pause();
      ggsong.rewind();
      base.init();
      groundhog.init();
      gameready=false;
      state=8;
    }
    if (base.meter>=50)
    {
      base.init();
      song.pause();
      groundhog.init();
      gameready=false;
      state=9;
    }
}
void round3()
{
  if (!gameready)
    {
      song.rewind();
      base= new Base(3);
      for (int i=1; i<60; i++)
      {
        for (int j=1; j<21; j++)
        {
          soil[j][i]=new Soil(j, i, floor(random(3)+1));
        }
      }
      for (int i=0; i<35; i++)
      {
        dinosaur[i]=new Dinosaur();
      }
      for (int i=0; i<15; i++)
      {
        clock[i]=new Clock();
      }
      for (int i=0; i<50; i++)
      {
        power[i]=new Power();
      }
      gameready=true;
    }
    image(bg, 0, 0, 800, 600);
    song.play();
    pushMatrix();
    translate(-(groundhog.bgTran-360), -(groundhog.Y-90));
    for (int i=0; i<3; i++)
    {
      image(bg, i*800, 0);
    }
    for (int i=1; i<60; i++)
    {
      for (int j=1; j<21; j++)
      {
        soil[j][i].display();
      }
    }
    for (int i=0; i<35; i++)
    {
      if (dinosaur[i].hit())
      {
        molehit.trigger();
        dinosaur[i].x=-80;
        dinosaur[i].y=-80;
        dinosaur[i].i=0;
        dinosaur[i].j=0;
        hittime=3;
      }
    }
    hittime--;
    if (hittime>0)
    {
      tint(255, 120);
      imageMode(CENTER);
      image(hit, groundhog.J()*80, 90+groundhog.I()*80, 2000, 2000);
      imageMode(CORNER);
      tint(255, 255);
    }
    strokeWeight(5);
    stroke(255, 0, 0);
    line(0, 90+50*80, 1600, 90+50*80);
    if (hittime==0)
    {
      base.life--;
    }
    for (int i=0; i<15; i++)
    {
      clock[i].display();
      if (clock[i].hit())
      {
        base.time.secondOnes=base.time.secondOnes+5;
      }
    }
    for (int i=0; i<50; i++)
    {
      power[i].display();
      if (power[i].hit())
      {
        power[i].everhit=true;
        powertime[i]=base.time.minute*60+base.time.secondTens*10+base.time.secondOnes;
        groundhog.digSpeed=groundhog.digSpeed*5;
      }
      if (powertime[i]-(base.time.minute*60+base.time.secondTens*10+base.time.secondOnes)>=5&&power[i].everhit)
      {
        power[i].everhit=false;
        groundhog.digSpeed=groundhog.digSpeed/5;
      }
    }
    for (int i=0; i<35; i++)
    {
      dinosaur[i].display();
    }
    popMatrix();
    groundhog.display();
    base.display();
    if (base.life<=0||(base.time.minute*60+base.time.secondTens*10+base.time.secondOnes)<=0)
    {
      song.pause();
      ggsong.rewind();
      base.init();
      groundhog.init();
      gameready=false;
      state=11;
    }
    if (base.meter>=50)
    {
      base.init();
      song.pause();
      groundhog.init();
      gameready=false;
      state=12;
    }
}
void gameover(int instate)
{  
  ggsong.play();
    image(gameover, 0, 0, 800, 600);
    image(restart1, 300, 450, 200, 83 );
    if (mouseX>=300&&mouseX<=500&&mouseY>=430&&mouseY<=513)
    {
      if (mousePressed)
      {
        ggsong.pause();
        click.trigger();
        base.life=3;
        groundhog.X=360;
        groundhog.Y=90;
        state=instate-1;
      } 
      else
      {
        image(restart2, 300, 450, 200, 83 );
      }
    }
}