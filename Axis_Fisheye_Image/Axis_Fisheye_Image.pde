//mesh good can deform without inverse formula,but not good when move a lot.

PImage img;
MeshDeform meshDeform;
float noiseS = 500;//noise scale
float noiseP = 0.1;//noise power
Fisheye fisheye;
float fd = 2;//fisheye distortion level

void setup(){
  //fullScreen(P3D);
  size(500, 500, P3D);
  fisheye = new Fisheye(2);
  img = loadImage("FevCat.png");
  img.resize(400, 400);//reduce resolution for high speed processing
  meshDeform = new MeshDeform(img, new PVector((width-height)/2, 0), new PVector(width-(width-height)/2, height));
  
}

void keyPressed(){
  if(key == 'r'){
    meshDeform.resetCoord();
  }
}

void mouseWheel(MouseEvent event){
  fisheye.distortion += event.getCount()*0.1;
  fisheye.distortion = max(-1+EPSILON, fisheye.distortion);//-1<distortion
}

void draw(){
  background(255);
  meshDeform.resetCoord();
  PVector[][] target = meshDeform.ctrPoss;
  for(int i=0; i<target[0].length; i++){
    for(int j=0; j<target.length; j++){
      fisheye.focus = mouseX;
      target[i][j].x = fisheye.transform(target[i][j].x, (width-height)/2, width-(width-height)/2);
      fisheye.focus = mouseY;
      target[i][j].y = fisheye.transform(target[i][j].y, 0, height);
    }
  }
  noStroke();
  meshDeform.show();
}
