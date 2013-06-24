class Word
{
  int count;
  String word;

  Word (String s)
  {
    word = s;
    count = 1;
  } 

  void increaseCount()
  {
    count ++;
  }

  String getText()
  {
    return word;
  }
  
  int getCount()
  {
     return count; 
  }
 }

