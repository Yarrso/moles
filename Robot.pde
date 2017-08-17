class Robot
{
  int kind, size, j, i, way, shootD, x, y;
  boolean evenhit=false;
  int STime=0;
  Robot()
  {
    kind=floor(random(2));
    size=floor(random(2)+1);
    shootD=floor(random(3)+1);
    j=floor(random(19)+1);
    i=floor(random(50)+1);
    while (soil[j][i].soilK==4||soil[j+1][i].soilK==4||soil[j][i+1].soilK==4||soil[j+1][i+1].soilK==4)
    {
      j=floor(random(19)+1);
      i=floor(random(50)+1);
    }
    x=80*(j-1);
    y=170+80*(i-1);
    if (size==2)
    {
      soil[j][i].soilK=4;
      soil[j+1][i].soilK=4;
      soil[j][i+1].soilK=4;
      soil[j+1][i+1].soilK=4;
    } else
    {
      soil[j][i].soilK=4;
    }
  }
  void display()
  {
    switch(size)
    {
    case 1:
      image(soilC[4], x, y, 80, 80);
      image(robotI[kind], x, y, 70, 80);
      break;
    case 2:
      image(soilC[4], x, y, 160, 160);
      image(robotI[kind], x, y, 150, 160);
      break;
    }
  }
  boolean hit()
  {
    if (!evenhit)
    {
      if (kind==0)
      {
        if (size==1)
        {
          if (groundhog.J()<=j-1&&groundhog.J()>=j-shootD&&groundhog.I()==i)
          {
            evenhit=true;
            return true;
          } else
          {
            return false;
          }
        } else
        {
          if (groundhog.J()<=j-1&&groundhog.J()>=j-shootD&&(groundhog.I()==i||groundhog.I()==i+1))
          {
            evenhit=true;
            return true;
          } else
          {
            return false;
          }
        }
      }
      else 
      {
        if (size==1)
        {
          if (groundhog.J()>=j+1&&groundhog.J()<=j+shootD&&groundhog.I()==i)
          {
            evenhit=true;
            return true;
          } 
          else
          {
            return false;
          }
        } else 
        {
          if (groundhog.J()>=j+2&&groundhog.J()<=j+1+shootD&&(groundhog.I()==i||groundhog.I()==i+1))
          {
            evenhit=true;
            return true;
          } else
          {
            return false;
          }
        }
      }
    } else
    {
      return false;
    }
  }
  void shootdisplay()
  {
    STime=STime+5;
    switch(kind)
    {
    case 0:
      switch(size)
      {
      case 1:
        stroke(218, 224, 0);
        strokeWeight(10);
        for (int k=0; k<shootD; k++)
        {
          line(x-(k*80)-STime, y+40, x-(k*80)+60-STime, y+40);
        }
        break;
      case 2:
        stroke(195, 13, 35);
        strokeWeight(8);
        for (float k=0; k<shootD; k=k+0.1)
        {
          line(x-(shootD*80)+(k*80), 20*sin(x-(shootD*80)+(k*80)-STime)+y+80, x-(shootD*80)+(k*80)+8, 20*sin(x-(shootD*80)+(k*80)+8-STime)+y+80);
        }
        break;
      }
      break;
    case 1:
      switch(size)
      {
      case 1:
        stroke(218, 224, 0);
        strokeWeight(10);
        for (int k=0; k<shootD; k++)
        {
          line(x+(k*80)+STime, y+40, x+(k*80)+60+STime, y+40);
        }
        break;
      case 2:
        stroke(195, 13, 35);
        strokeWeight(8);
        for (float k=0; k<shootD; k=k+0.1)
        {
          line(x+160+k*80, 20*sin(x+160+k*80+STime)+y+80, x+160+k*80+8, 20*sin(x+160+k*80+8+STime)+y+80);
        }
        break;
      }
      break;
    }
    STime=STime%80;
  }
}