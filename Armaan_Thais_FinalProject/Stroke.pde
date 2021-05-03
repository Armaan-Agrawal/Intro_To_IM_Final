class Stroke {
  float x;
  float y;
  float r;
  color pointColor;
  int lifeSpan;
  int initialLifeSpan;
  int dX = (int)random(0, 2);
  int dY = (int)random(0, 2);
  float initialR;
  float dist;
  float probabilityOfDSwitch = (float)random(0.95, 0.99);

  Stroke(float x_, float y_, float r_, color pointColor_, int lifeSpan_) {
    x = x_;
    y = y_;
    r = r_;
    initialR = r;
    pointColor = pointColor_;
    lifeSpan = lifeSpan_;
    initialLifeSpan = lifeSpan_;
  }

  void update() {
    r = r - (initialR/initialLifeSpan);
    dist = r*0.15;
    if (dX==0) {
      x = x - dist;
    } else {
      x = x + dist;
    }
    if (dY==0) {
      y = y - dist;
    } else {
      y = y + dist;
    }
    dX = getDirection(dX);
    dY = getDirection(dY);
    lifeSpan--;
  }

  void display() {
    
    sketch.noStroke();
    sketch.fill(pointColor);
    sketch.pushMatrix();
    sketch.translate(pos.x, pos.y);
    sketch.rotate(pos.z);
    sketch.ellipse(x, y, r, r);
    sketch.popMatrix();

  }

  boolean status() {
    boolean status;
    if (lifeSpan>0) {
      status = true;
    } else {
      status = false;
    }
    return status;
  }

  int getDirection(int direction) {
    if ((float)random(0, 1)>probabilityOfDSwitch) {
      if (direction==0) {
        direction = 1;
      } else if (direction==1) {
        direction = 0;
      }
    }
    return direction;
  }
}
