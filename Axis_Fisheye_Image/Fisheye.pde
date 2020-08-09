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
