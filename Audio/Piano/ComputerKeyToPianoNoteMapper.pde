//
// ComputerKeyToPianoNoteMapper
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

// maps keyboard key to note name
class KeyToNote {
  HashMap<Character, String> notes = new HashMap();

  KeyToNote() {
    String scale = "CDEFGAB";
    String keys3 = "zxcvbnm";
    String keys4 = "qwertyu";
        
    for (int i = 0; i < scale.length(); ++i) {  
      this.notes.put(keys3.charAt(i), scale.charAt(i) + "3");
      this.notes.put(keys4.charAt(i), scale.charAt(i) + "4");
    }
    
    this.notes.put(',', "C4");
    this.notes.put('.', "D4");
    this.notes.put('/', "E4");
    this.notes.put('i', "C5");
    this.notes.put('o', "D5");
    this.notes.put('p', "E5");
    this.notes.put('[', "F5");
    this.notes.put(']', "G5");
    
    this.notes.put('9', "C#5");
    this.notes.put('0', "D#5");
    this.notes.put('=', "F#5");
    
    String scaleSharp = "CDFGA";
    String keys3Sharp = "sdghj";
    String keys4Sharp = "23567";
      
    for (int i = 0; i < scaleSharp.length(); ++i) {  
      this.notes.put(new Character(keys3Sharp.charAt(i)), scaleSharp.charAt(i) + "#3");
      this.notes.put(new Character(keys4Sharp.charAt(i)), scaleSharp.charAt(i) + "#4");
    }
  }

  String getNote(char keyboardKey) {
    return this.notes.containsKey(keyboardKey) ? new String(this.notes.get(keyboardKey)) : null;
  }
}

