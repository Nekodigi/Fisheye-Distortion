//based on this site https://github.com/d3/d3-plugins/blob/master/fisheye/fisheye.js

Fisheye fisheye;
float gridS = 50;//grid size

void setup(){
  size(500, 500);
  fisheye = new Fisheye(2);
}

void draw(){
  background(255);
  //ellipse(width/2, height/2, 10, 10);
  //ellipse(mouseX, mouseY, 10, 10);
  //ellipse(result.x, result.y, result.z*10, result.z*10);
  fisheye.focus = mouseX;
  for(int i=0; i<=width; i+=gridS){
    float movedx = fisheye.transform(i,0,width);
    line(movedx, 0, movedx, height);
  }
  
  fisheye.focus = mouseY;
  for(int j=0; j<=height; j+=gridS){
    float movedy = fisheye.transform(j,0,height);
    line(0, movedy, width, movedy);
  }
}

class Fisheye{
  float distortion;
  float k0, k1;
  float focus;
  
  Fisheye(float distortion){
    this.distortion = distortion;
  }
  
  float transform(float x, float min, float max) {
    boolean left = x < focus;
    float m = left ? focus - min : max - focus;
    if(m == 0) m = max - min;
    return (left ? -1 : 1) * m * (distortion + 1) / (distortion + (m / abs(x - focus))) + focus;
  }
}
