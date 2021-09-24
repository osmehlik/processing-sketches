//
// Piano
//
 
import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioOutput out;

KeyToNote keyToNote;
ComputerKeyboard computerKeyboard;
PianoKeyboard pianoKeyboard;
PianoDisplay pianoDisplay;

void setup() {
  size(1024, 768, P2D);
 
  minim = new Minim(this);

  out = minim.getLineOut(Minim.STEREO);

  keyToNote = new KeyToNote();
  computerKeyboard = new ComputerKeyboard();
  
  String[] basicKeys = {"z", "x", "c", "v", "b", "n", "m", ",q", ".w", "/e", "r", "t", "y", "u", "i", "o", "p", "[", "]"};
  String[] sharpKeys = {"s", "d", ".", "g", "h", "j", ".", "2", "3", ".", "5", "6", "7", ".", "9", "0", ".", "="};
  
  pianoKeyboard = new PianoKeyboard(
    new Rect(width / 4, height / 4, width / 2, height / 2),
    basicKeys,
    sharpKeys,
    computerKeyboard,
    keyToNote,
    new WhiteKeyRenderer(),
    new BlackKeyRenderer()
  );
  pianoDisplay = new PianoDisplay(
    new Rect(width / 2 - 128, height / 5 - 16 - 32, 256, 64),
    8
  );
}


void circle(int x, int y, int r) {
  fill(color(0));
  arc(x, y, r, r, 0, TWO_PI);
}

void drawRepro(int cx, int cy, int wdots, int hdots, int dotscdist) {
  
  int x = cx - (wdots * dotscdist / 2);
  int y = cy - (hdots * dotscdist / 2);
  
  for (int xx = 0; xx < wdots; ++xx) {
    for (int yy = 0; yy < hdots; ++yy) {
      circle(x + (xx * dotscdist), y + (yy * dotscdist), 8);
    }
  }
}

void draw() {
  clear();
  
  fill(32);
  stroke(128);

  // draw keyboard background
  rect(width / 12, height / 5, width * 10 / 12, height * 3 / 5);
  
  // draw keys
  pianoKeyboard.draw();
  
  drawRepro(width * 1/6, height/2, 8, 16, 16);
  drawRepro(width * 5/6, height/2, 8, 16, 16);

  pianoDisplay.draw();
}

void keyPressed() {
  if (key == CODED) return;
  if (computerKeyboard.isPressed(key)) return;

  computerKeyboard.press(key);

  String note = keyToNote.getNote(key);

  if (note != null) { out.playNote(0, 2.0, note); }
}

void keyReleased() {
  if (key == CODED) return;

  computerKeyboard.release(key);
}

void mousePressed() {
  pianoKeyboard.pressed();
}

void mouseReleased() {
  pianoKeyboard.released();
}

void stop() {
  out.close();
  minim.stop();

  super.stop();
}

