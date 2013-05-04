//
// Types
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

class Point {
  int x, y;
    
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class Size {
  int w, h;

  Size(int w, int h) {
    this.w = w;
    this.h = h;
  }
}

class Rect {
  Point origin;
  Size size;
    
  Rect(int x, int y, int w, int h) {
    this.origin = new Point(x, y);
    this.size = new Size(w, h);
  }
}

boolean isCollision(Point p, Rect r)
{
  boolean c1, c2, c3, c4;
    
  c1 = p.x < r.origin.x;
  c2 = p.y < r.origin.y;
  c3 = p.x > r.origin.x + r.size.w;
  c4 = p.y > r.origin.y + r.size.h;

  return c1 || c2 || c3 || c4 ? false : true;
}

