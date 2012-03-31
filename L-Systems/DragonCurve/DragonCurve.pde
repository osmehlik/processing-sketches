//
// Dragon curve L-System (http://en.wikipedia.org/wiki/L-system#Example_7:_Dragon_curve)
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

final int n = 10;
final int steplength = 8;

void setup()
{
    size(512,512);
    noLoop();
    background(#138900);
    stroke(#7AE969);
}

void draw()
{
    translate(width/4, height/2);
    rotate(radians(-90));
    render("FX", 0);
}

void render(String data, int iteration)
{
    if (iteration <= n)
    {
        for (int i = 0; i < data.length(); ++i)
        {
            switch(data.charAt(i)) {
                case 'X': render("X+YF+", iteration+1); break;
                case 'Y': render("-FX-Y", iteration+1); break;
                case 'F': line(0, 0, steplength, 0); translate(steplength, 0); break;
                case '-': rotate(radians(-90)); break;
                case '+': rotate(radians(90));  break;
            }
        }
    }
}

