class Cube {
  float startingZ = -10000;
  float maxZ = 1000;
  
  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;
  
  Cube() {
    // Make the cube appear in a random place
    x = random(0, width);
    y = random(0, height);
    z = random(startingZ, maxZ);
    
    // Give the cube a random rotation
    rotX = random(0, 1);
    rotY = random(0, 1);
    rotZ = random(0, 1);
  }
  
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    // Choose the color, opacity determined by the intensity (volume of the band)
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, intensity*5);
    fill(displayColor, 255);
    
    // Color lines, they disappear with the individual intensity of the cube
    color strokeColor = color(255, 150-(20*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/300));
    
    pushMatrix();
      translate(x, y, z);
    
      // Calculate the rotation according to the intensity for the cube
      sumRotX += intensity*(rotX/1000);
      sumRotY += intensity*(rotY/1000);
      sumRotZ += intensity*(rotZ/1000);
    
      rotateX(sumRotX);
      rotateY(sumRotY);
      rotateZ(sumRotZ);
    
      // Creation of the box, variable size according to the intensity for the cube
      box(100+(intensity/2));
    
    popMatrix();
    
    z+= (1+(intensity/5)+(pow((scoreGlobal/150), 2)));
    
    // Replace the box at the back when it is no longer visible
    if (z >= maxZ) {
      x = random(0, width);
      y = random(0, height);
      z = startingZ;
    }
  }
}