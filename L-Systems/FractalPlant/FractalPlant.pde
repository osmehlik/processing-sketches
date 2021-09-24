//
// Fractal Plant L-System (http://en.wikipedia.org/wiki/L-system#Example_8:_Fractal_plant)
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

