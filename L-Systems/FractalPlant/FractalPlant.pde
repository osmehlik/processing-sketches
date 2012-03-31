//
// Fractal Plant L-System (http://en.wikipedia.org/wiki/L-system#Example_8:_Fractal_plant)
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

float angle = 25, steplength = 2;
int zrot;

void setup()
{
    size(800, 600, P3D);
    frameRate(30);
    stroke(#adff2f);
}

void draw()
{
    translate(width/2, height);
    rotate(radians(-90));
    background(#000000);
    zrot= zrot < 360 ? ++zrot : 0;
    rotateX(radians(zrot));
    angle=25;
    render("X", 6);
}

void render(String p, int n)
{
    if (n >= 0)
    {
        for (int i = 0; i < p.length(); ++i)
        {
            switch(p.charAt(i))
            {
                case 'X': render("F-[[X]+X]+F[+FX]-X", n-1); break;
                case 'F': int x = round(cos(angle) * steplength);
                          int y = round(sin(angle) * steplength);
                          line(0, 0, x, y);
                          translate(x, y);
                          render("FF", n-1);
                          break;
                case '+': rotate(radians(angle)); break;
                case '-': rotate(radians(-angle)); break;
                case '[': pushMatrix(); break;
                case ']': popMatrix();  break;
            }
        }
    }
}

