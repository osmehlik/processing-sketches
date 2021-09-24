//
// Types
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

