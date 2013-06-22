
/*
  jjwLogo - modeled after PROCESSINGJS.COM's BASIC EXAMPLE
  @author jjwyse
 */

/* @pjs preload="/personalwebsite/resources/images/jjwLogo_noBlur_50x50.png"; */

// Global variables
PImage img;
int X, Y;
int nX, nY;
int delay = 16;

// Setup the Processing Canvas
void setup()
{
  size( 200, 200 );
  strokeWeight( 10 );
  frameRate( 15 );
  X = width / 2;
  Y = width / 2;
  nX = X;
  nY = Y;
}

// Main draw loop
void draw()
{  
  // Track circle to new destination
  X+=(nX-X)/delay;
  Y+=(nY-Y)/delay;
  
  // Fill canvas grey
  background( #acacac );
  
  // Set fill-color to blue
  fill( 0, 121, 184 );
  
  // Set stroke-color white
  stroke(255);
  
  // Load in small logo image
  img = loadImage("/personalwebsite/resources/images/jjwLogo_noBlur_50x50.png");
  
  // Draw circle
  image(img, X, Y);                  
}


// Set circle's next destination
void mouseMoved(){
  nX = mouseX;
  nY = mouseY;  
}


