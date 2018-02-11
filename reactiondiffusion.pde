float[][] A;
float[][] B;

int rows = 60, cols = 60;

import gifAnimation.*;
GifMaker out;

void setup() {
  size (700, 700, P3D);
  frameRate(30);
  
  A = new float[rows][cols];
  B = new float[rows][cols];
  for (int x = 0; x < rows; x++) {
    for (int y = 0; y < cols; y++) {
      if (abs(y - cols/2) < 10 && abs(x - rows/2) < 10) {
        A[x][y] = 1;
        B[x][y] = 0;
      } else {
        A[x][y] = 1;
        B[x][y] = 0;
      }
    }
  }
  
  
}

float Da = 1, Db = 0.6, f=.0545, k=.062, dt = 1, count = 0;

void draw() {
  background(0);
  strokeWeight(5);
  stroke(255);
  rotateX(0.09);
  
  float[][] A_ = new float[rows][cols];
  float[][] B_ = new float[rows][cols];
  for (int x = 0; x < rows; x++) {
    for (int y = 0; y < cols; y++) {
      float a = A[x][y], b = B[x][y];
      A_[x][y] = a + (Da*conv(x, y, true) - a*b*b + f*(1-a))*dt;
      B_[x][y] = b + (Db*conv(x, y, false) + a*b*b - (k + f)*b)*dt;
    }
  }
  A = A_;
  B = B_;
  for (int x = 0; x < rows; x++) {
    for (int y = 0; y < cols; y++) {
      stroke(100+300*B[x][y]);
      strokeWeight(8*B[x][y]);
      //point(x*width/rows, y*width/cols, 500*B[x][y]);
      point(x*350/rows + 175, y*350/cols + 175, 500*B[x][y]);
    }
  }
  //B[int(20*sin(count/100) + rows/2)][int(20*cos(count/20) + rows/2)] = 0.9;
  B[int(30 + 120*noise(count*0.04))%rows][int(30 + 120*noise(count*0.04 + 100))%cols] = 0.7 ;
  //B[int(120*noise(count*0.02 + 400))%rows][int(120*noise(count*0.02 + 300))%cols] = 0.9;
  count++;
}

float conv(int x, int y, boolean a) {
  float[][]temp;
  if (a) temp = A;
  else temp = B;

  float sum = -temp[x%rows][y%cols];
  sum += 0.2*temp[(x+1)%rows][y%cols];
  sum += 0.2*temp[x%rows][(y+1)%rows];
  sum += 0.2*temp[(x-1+rows)%rows][y%cols];
  sum += 0.2*temp[x%rows][(y-1+cols)%cols];
  sum += 0.05*temp[(x+1)%rows][(y+1)%cols];
  sum += 0.05*temp[(x-1+rows)%rows][(y+1)%cols];
  sum += 0.05*temp[(x-1+rows)%rows][(y-1+rows)%cols];
  sum += 0.05*temp[(x+1)%rows][(y-1+rows)%cols];

  return sum;
}
void mousePressed() {
  B[int(mouseX/60)][int(mouseY/60)] = 0.9;
}