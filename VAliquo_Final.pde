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

import g4p_controls.*;

Menu mp;
Calculations calc;
ArrayList<Button> buttons;

Button b_run;
String mainText;
String infoText;

GTextArea textArea;


void setup(){
  buildFrame();
  smooth();
  calc = new Calculations();
  buttons = new ArrayList<Button>();
  buttons.add(new Button(550, 40, 100, 50, "Run", 20));
  mainText = "By Monday, more than 70,000 run people shooting had been infected by the coronavirus and over 1,700 had died worldwide" + 
  "according to officials. New infections continue to be confirmed around the world, "+
 " including an American who was identified with the disease in Malaysia on Sunday who had been on a "+
  "cruise ship, raising concerns about another potential cluster outside mainland China.";

  textArea = new GTextArea(this, 0, 0, width/2+40, height-20, G4P.SCROLLBARS_BOTH | G4P.SCROLLBARS_AUTOHIDE);
  textArea.setText(mainText, width/2);
  textArea.setLocalColorScheme(6, true);
  textArea.setSelectedTextStyle(G4P.WEIGHT, G4P.WEIGHT_BOLD);
  textArea.setPromptText("Please enter some text");
}

void draw(){
  background(#e3e6ff);
  for (int i = 0; i < buttons.size(); i++){
    buttons.get(i).drawButton(); //show all the buttons in the arraylist
  }
  scaleVisualizer a = new scaleVisualizer(600, 200);
  a.show();
}

void mousePressed(){
  for (int i = 0; i < buttons.size(); i++){
    if (buttons.get(i).inside()){
      if (buttons.get(0).inside()){
        calc.runEval(textArea.getText());
        String[] textTest = calc.getArray(calc.getSentiment());
        System.out.println(Arrays.toString(textTest));
      }
    }
  }
}

void buildFrame() {
  mp = new Menu(this, "Media", 800, 500);
}