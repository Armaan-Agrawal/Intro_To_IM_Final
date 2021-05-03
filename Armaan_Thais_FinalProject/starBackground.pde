// Constants for gradient
int Y_AXIS = 1;
int X_AXIS = 2;
color c1, c2;

//Variables for background stars

int numStars = 500;

float[] starRadius = new float[numStars];
float[] star_X = new float[numStars];
float[] star_Y = new float[numStars];

color starColor = color(255);

float starSpeed= 0.2;

int maxRadius;

void loadBackgroundComponents()
{
    // Define colors
  c1 = color(0, 0, 0);
  c2 = color(0, 0, 100);

  background.noStroke(); 
  for (int i = 0; i < numStars; i++) {
    maxRadius = int(random(7));
    starRadius[i] = random(3, maxRadius);
    star_X[i] = random(width);
    star_Y[i] = random(height);
  }
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      background.stroke(c);
      background.line(x, i, x+w, i);
    }
  } else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      background.stroke(c);
      background.line(i, y, i, y+h);
    }
  }
}

void drawStars()
{
  background.fill(starColor);
  for (int i = 0; i < numStars; i++) {
    background.ellipse(star_X[i], star_Y[i], starRadius[i], starRadius[i]);
    if (star_X[i] < width) {
      star_X[i]+=starRadius[i]*starSpeed;
    } else {
      star_X[i] = 0;
    }
  }
}
