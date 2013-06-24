import java.util.Iterator;

HashMap words;

String [] tokens;
int counter;

PFont f;

void setup()
{ 
 size(1200, 800);
 words = new HashMap();
 
 // Load file and chop it up
 String[] lines = loadStrings("jamesOne.txt");
 String allText = join(lines, " ");
 tokens = splitTokens(allText, " ,.?!:;[]-");
 f = createFont("Georgia", 26, true);
}

void draw(){
  background(255);
  fill(0);
  
  // Look at words one at a time
  String s = tokens[counter];
  counter = (counter + 1) % tokens.length;
  
  // Is the word in the HashMap
  if (words.containsKey(s)) {
    // Get the word object and increase the count
    // We access objects from a HashMap via its key, the String
    Word w = (Word) words.get(s);
    w.count();
  } else {
    // Otherwise make a new word
    Word w = new Word(s);
    // And add to the HashMap
    // put() takes two arguments, "key" and "value"
    // The key for us is the String and the value is the Word object
    words.put(s, w);
  }
  
  // Make an iterator to look at all the things in the HashMap
  Iterator i = words.values().iterator();
  
  // x and y will be used to locate each word
  float x = 0;
  float y = height-10;
  
  while(i.hasNext()) {
    //Look at each word
    Word w = (Word) i.next();
    
    // Only display words that appear 2 times
    if (w.count > 2){
      // The size is the count
      int fsize = constrain(w.count + 20, 0, 100);
      textFont (f, fsize);
      text(w.word, x, y);
      // Move along the x-axis
      x += textWidth(w.word + " ");
    }
    
    // If x gets to teh end, move Y
    if (x > width){
      x = 0;
      y -= 100;
      // If y gets to the end we're done
      if (y < 0){
        break;
      }
    }
  }
}
