//
// As Procedural As Possible Album Cover
//
// Copyright (c) 2012, Oldrich Smehlik <oldrich@smehlik.net>
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

int WINDOW_SIZE = 512;
int CELL_SIZE = 32;
int CELL_COUNT = WINDOW_SIZE / CELL_SIZE;
PFont font;

void drawGrid()
{
    for (int y = 0; y < CELL_COUNT; ++y) {
        for (int x = 0; x < CELL_COUNT; ++x) {       
            fill(random(2)>=1? #204a87 : #a40000);

            arc(x * CELL_SIZE + (CELL_SIZE/2),
                y * CELL_SIZE + (CELL_SIZE/2),
                CELL_SIZE-2,
                CELL_SIZE-2,
                0, 2*PI);
        }
    }
}

void drawToGrid(String txt, int x, int y)
{
    textAlign(CENTER,CENTER);
    for (int i = 0; i < txt.length(); ++i) {
       text(
           txt.charAt(i),
           (x * CELL_SIZE) + (i * CELL_SIZE) + (CELL_SIZE / 2),
           (y * CELL_SIZE) + (CELL_SIZE / 2) - 2
       );
    }
}


void drawLogo()
{
    fill(255);
    drawToGrid("DJ MyOwnClone",1,9);
    drawToGrid("As Procedural", 1,11);
    drawToGrid("As Possible",1,12);
}

void setup()
{
    size(512,512);
    font = loadFont("Monospaced-28.vlw");
    textFont(font,28);

    background(33);
    
    smooth();
    noStroke();
    
    drawGrid();
    drawLogo();
    
    save("cover.png");
}


