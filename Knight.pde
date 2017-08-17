class Knight
{
  int j, i, x, y, way, digspeed, speed;
  int mdTime=0, lasthitway;
  Knight()
  {
    j=floor(random(19)+1);
    i=floor(random(40)+5);
    way=floor(random(2));
    digspeed=2;//floor(random(5)+1);
    speed=4;//floor(random(5)+11);
    lasthitway=2;
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
    if (abs(i-groundhog.I())<=3)
    {
      moveordig();
    } else
    {
      switch(way)
      {
      case 0:
        pushMatrix();
        scale(-1, 1);
        image(knightI[0], -x-80, y, 80, 80);
        popMatrix();
        break;
      case 1:
        image(knightI[0], x, y, 80, 80);
        break;
      }
    }
  }
  void moveordig()
  {  
    if (way==0)
    {
        if (soil[j][i].soilK!=0)
        {
          dig();
        }
        else
        {
          move();
        }
    }
    if (way==1)
    {
      if (soil[j+1][i].soilK!=0&&j+1<21)
      {
        dig();
      } else
      {
        move();
      }
    }
  }
  void dig()
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
    if (way==0)
    {
      pushMatrix();
      scale(-1, 1);
      image(knightI[m], -x-80, y, 80, 80);
      popMatrix();
    } else
    {
      image(knightI[m], x, y, 80, 80);
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
      if(way==0)
      {
        if(lasthitway!=way&&groundhog.I()==i&&groundhog.J()==j)
        {
          println(groundhog.J(),j);
          lasthitway=way;
          return true;
        }
        else
        {
          return false;
        }
      }
      else
      {
        if(lasthitway!=way&&groundhog.I()==i&&groundhog.J()==j)
        {
          println(groundhog.J(),j);
          lasthitway=way;
          return true;
        }
        else
        {
          return false;
        }
      }
  }
}