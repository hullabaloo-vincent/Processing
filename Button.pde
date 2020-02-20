class Button {
  
  float x,y;
  int bW, bH;
  boolean isHovering;
  boolean isSelected;
  String buttonText;
  
  Button(float _x, float _y, int _width, int _height, String _buttonText){
    x = _x;
    y = _y;
    bW = _width;
    bH = _height;
    buttonText = _buttonText;
  }
  
  void drawButton(){
    noStroke();
    rectMode(CORNER);
    if (inside() || isSelected){
      fill(#ffbfbf);
    }else{
      fill(#fff0f0);
    }
    rect(x, y, bW, bH, 7); //draw the button and round the corners
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(40);
    text(buttonText, x+(bW/2), y+(bH/2)-5);
  }
  
  boolean inside(){
    if (mouseX >= x && mouseX <= x+bW && mouseY >= y && mouseY <= y+bH) {
      return true;
    } else {
      return false;
    }
  }
}