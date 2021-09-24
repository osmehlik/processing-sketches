//
// Koch curve L-System (http://en.wikipedia.org/wiki/L-system#Example_4:_Koch_curve)
//

int steplength = 16;

void setup()
{
    size(512,256);
    noLoop();
    background(#62016D);
    stroke(#C861D3);
}

void draw() {
    translate(width*9/10, height*9/10);
    rotate(PI);
    render("F", 3);
}

void render(String data, int n)
{
    data = getEvolved(data, n);
    for (int i = 0; i < data.length(); ++i)
    {
        switch(data.charAt(i))
        {
            case 'F': line(0, 0, steplength, 0); translate(steplength, 0); break;
            case '-': rotate(-HALF_PI); break;
            case '+': rotate( HALF_PI); break;
        }
    }
}

String getEvolved(String s, int n)
{
    for (int i = 1; i <= n; i++)
    {
        s = s.replaceAll("F","F+F-F-F+F");
    }
    
    return s;
}

