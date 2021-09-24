//
// ComputerKeyToPianoNoteMapper
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

