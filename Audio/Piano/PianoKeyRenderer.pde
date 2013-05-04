//
// PianoKeyRenderer
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

// key renderer is used to render keys on piano keyboard
interface KeyRenderer {
  void draw(Rect r, boolean pressed);
}

class WhiteKeyRenderer implements KeyRenderer {
  void draw(Rect r, boolean pressed) {
    stroke(127);
    fill(pressed ? 0 : 255);
    rect(r.origin.x, r.origin.y, r.size.w, r.size.h);
  }
}

class BlackKeyRenderer implements KeyRenderer {
  void draw(Rect r, boolean pressed) {
    fill(pressed ? 255 : 0);
    stroke(127);

    color light = color(127);
    color dark = color(pressed ? 64 : 0);

    //rect(r.origin.x, r.origin.y, r.size.w, r.size.h);
    
    int space = r.size.w / 4;

    // top gradient
    beginShape(POLYGON);
      fill(light);
      vertex(r.origin.x, r.origin.y);
      vertex(r.origin.x + r.size.w, r.origin.y);
      fill(dark);
      vertex(r.origin.x + r.size.w - space, r.origin.y + space);
      vertex(r.origin.x + space, r.origin.y + space);
    endShape(CLOSE);

    // right gradient
    beginShape(POLYGON);
      fill(dark);
      vertex(r.origin.x + r.size.w - space, r.origin.y + space);
      fill(light);
      vertex(r.origin.x + r.size.w, r.origin.y);
      vertex(r.origin.x + r.size.w, r.origin.y + r.size.h);
      fill(dark);
      vertex(r.origin.x + r.size.w - space, r.origin.y + r.size.h - space);
    endShape(CLOSE);

    // bottom gradient
    beginShape(POLYGON);
      fill(dark);
      vertex(r.origin.x + space, r.origin.y + r.size.h - space);
      vertex(r.origin.x + r.size.w - space, r.origin.y + r.size.h - space);
      fill(light);
      vertex(r.origin.x + r.size.w, r.origin.y + r.size.h);
      vertex(r.origin.x, r.origin.y + r.size.h);
    endShape(CLOSE);

    // left gradient
    beginShape(POLYGON);
      fill(light);
      vertex(r.origin.x, r.origin.y);
      fill(dark);
      vertex(r.origin.x + space, r.origin.y + space);
      vertex(r.origin.x + space, r.origin.y + r.size.h - space);
      fill(light);
      vertex(r.origin.x, r.origin.y + r.size.h);
    endShape(CLOSE);
    
    fill(dark);
    rect(r.origin.x + space, r.origin.y + space, r.size.w - 2 * space, r.size.h - 2 * space);
  }
}

