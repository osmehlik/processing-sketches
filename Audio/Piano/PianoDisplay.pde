//
// PianoDisplay
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



