//
// PianoKeyboard
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

class PianoKey {
  String keyboardKeys;
  Rect position;
  boolean black;
  
  PianoKey(String keyboardKeys, Rect position, boolean black) {
    this.keyboardKeys = keyboardKeys;
    this.position = position;
    this.black = black;
  }
}

class PianoKeyboard
{
  Rect position;
  ComputerKeyboard keyboard;
  KeyToNote notes;

  KeyRenderer blackKeyRenderer;
  KeyRenderer whiteKeyRenderer;

  ArrayList pianoKeys;

  PianoKeyboard(Rect position, String[] whiteKeys, String[] blackKeys, ComputerKeyboard keyboard, KeyToNote notes,
    KeyRenderer whiteKeyRenderer, KeyRenderer blackKeyRenderer) {
    this.position = position;
    this.keyboard = keyboard;
    this.notes = notes;
    this.blackKeyRenderer = blackKeyRenderer;
    this.whiteKeyRenderer = whiteKeyRenderer;

    this.pianoKeys = new ArrayList();
    
    int keyWidth = this.position.size.w / getNumKeysVisible();

    // add white keys
    for (int i = 0; i < whiteKeys.length; ++i) {

      Rect pianoKeyPosition = new Rect(this.position.origin.x + i * keyWidth, this.position.origin.y, keyWidth, this.position.size.h);

      PianoKey pianoKey = new PianoKey(whiteKeys[i], pianoKeyPosition, false);
      
      this.pianoKeys.add(pianoKey);
    }
        
    // draw # keys
    
    for (int ind = 0; ind < blackKeys.length; ++ind) {
      int i = ind % 7;
            
      if (hasSharp(i)) {

        Rect pianoKeyPosition = new Rect(
             this.position.origin.x + ind * keyWidth + keyWidth / 2,
             this.position.origin.y,
             keyWidth,
             this.position.size.h / 2)
             ;
        
        PianoKey pianoKey = new PianoKey(blackKeys[ind], pianoKeyPosition, true);

        this.pianoKeys.add(pianoKey);
      }
    }

  }

  int getNumKeysVisible() {
    return 19;
  }

  void pressed() {
    for (int i = this.pianoKeys.size() - 1; i >= 0; --i) {
      PianoKey pianoKey = (PianoKey) this.pianoKeys.get(i);
    
      if (isCollision(new Point(mouseX, mouseY), pianoKey.position)) {
        keyboard.press(pianoKey.keyboardKeys.charAt(0));
        out.playNote(0, 2.0, this.notes.getNote(pianoKey.keyboardKeys.charAt(0)));
        return;
      }
    }
  }

  void released() {
    for (int i = this.pianoKeys.size() - 1; i >= 0; --i) {
      PianoKey pianoKey = (PianoKey) this.pianoKeys.get(i);
    
      if (isCollision(new Point(mouseX, mouseY), pianoKey.position)) {
        keyboard.release(pianoKey.keyboardKeys.charAt(0));
      }
    }
  }

  boolean hasSharp(int i) {
    return (i == 0) || (i == 1) || (i == 3) || (i == 4) || (i == 5);
  }

  void draw() {
    int keyWidth = this.position.size.w / getNumKeysVisible();

    for (int i = 0; i < this.pianoKeys.size(); ++i) {
      
      PianoKey pianoKey = (PianoKey) this.pianoKeys.get(i);
      
      KeyRenderer keyRenderer = pianoKey.black ? this.blackKeyRenderer : this.whiteKeyRenderer;
      
      boolean anyKeyPressed = false;
      
      for (int j = 0; j < pianoKey.keyboardKeys.length(); ++j) {
        if (this.keyboard.isPressed(pianoKey.keyboardKeys.charAt(j))) {
          anyKeyPressed = true;
        }
      }
      
      keyRenderer.draw(
        pianoKey.position,
        anyKeyPressed
      );
    }
  }
}

