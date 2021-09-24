//
// Game Of Life
//

// constants

final int WIN_WIDTH                        = 640;
final int WIN_HEIGHT                       = 480;
final int CELL_SIZE                        = 32;
final int COUNT_NEIGHBOURS_UNDERPOPULATION = 1;
final int COUNT_NEIGHBOURS_OVERPOPULATION  = 4;
final int COUNT_NEIGHBOURS_REPRODUCTION    = 3;
final int INDEX_ITER_CUR                   = 0;
final int INDEX_ITER_NEXT                  = 1;
final int CELL_STATUS_ALIVE                = 1;
final int CELL_STATUS_DEAD                 = 0;
final int BACKGROUND_MAX_R                 = 64;
final int BACKGROUND_MAX_G                 = 32;
final int BACKGROUND_MAX_B                 = 256;
final int TIME_BACKGROUND_ITERATION        = 100;
final int TIME_GAME_ITERATION              = 1000;

// calculated constants

final int GRID_HEIGHT = WIN_HEIGHT / CELL_SIZE;
final int GRID_WIDTH  = WIN_WIDTH  / CELL_SIZE;

// variables

// game of life board data, last index 0 = current iteration, 1 = next iteration
int[][][] data = new int [GRID_HEIGHT][GRID_WIDTH][2];
boolean isPlaying;
float timerBackgroundAnim;
float timerCellsAnim;
PFont fontGameOfLife;
PFont fontControls;
PImage imageCell;
int z;

int convCeToPx(int ce)
{
    return ce * CELL_SIZE;
}

int convPxToCe(int px)
{
    return px / CELL_SIZE;
}

void evolve()
{
    // calculate next iteration from current iteration
    for (int y = 0; y < GRID_HEIGHT; ++y)
    {
        for (int x = 0; x < GRID_WIDTH; ++x)
        {
            boolean canLeft  = x > 0;
            boolean canRight = x < GRID_WIDTH - 1;
            boolean canUp    = y > 0;
            boolean canDown  = y < GRID_HEIGHT - 1;
          
            int dirLeft      = x - 1;
            int dirLeftRight = x;
            int dirRight     = x + 1;
            int dirUp        = y - 1;
            int dirUpDown    = y;
            int dirDown      = y + 1;
          
            int topLeft      = (canUp && canLeft)    ? data[dirUp][dirLeft][INDEX_ITER_CUR]        : 0;
            int topCenter    = (canUp)               ? data[dirUp][dirLeftRight][INDEX_ITER_CUR]   : 0;
            int topRight     = (canUp && canRight)   ? data[dirUp][dirRight][INDEX_ITER_CUR]       : 0;
            int middleLeft   = (canLeft)             ? data[dirUpDown][dirLeft][INDEX_ITER_CUR]    : 0;
            int middleRight  = (canRight)            ? data[dirUpDown][dirRight][INDEX_ITER_CUR]   : 0;
            int bottomLeft   = (canDown && canLeft)  ? data[dirDown][dirLeft][INDEX_ITER_CUR]      : 0;
            int bottomMiddle = (canDown)             ? data[dirDown][dirLeftRight][INDEX_ITER_CUR] : 0;
            int bottomRight  = (canDown && canRight) ? data[dirDown][dirRight][INDEX_ITER_CUR]     : 0;
            
            int aliveNeighbours = topLeft + topCenter + topRight + middleLeft + middleRight + bottomLeft + bottomMiddle + bottomRight;
            
            boolean cellAlive = (data[y][x][0] == 1);
            
            if (cellAlive)
            { 
                if ((aliveNeighbours <= COUNT_NEIGHBOURS_UNDERPOPULATION)
                ||  (aliveNeighbours >= COUNT_NEIGHBOURS_OVERPOPULATION))
                {
                    data[y][x][INDEX_ITER_NEXT] = CELL_STATUS_DEAD;
                }
                else
                {
                    data[y][x][INDEX_ITER_NEXT] = CELL_STATUS_ALIVE;
                }
            }
            else
            {
               if (aliveNeighbours == COUNT_NEIGHBOURS_REPRODUCTION)
               {
                   data[y][x][INDEX_ITER_NEXT] = CELL_STATUS_ALIVE;
               }
            }
        }
    }
    
    // set next iteration as current
    for (int y = 0; y < GRID_HEIGHT; ++y)
    {
        for (int x = 0; x < GRID_WIDTH; ++x)
        {
            data[y][x][0] = data[y][x][1];
        }
    }
}

void drawBackground()
{
    // simple animation using blurred perlin noise
  
    loadPixels();
  
    for (int y = 0; y < height; ++y)
    {
        for (int x = 0; x < width; ++x)
        {
            pixels[y*width+x] = color(noise(x,y,z) * BACKGROUND_MAX_R, BACKGROUND_MAX_G, noise(x,y,z) * BACKGROUND_MAX_B);
        }
    }
    
    updatePixels();

    filter(BLUR, 2.5);
}

void drawGrid()
{
    // draw vertical lines
    for (int x = 0; x < width; x += CELL_SIZE) 
    {
        line(x, 0, x, height);
        stroke(255,255,255,63);
    }
    
    // draw horizontal lines
    for (int y = 0; y < height; y += CELL_SIZE)
    {
        line(0, y, width, y);
        stroke(255,255,255,63);
    }
}

void drawCells()
{
    for (int y = 0; y < GRID_HEIGHT; ++y)
    {
        for (int x = 0; x < GRID_WIDTH; ++x)
        {
            if (data[y][x][INDEX_ITER_CUR] == CELL_STATUS_ALIVE)
            {
                image(imageCell, convCeToPx(x), convCeToPx(y));
            }
        }
    }
}

void updateCells()
{
    float deltaCells = millis() - timerCellsAnim;
      
    if (deltaCells > TIME_GAME_ITERATION)
    {
        timerCellsAnim += TIME_GAME_ITERATION;
 
        if (isPlaying) {
            evolve();
        }
    }
}

void updateBackground()
{
    float deltaBackground = millis() - timerBackgroundAnim;
    
    if (deltaBackground > TIME_BACKGROUND_ITERATION)
    {
        timerBackgroundAnim += TIME_BACKGROUND_ITERATION;
        
        ++z;
    }
}

void drawTextLogo()
{
    textFont(fontGameOfLife);
    fill(255,0,0);
    String logo = "Life (" + (isPlaying ? "playing" : "paused") + ")";
    textAlign(CENTER);
    
    // draw each character into center of its cell
    for (int i = 0; i < logo.length(); ++i)
    {
        text("" + logo.charAt(i), convCeToPx(1 + i) + (CELL_SIZE / 2), convCeToPx(2) - 4);
    }
}

void drawHelp()
{
    fill(0,0,0);
    rect(0,(GRID_HEIGHT - 2) * CELL_SIZE,width,CELL_SIZE);
    fill(255,255,255);
    textFont(fontControls);
    textAlign(CENTER);
    text("Left/Right Click = Place/Erase cell    Space = Start/Stop simulation", width / 2, height - (1.3 * CELL_SIZE));
}

void setup()
{
    size(WIN_WIDTH, WIN_HEIGHT);
    frameRate(30);
    isPlaying = false;
    z = 0;
    fontGameOfLife      = loadFont("DejaVuSansCondensed-32.vlw");
    fontControls        = loadFont("DejaVuSansCondensed-14.vlw");
    imageCell           = loadImage("cell.png");
    timerBackgroundAnim = millis();
    timerCellsAnim      = millis();
}

void draw()
{
    updateBackground();
    updateCells();
    drawBackground();
    drawGrid();
    drawCells();
    drawTextLogo();
    drawHelp();
}

void mousePressed()
{
    data[convPxToCe(mouseY)][convPxToCe(mouseX)][INDEX_ITER_CUR] = (mouseButton == LEFT) ? 1 : 0;  
}

void keyPressed()
{
    if (key == ' ')
    {
        isPlaying = !isPlaying;    
    }
}

