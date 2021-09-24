//
// As Procedural As Possible Album Cover
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


