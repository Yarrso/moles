class Dinosaur
{
  int j, i, x, y, way, digspeed, speed, jumpspeed, digstate;
  int mdTime=0, lasthitway;
  boolean ifend=true, dropend=true;
  Dinosaur()
  {
    j=floor(random(19)+1);
    i=floor(random(40)+5);
    way=floor(random(2));
    digspeed=4;
    speed=4;
    jumpspeed=5;
    digstate=2;
    while (soil[j][i].soilK==0)
    {
      j=floor(random(19)+1);
      i=floor(random(40)+5);
    }
    x=80*(j-1);
    y=170+80*(i-1);
    soil[j][i].soilK=0;
  }
  void display()
  {
    
    if (i-groundhog.I()<=3&&i-groundhog.I()>0)
    {
      moveordig();
    } else if (groundhog.I()-i<=4&&groundhog.I()-i>=0&&abs(groundhog.J()-j)<=5)
    {
      chase();
    } else
    {
      switch(way)
      {
      case 1:
        pushMatrix();
        scale(-1, 1);
        image(dinosaurI[0], -x-80, y+20, 80, 60);
        popMatrix();
        break;
      case 0:
        image(dinosaurI[0], x, y+20, 80, 60);
        break;
      }
    }
  }
  void chase()
  {
    int xD, yD, randomgo;
    int state=0;//1=digordrop() 2=moveordig();
    if (x%80==0&&soil[j][i+1].soilK==0)
    {
      drop();
    } 
    if (x%80==0&&ifend==true)
    {
      if (groundhog.J()>j)  
      {
        xD=groundhog.J()-j;
        yD=groundhog.I()-i;
        randomgo=floor(random(xD+yD)+1);
        if (randomgo>xD)
        {
          state=1;
        } else
        {
          state=2;
        }
        way=1;
      }
      else if (groundhog.J()<j)
      {
        xD=j-groundhog.J();
        yD=groundhog.I()-i;
        randomgo=floor(random(xD+yD)+1);
        if (randomgo>xD)
        {
          state=1;
        } else
        {
          state=2;
        }
        way=0;
      } else if (groundhog.J()==j)
      {
        state=1;
      }
    } 
    else
    {
      state=2;
    }
    if (state==1)
    {
      dig();
    } 
    else 
    {
      if (dropend==true)
      {

        moveordig();
      }
    }
  }
  void digordrop()
  {
    if (soil[j][i+1].soilK!=0)
    {
      dig();
    } else
    {
      drop();
    }
  }
  void dig()
  {
    mdTime++;
    ifend=false;
    int Yhigh, Ybreak;
    Yhigh=170+80*(i-1)-20;
    Ybreak=170+80*(i-1);
    if (mdTime%6<3)
    {
      mdDisplay(0);
    } else
    {
      mdDisplay(1);
    }
    mdTime=mdTime%500;
    if (y<Yhigh)
    {
      digstate=1;
    }
    if (y>Ybreak)
    {
      soil[j][i+1].dig(digspeed);
      digstate=2;
    }
    if (digstate==1)
    {
      y=y+jumpspeed;
    } else
    {
      y=y-jumpspeed;
    }
    if (soil[j][i+1].soilK==0)
    {
      ifend=true;
      drop();
    }
  }
  void drop()
  {
    mdTime++;
    int Ybreak;
    dropend=false;
    Ybreak=170+80*(i);
    y=y+speed;
    if (mdTime%6<3)
    {
      mdDisplay(0);
    } else
    {
      mdDisplay(1);
    }
    mdTime=mdTime%500;
    if (y>=Ybreak)
    {
      i=int((y-130)/80)+1;
      ifend=true;
      dropend=true;
    }
  }
  void moveordig()
  {  
    if (way==0)
    {
      if (soil[j][i].soilK!=0)
      {
        digLR();
      } else
      {
        move();
      }
    }
    if (way==1)
    {
      if (soil[j+1][i].soilK!=0&&j+1<21)
      {
        digLR();
      } else
      {
        move();
      }
    }
  }
  void digLR()
  {
    mdTime++;
    if (way==0)
    {

      soil[j][i].dig(digspeed);
    }
    if (way==1)
    {

      soil[j+1][i].dig(digspeed);
    }
    if (mdTime%6<3)
    {
      mdDisplay(0);
    } else
    {
      mdDisplay(1);
    }
    mdTime=mdTime%500;
  }
  void mdDisplay(int m)
  {
    if (way==1)
    {
      pushMatrix();
      scale(-1, 1);
      image(dinosaurI[m], -x-80, y+20, 80, 60);
      popMatrix();
    } else
    {
      image(dinosaurI[m], x, y+20, 80, 60);
    }
  }
  void move()
  {
    mdTime++;
    if (way==0)
    {
      x -= speed ;
      if (x<=0)
      {
        way=1;
      }
    } else if (way==1)
    {
      x += speed ;
      if (x>=1520)
      {
        way=0;
      }
    }
    j=int((x)/80)+1;
    if (mdTime%6<3)
    {
      mdDisplay(0);
    } else
    {
      mdDisplay(1);
    }
    mdTime=mdTime%500;
  }
  boolean hit()
  {
    if (j==groundhog.J()&&i==groundhog.I())
    {
      return true;
    } else 
    {
      return false;
    }
  }
}