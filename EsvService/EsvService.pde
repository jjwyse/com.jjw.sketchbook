import java.net.URL;
import java.net.URLEncoder;
import java.util.Iterator;

HashMap words;
boolean firstTime;
String []tokens;
int index;
PFont a;

ArrayList<TextField> fields = new ArrayList<TextField>();
TextField activatedField;
boolean fieldActive;

String book = "";
String chapter = "";

ArrayList <String> ignore;

void setup()
{
  size(1200, 800);

  // text box for entering scripture
  fields.add (new TextField(width - 225, 40, 425, 70)); 

  words = new HashMap();
  a = loadFont("CenturyGothic-48.vlw");
  textFont(a, 48);

  fieldActive = false;

  // updates the wordle
  updateScripture();
}

void draw()
{
    ((TextField)fields.get(0)).update();

}

void updateScripture()
{
  // clearWords
  words.clear();
  background(200);

  String scripture = getPassage(book,chapter);
  tokens = splitTokens(scripture, " ,.?!:;[]-");

  for(int i = 0; i < tokens.length; i ++)
  {
    String temp = tokens[i];

    if(words.containsKey(temp))
    {
      Word w = (Word) words.get(temp);
      w.increaseCount();
    } 
    else 
    {
      // Otherwise make a new word
      Word w = new Word(temp);

      // And add to the HashMap
      // put() takes two arguments, "key" and "value"
      // The key for us is the String and the value is the Word object
      words.put(temp, w);
    }
  }
  showRepeatedWords();
}

void showRepeatedWords()
{
  Iterator i = words.values().iterator();
  while(i.hasNext())
  {
    Word w = (Word) i.next();
    if((w.count > 4) && (w.getText().length() > 3 ) && (w.getText().substring(0, 1) != "-"))
    {
      boolean rotated = false;
      println(w.getText());
      fill(random(0, 255), random(0, 255), random(0, 255));
      textSize(w.getCount() * 5);
      if(random(0,10) > 5) { 
        rotate(90); 
        rotated = true;
      }
      text(w.getText(), random(10, width - 100), random(25, height - 25));
      textSize(48);
    }
  }
}

/**
 * Retrieves the specified book and chapter using the ESV web service call
 */
String getPassage(String book, String chapter)
{
  String passage = "";
  try
  {
    StringBuilder urlStringBuilder = new StringBuilder();
    urlStringBuilder.append("http://www.esvapi.org/v2/rest/passageQuery?key=IP");
    urlStringBuilder.append("&passage="
      + URLEncoder.encode(book + " " + chapter, "ISO-8859-1"));
    //urlStringBuilder.append("&output-format=crossway-xml-1.0");
    urlStringBuilder.append("&output-format=plain-text");
    urlStringBuilder.append("&include-headings=false");
    urlStringBuilder.append("&include-audio-link=false");

    URL esvURL = new URL(urlStringBuilder.toString());
    InputStream esvStream = esvURL.openStream();

    StringBuilder outStringBuilder = new StringBuilder();
    int nextChar;

    while ((nextChar = esvStream.read()) != -1) 
    {
      outStringBuilder.append((char) nextChar);
    }
    esvStream.close();

    passage =  outStringBuilder.toString();
  }
  catch (Exception e)
  {
    print("error");
  }

  return passage;
}

void setScripture(String bookChapter)
{
  if(bookChapter != "")
  {
    String tokens[] =  splitTokens(bookChapter, " ");
    book = tokens[0].toLowerCase();
    print(book + "\n");
    chapter = tokens[1].toLowerCase();
    print(chapter + "\n");

    updateScripture();
  }
}

