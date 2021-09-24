//
// One Dimensional Elementary Cellular Automata.
// (Value of cell in next iteration depends on value of cell and its neighbours from previous iteration.)
//

// constants

final int WIN_WIDTH  = 512;
final int WIN_HEIGHT = 512;
final int CELL_SIZE  = 8;

// variables

ElementaryCellularAutomaton ca;
int rule;

int[] toBinary(int number)
{
    int a[] = new int[8];
    int i = 0;
  
    while (number > 0)
    {
        a[i] = number % 2;
        ++i;
        number /= 2;
    }
    
    a = reverse(a);
    
    return a;
}

int toDecimal(int [] number)
{
    int multiplier = 0;
    int sum = 0;
    
    for (int i = number.length - 1; i >= 0; --i)
    {
        if (number[i] != 0)
        {
            sum += pow(2,multiplier);
        }
        multiplier += 1;
    }
    
    return sum;
}

class ElementaryCellularAutomaton
{
    int   rulesDecimal;
    int[] rulesBinary = new int[8];

    color colorFalse;
    color colorTrue;

    ElementaryCellularAutomaton(int rule, int cellSize)
    {
        colorFalse = color(0);
        colorTrue  = color(255);
        
        setRule(rule);
    }
  
    void setRule(int rule)
    {
        rulesDecimal = rule;
        rulesBinary = toBinary(rule);
    }
  
    // returns value of cell in next generation from values of cells in previous generation
    int evolve(int left, int center, int right)
    {
        int[] topLine = new int[3];
        
        topLine[0] = left;
        topLine[1] = center;
        topLine[2] = right;
  
        int decimal = toDecimal(topLine);

        return rulesBinary[(rulesBinary.length - 1) - decimal];
    }

    // returns values of cellular automata in next generation
    int[] evolveLine(int[] oldLine)
    {
        int[] newLine = new int[oldLine.length];

        for (int i = 0; i < newLine.length; ++i)
        {
            if (i == 0)                        newLine[i] = evolve(0,oldLine[i],oldLine[i+1]);
            else if (i == newLine.length - 1)  newLine[i] = evolve(oldLine[i-1],oldLine[i],0);
            else                               newLine[i] = evolve(oldLine[i-1],oldLine[i],oldLine[i+1]);
        }
  
        return newLine;
    }

    void paint()
    {
        int countCellsHorizontally = WIN_WIDTH  / CELL_SIZE;
        int countCellsVertically   = WIN_HEIGHT / CELL_SIZE;

        // prepare initial conditions
        
        int[] lastLine = new int[countCellsHorizontally*2];
        lastLine[countCellsHorizontally] = 1;
        int offset = countCellsHorizontally/2;
        
        // draw cellular automaton
        
        for (int cy = 0; cy < countCellsVertically; ++cy)
        {
            for (int cx = 0; cx < countCellsHorizontally; ++cx)
            {
                int x = CELL_SIZE * cx;
                int y = CELL_SIZE * cy;
            
                if (lastLine[offset+cx] != 0) fill(colorTrue); else fill(colorFalse);
                rect(x, y, CELL_SIZE, CELL_SIZE);
            }
            
            lastLine = evolveLine(lastLine);
        }
        
        // draw description
        
        fill(0);
        rect(0,WIN_HEIGHT-32,WIN_WIDTH,32);
        
        PFont font;
        font = loadFont("DejaVuSansMono-Bold-32.vlw");
        fill(255);
        String s = "RULE " + rulesDecimal;
        textAlign(CENTER);
        text(s, 0, WIN_HEIGHT-24,WIN_WIDTH,32);
    } 
}

void setup()
{
    size(WIN_WIDTH, WIN_HEIGHT);

    rule = 30;
    ca = new ElementaryCellularAutomaton(rule,8);
    ca.paint();
}

void draw()
{
}

void keyPressed()
{
    if (key == CODED)
    {
        if (keyCode == RIGHT)
        {
            rule = rule < 255 ? rule + 1 : 0;
            ca.setRule(rule);
            ca.paint();
        }
        if (keyCode == LEFT)
        {
            rule = rule > 0 ? rule - 1 : 255;
            ca.setRule(rule);
            ca.paint();
        }
    }
}

