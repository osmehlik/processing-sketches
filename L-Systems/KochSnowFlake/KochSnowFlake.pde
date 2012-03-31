//
// Koch SnowFlake L-System (http://mathworld.wolfram.com/KochSnowflake.html)
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

PFont fontSmall;
PFont fontLarge;

// Well, here you can add your own message to show inside SnowFlake.
String[] message =
{
    "",
    "",
    ""
};

String[] descLeft =
{
    "Koch SnowFlake, a mathematical curve described by string this way:",
    "initial state: F--F--F, next state: rewrite F to F+F--F+F",
    "drawing: F = line forward, -/+ = turn left/right by angle 60°"
};

float rotation = 0;
int level = 4;
int step = 16;
String koch;

String evolveKoch(int level)
{  
    String koch = "F--F--F";
    
    for (int i = 0; i < level; ++i)
    {
        koch = koch.replaceAll("F","F+F--F+F");
    }
    
    return koch;
}

void drawKoch(String koch, float angle, int x, int y, int lineLengthAtLevelZero)
{
    pushMatrix();
  
    float lineLength = lineLengthAtLevelZero / (float)pow(3,level);
    float sideLength = lineLength * pow(3,level);
    float altitude = sideLength * sin(PI/3);

    // draw koch snowflake with centre in the middle of screen

    // move to the center of screen
    translate(x,y);
    // rotate koch snowflake
    rotate(angle);
    // move to the position where to start drawing
    translate(-sideLength / 2, altitude * 1/3.0);
    for (int i = 0; i < koch.length(); ++i)
    {
        switch (koch.charAt(i))
        {
            case '+': rotate(PI/3); break;
            case '-': rotate(-PI/3); break;
            case 'F':
                line(0,0,lineLength,0);
                translate(lineLength,0);
            break;
        }  
    }
    
    popMatrix();
}

void setup()
{
    fontSmall = loadFont("DejaVuSansMono-12.vlw");
    fontLarge = loadFont("DejaVuSansMono-24.vlw");  

    size(800,600);
    frameRate(30);

    koch = evolveKoch(level);

    smooth();
}

void keyPressed()
{
    if ((key == '+') && (level < 11))
    {
        ++level;
        koch = evolveKoch(level);
    }
    if ((key == '-') && (level >  0))
    {
        --level;
        koch = evolveKoch(level);
    }
}

void draw()
{
    rotation += 0.5;
    if (rotation >= 360) rotation -= 360;
  
    background(#4682b4);
    stroke(255, 255, 255);
    
    drawKoch(koch, radians(rotation), width / 2, height / 2, 400);
  
    String[] descRight =
    {
        "level: " + level,
        "number of sides: " + ((int)(3 * pow(4,level))),
        "press -/+ to increase/decrease"
    };
  
    for (int i = 0; i < 3; ++i)
    {
        textFont(fontLarge);
        text(message[i], width / 2 - (textWidth(message[i]) / 2), height / 2 - (2 * step) + (2 * i * step));
        textFont(fontSmall);
        text(descLeft[i], step, height - (3-i) *step);
        text(descRight[i], width - step - textWidth(descRight[i]), height - (3-i) * step);
    }
}

