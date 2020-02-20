PVector[] vertice1 = new PVector[360];
PVector[] vertice2 = new PVector[360];

float xPos; 
float yPos; 
int deg = 360;
PFont font;

class scaleVisualizer{
    
    scaleVisualizer(float _xPos, float _yPos){
        xPos = _xPos;
        yPos   = _yPos; 
    }

    void show(){
        float multp     = 100;
        font = createFont("Helvetica", 35);

        for (int i = 0; i< vertice1.length;i++){
            vertice1[i] = new PVector(xPos + (cos(radians(91+i)) * multp), 
            yPos + (sin(radians(91+i)) * multp));

            vertice2[i] = new PVector(xPos + (cos(radians(91+i - 2)) * multp), 
            yPos + (sin(radians(91+i - 2)) * multp));
        }

        deg = int(map( mouseY, 0, height, 0, 360));

        noStroke();
        fill(255, 227, 13, 130);
        for (int i = 0; i< deg;i++){
            triangle(xPos, yPos, vertice1[i].x, vertice1[i].y, vertice2[i].x, vertice2[i].y);
        }

        // inner circle
        noStroke();
        fill(0);
        ellipse(xPos, yPos, 130, 130);
        noFill();
        stroke(0);
        strokeWeight(6);
        //border
        ellipse(xPos, yPos, 200, 200);
        textFont(font, 35);
        stroke(#e3e6ff);
        strokeWeight(7);
        fill(#e3e6ff);
        arc(xPos, yPos, 200, 200, 0, PI);
    }
}