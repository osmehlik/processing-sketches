//
// PianoKeyRenderer
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

