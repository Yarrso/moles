class Soil
{
  int soilK, soilH, j, i;
  Soil(int j, int i, int kind)
  {
    this.j=j;
    this.i=i;
    soilK=kind;
    soilH=kind*8;
  }
  void display()
  {
    if((j<=groundhog.J()+5&&j>=groundhog.J()-5&&i<=groundhog.I()+5&&i>=groundhog.I()-4)||groundhog.J()<5&&j<11||groundhog.I()<4&&i<10||groundhog.J()>15&&j>=11)
    {
      if(soilK==4)
      {
        image(soilC[4], 80*(j-1), 170+80*(i-1), 80, 80);
      }
      else if(soilK>=1)
      { 
        image(soilC[soilK-1], 80*(j-1), 170+80*(i-1), 80, 80);
        tint(255,map(soilH,0,soilK*5,0,255));
        image(soilC[soilK], 80*(j-1), 170+80*(i-1), 80, 80);
        tint(255,255);
      }
      else
      {
        image(soilC[soilK], 80*(j-1), 170+80*(i-1), 80, 80);
      }
    }
  }
  void dig(float digspeed)
  {
    if(soilK!=4)
    {
      soilH=soilH-int(digspeed);
      if(soilH<=0&&soilK!=0)
      {
        soilK--;
        soilH=soilK*8;
      }
    }
  }
}