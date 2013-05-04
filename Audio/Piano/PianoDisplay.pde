//
// PianoDisplay
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

class PianoDisplay {
  Rect rectOuter;
  Rect rectInner;

  PianoDisplay(Rect r, int space) {
    this.rectOuter = r;
    this.rectInner = new Rect(r.origin.x + space, r.origin.y + space, r.size.w - 2 * space, r.size.h - 2 * space);
  }

  void drawWave(Rect r) {
      int hHalf = r.size.h / 2;
      int yMiddle = r.origin.y + r.size.h / 2;
  
      fill(255);
  
      smooth();

      for (int i = 0; i < r.size.w; ++i) {
    
        int pos = (int) mapValue(0, i, r.size.w - 1, 0, out.bufferSize() - 2);

        line(
          r.origin.x + i,
          yMiddle + out.mix.get(pos) * hHalf,
          r.origin.x + i + 1,
          yMiddle + out.mix.get(pos + 1) * hHalf
        );
    }
  }

  void draw() {
    
    // draw border
    fill(32);
    stroke(128);
    rect(rectOuter.origin.x, rectOuter.origin.y, rectOuter.size.w, rectOuter.size.h);

    // draw lcd
    fill(#9acd32);
    stroke(64);
    rect(rectInner.origin.x, rectInner.origin.y, rectInner.size.w, rectInner.size.h);
    
    // draw lcd content
    stroke(#556b2f);
    noFill();
    drawWave(rectInner);
  }
}



