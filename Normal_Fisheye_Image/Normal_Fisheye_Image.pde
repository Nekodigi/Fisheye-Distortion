//mesh good can deform without inverse formula,but not good when move a lot.

PImage img;
MeshDeform meshDeform;
float noiseS = 500;//noise scale
float noiseP = 0.1;//noise power
Fisheye fisheye;
float fd = 2;//fisheye distortion level

void setup(){
  size(500, 500, P3D);
  fisheye = new Fisheye(200, 2);
  img = loadImage("FevCat.png");
  img.resize(200, 200);//reduce resolution for high speed processing
  meshDeform = new MeshDeform(img, new PVector(0, 0), new PVector(width, height));
  
}

void keyPressed(){
  if(key == 'r'){
    meshDeform.resetCoord();
  }
}

void mouseWheel(MouseEvent event){
  fisheye.distortion += event.getCount()*0.5;
  fisheye.rescale();
}

void draw(){
  background(255);
  fisheye.focus = new PVector(mouseX, mouseY);
  meshDeform.resetCoord();
  PVector[][] target = meshDeform.ctrPoss;
  for(int i=0; i<target[0].length; i++){
    for(int j=0; j<target.length; j++){
      target[i][j] = fisheye.transform(target[i][j]);
    }
  }
  noStroke();
  meshDeform.show();
}
