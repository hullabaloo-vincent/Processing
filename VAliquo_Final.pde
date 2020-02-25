/*
*
* Program made by Vincent Aliquo
* MM/DD/2020 | ITGM 326
*
*/

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

int sentNeg, sentNeu, sentPos = 0;

Button b_run;
String mainText;
String infoText;

GTextArea textArea;


void setup(){
  buildFrame();
  smooth();
  calc = new Calculations();
  calc.checkPTerms("");
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
        thread("runEval");
      }
    }
  }
}

void runEval(){
  String[] values = textArea.getText().split("\\."); //split text into sentences
  for (int i = 0; i < values.length; i++){
    infoText = "Checking sentence " + i + " of " + values.length;

    checkSentence cs = new checkSentence(values[i]);
    //check part of speech
    ArrayList<String> tokenRaw = cs.getToken("PartOfSpeech");
    ArrayList<String> tokenText = cs.getToken("Text");
    ArrayList<String> tokenSentiment = cs.getToken("SentimentClass");

    /* Uncomment to debug */
    // String[] textTest = getArray(tokenText);
    // System.out.println(Arrays.toString(textTest));
    // String[] textTest2 = getArray(tokenRaw);
    // System.out.println(Arrays.toString(textTest2));


    //check sentence sentiment [negative, neutral, positive]
    String sentenceSentiment = cs.getSentiment();
    calc.sentimentCalc.add(sentenceSentiment); //add calculated sentiment to arraylist
    if (sentenceSentiment.equalsIgnoreCase("Negative")){sentNeg++;}
    if (sentenceSentiment.equalsIgnoreCase("Neutral")){sentNeu++;}
    if (sentenceSentiment.equalsIgnoreCase("Positive")){sentPos++;}

    ArrayList<String> txtToken = calc.getSentenceText(tokenText);
    ArrayList<String> sentimentToken = calc.getSentenceText(tokenSentiment);

    ArrayList<String> token = new ArrayList<String>();
    for(int j = 0; j < tokenRaw.size(); j++){
        String cleanOutput = tokenRaw.get(j);
        cleanOutput = cleanOutput.substring(cleanOutput.lastIndexOf("=") + 1);
        cleanOutput = cleanOutput.substring(0, cleanOutput.length() - 1);
        token.add(cleanOutput);
        calc.speechChecker(cleanOutput, values[i], txtToken.get(j));
    }
  }
  println("Negative: " + sentNeg);
  println("Neutral: " + sentNeu);
  println("Positive: " + sentPos);
}


void buildFrame() {
  mp = new Menu(this, "Media", 800, 500);
}