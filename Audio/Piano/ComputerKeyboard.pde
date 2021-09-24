//
// ComputerKeyboard
//

// keyboard stores pressed status of keys
class ComputerKeyboard {
  boolean[] keys = new boolean[256];

  boolean isPressed(int keyboardKey) {
    return this.keys[keyboardKey];
  }

  void press(int keyboardKey) {
    this.keys[keyboardKey] = true;
  }

  void release(int keyboardKey) {
    this.keys[keyboardKey] = false;
  }
}

