//
// MazeViewer
//
// Copyright (c) 2013, Oldrich Smehlik <oldrich@smehlik.net>
// All rights reserved.
//
// Redistribution and use in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
// NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
// AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

class Vec2 {
  int x, y;
    
  Vec2(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

Vec2 directionalMove(Vec2 cur, int dir, int offset) {
    int x = cur.x;
    int y = cur.y;

    switch (dir) {
        case 0: x += offset; break;
        case 1: y += offset; break;
        case 2: x -= offset; break;
        case 3: y -= offset; break;
    }
    
    return new Vec2(x, y);
}

int getCenter(int i) { return i * boxSize + boxSize / 2; }

void lookFromPosToPos(Vec2 lookFrom, Vec2 lookTo) {
  camera(
    getCenter(lookFrom.x), getCenter(lookFrom.y), getCenter(0),
    (getCenter(lookFrom.x) + getCenter(lookTo.x)) / 2, (getCenter(lookFrom.y) + getCenter(lookTo.y)) / 2, getCenter(0),
    0, 0, getCenter(-1));  
}

int[][] level = {
   { 1, 1, 1, 1, 1, 1, 1, 1 },
   { 1, 0, 1, 0, 0, 0, 0, 1 },
   { 1, 0, 1, 0, 1, 1, 0, 1 },
   { 1, 0, 0, 0, 1, 0, 0, 1 },
   { 1, 1, 0, 1, 0, 1, 0, 1 },
   { 1, 0, 0, 0, 0, 1, 0, 1 },
   { 1, 0, 1, 0, 1, 0, 0, 1 },
   { 1, 1, 1, 1, 1, 1, 1, 1 },
};

int levelSize = 8;

int boxSize = 128;

Vec2 curPos = new Vec2(1, 1);
int direction = 1;
// 0 = to next x
// 1 = to next y
// 2 = to prev x
// 3 = to prev y
Vec2 nextPos = directionalMove(curPos, direction, 1);

PImage boxTexture;
PImage groundTexture;

void rotateLeft() {
  direction = (direction - 1);
  if (direction < 0) direction += 4;
  nextPos = directionalMove(curPos, direction, 1);
}

void rotateRight() {
  direction = (direction + 1) % 4;
  nextPos = directionalMove(curPos, direction, 1);
}

void goForward() {
  if (level[nextPos.y][nextPos.x] == 1) {
    return;
  }

  curPos = nextPos;
  nextPos = directionalMove(curPos, direction, 1);
}

void goBackward() {
  Vec2 behindPos = directionalMove(curPos, direction, -1);

  if (level[behindPos.y][behindPos.x] == 1) {
    return;
  }

  nextPos = curPos;
  curPos = behindPos;
}

void drawBox(int w, int h, int d) {
  textureMode(NORMAL);
  
  beginShape(QUADS);
  texture(boxTexture);

  // bottom
  vertex(0, 0, 0, 0, 0);
  vertex(w, 0, 0, 0, 1);
  vertex(w, h, 0, 1, 1);
  vertex(0, h, 0, 1, 0);
  
  // side
  vertex(0, 0, 0, 0, 0);
  vertex(0, h, 0, 0, 1);
  vertex(0, h, d, 1, 1);
  vertex(0, 0, d, 1, 0);

  vertex(0, 0, 0, 0, 0);
  vertex(w, 0, 0, 0, 1);
  vertex(w, 0, d, 1, 1);
  vertex(0, 0, d, 1, 0);

  // opposite side
  vertex(w, 0, 0, 0, 0);
  vertex(w, h, 0, 0, 1);
  vertex(w, h, d, 1, 1);
  vertex(w, 0, d, 1, 0);

  vertex(0, h, 0, 0, 0);
  vertex(w, h, 0, 0, 1);
  vertex(w, h, d, 1, 1);
  vertex(0, h, d, 1, 0);

  // top
  vertex(0, 0, d, 0, 0);
  vertex(w, 0, d, 0, 1);
  vertex(w, h, d, 1, 1);
  vertex(0, h, d, 1, 0);
  
  endShape(CLOSE);
}

void drawGround(int size) {
  beginShape(QUADS);
  texture(groundTexture);
  vertex(0, 0, 0, 0);
  vertex(0, size, 0, 1);
  vertex(size, size, 1, 1);
  vertex(size, 0, 1, 0);
  endShape(CLOSE);
}

void setup() {
  size(512, 512, P3D); 
  boxTexture = loadImage("box.jpg");
  groundTexture = loadImage("grass.jpg");
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
      case LEFT: rotateLeft(); break;
      case RIGHT: rotateRight(); break;
      case UP: goForward(); break;
      case DOWN: goBackward(); break;
    }
    println("current: " + curPos.x + " " + curPos.y);
    println("next: " + nextPos.x + " " + nextPos.y);
  }
}

void draw() {
  background(color(200,240,255));
  lights();
  noStroke();

  // isometric
  //camera(1024 + mouseX, 1024, 1024, levelSize * boxSize / 2, levelSize * boxSize / 2, 0, 0, 0, -1);  
  lookFromPosToPos(curPos, nextPos);

  for (int xx = 0; xx < levelSize; ++xx) {
    for (int yy = 0; yy < levelSize; ++yy) {

      pushMatrix();
      translate(xx * boxSize, yy * boxSize, 0);
      
      drawGround(boxSize);

      if (level[yy][xx] == 1) {
         drawBox(boxSize, boxSize, boxSize);
      }
      //else if (level[yy][xx] == 2) {
      //   translate(boxSize / 2, boxSize / 2, boxSize / 2);
      //   fill(color(255,255,128));
      //   sphere(20);
      //}
      popMatrix();
    }
  }    
}

