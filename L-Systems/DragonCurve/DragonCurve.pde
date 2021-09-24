//
// Dragon curve L-System (http://en.wikipedia.org/wiki/L-system#Example_7:_Dragon_curve)
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

