//based on this site https://github.com/d3/d3-plugins/blob/master/fisheye/fisheye.js

Fisheye fisheye;
float gridS = 50;//grid size

void setup(){
  size(500, 500);
  fisheye = new Fisheye(200, 2);
}

void draw(){
  background(255);
  fisheye.focus = new PVector(mouseX, mouseY);
  //ellipse(width/2, height/2, 10, 10);
  //ellipse(mouseX, mouseY, 10, 10);
  //ellipse(result.x, result.y, result.z*10, result.z*10);
  noFill();
  for(int i=0; i<=width; i+=gridS){
    beginShape();
    for(int j=0; j<=height; j+=gridS){
      PVector moved = fisheye.transform(new PVector(i, j));
      vertex(moved.x, moved.y);
    }
    endShape();
  }
  
  for(int j=0; j<=height; j+=gridS){
    beginShape();
    for(int i=0; i<=width; i+=gridS){
      PVector moved = fisheye.transform(new PVector(i, j));
      vertex(moved.x, moved.y);
    }
    endShape();
  }
}

class Fisheye{
  float radius;
  float distortion;
  float k0, k1;
  PVector focus = new PVector();
  
  Fisheye(float radius, float distortion){
    this.radius = radius;
    this.distortion = distortion;
    rescale();
  }
  
  PVector transform(PVector p){
    PVector d = PVector.sub(p, focus);
    float dd = d.mag();
    if (dd >= radius) return new PVector(d.x+focus.x, d.y+focus.y, dd >= radius ? 1 : 10);
    float k = k0 * (1 - exp(-dd * k1)) / dd * .75 + .25;
    return new PVector(focus.x + d.x * k, focus.y + d.y * k, Math.min(k, 10));
  }
  
  void rescale() {
    k0 = exp(distortion);
    k0 = k0 / (k0 - 1) * radius;
    k1 = distortion / radius;
  }
}
