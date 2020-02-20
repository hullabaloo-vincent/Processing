/* 
*  TOKENS
*  "Text", "PartOfSpeech", "Lemma", "Answer", "NamedEntityTag",
*  "CharacterOffsetBegin", "CharacterOffsetEnd", "NormalizedNamedEntityTag",
*  "Timex", "TrueCase", "TrueCaseText", "SentimentClass", "WikipediaEntity"
*/ 

/*
*  PARTS OF SPEECH ABBREVIATIONS
*  NNP = proper noun
*  NNS = Common Nouns (Plural)
*  RB =  Adverbs
*  RBR = Comparative adverbs
*  UH = Interjection
*  VB = Verbs
*  JJ = Adj
*  JJR = Comparative Adjectives
*  IN = Prepositions and Subordinating Conjunctions (Links nouns, pronouns and phrases to other words in a sentence)
*/

Menu mp;
Calculations calc;
ArrayList<Button> buttons;

Button b_run;
String mainText;
String infoText;


void setup(){
  buildFrame();
  calc = new Calculations();
  buttons = new ArrayList<Button>();
  buttons.add(new Button(width/2, height/2, 180, 100, "Run"));
  mainText = "By Monday, more than 70,000 run people shooting had been infected by the coronavirus and over 1,700 had died worldwide" + 
  "according to officials. New infections continue to be confirmed around the world, "+
 " including an American who was identified with the disease in Malaysia on Sunday who had been on a "+
  "cruise ship, raising concerns about another potential cluster outside mainland China.";
  infoText = "Click 'Run' to start";
  //runEval();
}

void draw(){
  background(255);
  for (int i = 0; i < buttons.size(); i++){
    buttons.get(i).drawButton(); //show all the buttons in the arraylist
  }
  textSize(20);
  textAlign(CENTER, CENTER);
  text(infoText, width/2, 100);
}

void mousePressed(){
  for (int i = 0; i < buttons.size(); i++){
    if (buttons.get(i).inside()){
      if (buttons.get(0).inside()){
        calc.runEval();
      }
    }
  }
}

void buildFrame() {
  mp = new Menu(this, "Media", 500, 500);
}