
class TextField 
{
  String contents = "";
  float numEntry; // if the contents are a number, this gets updated
  boolean numEntered = false; // marked as "not a number" to start
  float x,y,w,h; // xloc, yloc, width, height

  TextField(float _x, float _y, float _w, float _h) 
  {
    x=_x;
    y=_y;
    w=_w;
    h=_h;
  }

  void update() 
  {
    if (activatedField==this) 
    {
      fill(200,200,255);
    }
    else
    { 
      fill(255);
      rect(x-w/2,y-h/2,w,h);
    }

    if (numEntered)
    {
      fill(0,0,255);
    }
    else 
    {
      fill(0);
    }

    if (activatedField==this)
    { 
      text(contents, x-w/2+5, y-h/4, w-5, h);
    }
    else 
    {
      text(contents, x-w/2+5, y-h/4, w-5, h);
    }
  }

  void mouseCheck() 
  {
    if ((mouseX>=x-w/2) && (mouseX<= x+w/2) && (mouseY<y+h/2) && (mouseY>y-h/2))
    {
      fieldActive=true;
      activatedField=this;
    }
  }

  void updateContents() 
  {
    setScripture(contents);
  }
}

void mousePressed() 
{
  if (fieldActive) updateActiveField();
  for (int i=fields.size()-1;i>=0;i--) 
  { 
    // run in reverse so visually front field gets priority
    if (!fieldActive) ((TextField)fields.get(i)).mouseCheck();
  }
}

void updateActiveField() 
{
  activatedField.updateContents();
  fieldActive=false;
  activatedField=null;
}

void keyPressed() 
{
  if (fieldActive) 
  {
    if ((keyCode==ENTER) || (keyCode==RETURN)) 
    {
      updateActiveField();
    }
    else if (((keyCode==DELETE) || (keyCode==BACKSPACE)) && (activatedField.contents.length() > 0))
    {
      activatedField.contents = activatedField.contents.substring(0, activatedField.contents.length() - 1);
      print("activatedField.contents: " + activatedField.contents);
    }
    else
    {
      activatedField.contents += key;
      print("activatedField.contents: " + activatedField.contents);
    }
  }
}

