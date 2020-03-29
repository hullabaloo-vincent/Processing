class Button {
  
  float x,y;
  int bW, bH;
  int textSize;
  boolean isHovering;
  boolean isSelected;
  String buttonText;
  
  Button(float _x, float _y, int _width, int _height, String _buttonText, int _textSize){
    x = _x;
    y = _y;
    bW = _width;
    bH = _height;
    buttonText = _buttonText;
    textSize = _textSize;
  }
  
  void drawButton(){
    noStroke();
    rectMode(CORNER);
    if (inside() || isSelected){
      fill(#2c1752);
    }else{
      fill(#8376ff);
    }
    rect(x, y, bW, bH, 7); //draw the button and round the corners
    textAlign(CENTER, CENTER); //centers text
    if (inside() || isSelected){
      fill(#ffffff);
    }else{
      fill(#000000);
    }
    textSize(textSize);
    text(buttonText, x+(bW/2), y+(bH/2)-2);
  }
  
  boolean inside(){
    if (mouseX >= x && mouseX <= x+bW && mouseY >= y && mouseY <= y+bH) {
      return true;
    } else {
      return false;
    }
  }
}