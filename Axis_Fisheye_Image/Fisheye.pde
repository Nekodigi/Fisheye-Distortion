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
