PVector[] vertice1 = new PVector[360];
PVector[] vertice2 = new PVector[360];

float xPos; 
float yPos; 
int deg = 0;

class scaleVisualizer{
    
    scaleVisualizer(float _xPos, float _yPos){
        xPos = _xPos;
        yPos   = _yPos; 
    }

    void show(int _c){
        float multp     = 100;

        for (int i = 0; i< vertice1.length;i++){
            vertice1[i] = new PVector(xPos + (cos(radians(91+i)) * multp), 
            yPos + (sin(radians(91+i)) * multp));

            vertice2[i] = new PVector(xPos + (cos(radians(91+i - 2)) * multp), 
            yPos + (sin(radians(91+i - 2)) * multp));
        }

        noStroke();
        fill(_c);
        for (int i = 0; i< deg;i++){
            triangle(xPos, yPos, vertice1[i].x, vertice1[i].y, vertice2[i].x, vertice2[i].y);
        }

        // inner circle
        noStroke();
        fill(#2c1752);
        ellipse(xPos, yPos, 130, 130);
        noFill();
        stroke(#2c1752);
        strokeWeight(6);
        //border
        ellipse(xPos, yPos, 200, 200);
        stroke(#e3e6ff);
        strokeWeight(7);
        fill(#e3e6ff);
        arc(xPos, yPos, 200, 200, 0, PI);
    }

    void updateDegree(int _deg){
        deg = _deg;
    }
}