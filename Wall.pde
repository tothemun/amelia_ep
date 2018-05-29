class Wall {
  float startingZ = -10000;
  float maxZ = 50;
  
  float x, y, z;
  float sizeX, sizeY;
  
  Wall(float x, float y, float sizeX, float sizeY) {
    this.x = x;
    this.y = y;
    this.z = random(startingZ, maxZ);  
    
    // We determine the size because the walls on the floors have a different size than those on the sides
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    // Color determined by low, medium and high sounds
    // Opacity determined by the overall volume
    color displayColor = color(scoreLow * 0.67, scoreMid * 0.67, scoreHi * 0.67, scoreGlobal);
    
    // Make lines disappear in the distance to give an illusion of fog
    fill(displayColor, ((scoreGlobal-5)/1000)*(255+(z/25)));
    noStroke();
    
    // First band, the one that moves according to the force
    pushMatrix();
      translate(x, y, z);
    
      if (intensity > 100) intensity = 100;
      scale(sizeX*(intensity/100), sizeY*(intensity/100), 20);
    
      box(1);
    popMatrix();
    
    // Second band, still the same size
    displayColor = color(scoreLow*0.5, scoreMid*0.5, scoreHi*0.5, scoreGlobal);
    fill(displayColor, (scoreGlobal/5000)*(255+(z/25)));

    pushMatrix();
    translate(x, y, z);
      scale(sizeX, sizeY, 10);
      box(1);
    popMatrix();
    
    z+= (pow((scoreGlobal/150), 2));
    if (z >= maxZ) {
      z = startingZ;  
    }
  }
}