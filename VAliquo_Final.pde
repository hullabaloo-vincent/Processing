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
*  VBZ = Verb 3rd person singular present form
*  VBG = Verb gerund or present participles
*  JJ = Adj
*  JJR = Comparative Adjectives
*  IN = Prepositions and Subordinating Conjunctions (Links nouns, pronouns and phrases to other words in a sentence)
*/

import g4p_controls.*;

Menu mp;
Calculations calc;
scaleVisualizer sentimentVis;
ArrayList<Button> buttons;

int sentNeg, sentNeu, sentPos = 0;
int textLength = 0;
String textSentStart, textSent;
String sentPercent_Neg, sentPercent_Neu, sentPercent_Pos;
color sentColor;

Button b_run;
String mainText;
String infoText;
String log;

GTextArea textArea;
GTextArea calcLog;

void setup(){
  buildFrame();
  smooth();
  sentimentVis = new scaleVisualizer(600, 200);
  calc = new Calculations();
  calc.checkPTerms("");
  buttons = new ArrayList<Button>();
  buttons.add(new Button(550, 40, 100, 50, "Run", 20));
  mainText = "But, despite his endorsements and win by a massive margin in South Carolina's primary on Saturday,"+
 " Biden remains vulnerable on a variety of fronts, including his repeated gaffes. On Monday, he slipped up twice"+
 " during a rally -- at one point, badly garbling the Declaration of Independence before giving up, and at another,"+
 " saying \"Super Thursday\" was coming up.";

  textArea = new GTextArea(this, 0, 0, width/2+40, height/2, G4P.SCROLLBARS_BOTH | G4P.SCROLLBARS_AUTOHIDE);
  textArea.setText(mainText, width/2);
  textArea.setLocalColorScheme(6, true);
  textArea.setSelectedTextStyle(G4P.WEIGHT, G4P.WEIGHT_BOLD);
  textArea.setPromptText("Please enter some text");

  log = "Log";

  calcLog = new GTextArea(this, 0, 240, width/2+40, 200, G4P.SCROLLBARS_BOTH | G4P.SCROLLBARS_AUTOHIDE);
  calcLog.setText(log, width/2);
  calcLog.setLocalColorScheme(6, true);
  calcLog.setSelectedTextStyle(G4P.WEIGHT, G4P.WEIGHT_BOLD);

  textSentStart = "This text is mostly: ";
  textSent = "neutral";
  sentPercent_Neg = "Negative: 0%";
  sentPercent_Neu = "Neutral: 0%";
  sentPercent_Pos = "Positive: 0%";
  sentColor = #c9c9c9;
}

void draw(){
  background(#e3e6ff);
  for (int i = 0; i < buttons.size(); i++){
    buttons.get(i).drawButton(); //show all the buttons in the arraylist
  }
  sentimentVis.show(sentColor);
  fill(#e3e6ff);
  square(500, 200, 400);
  textSize(20);
  fill(0);
  text(textSentStart, 550, 240);
  fill(#7a7a7a);
  text(textSent, 700, 240);
  fill(0);
  textAlign(CENTER, CENTER);
  text(sentPercent_Neg, 610, 270);
  text(sentPercent_Neu, 610, 300);
  text(sentPercent_Pos, 610, 330);
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
  textLength = values.length;
  log = log + "\n" + "_____________________________________";
  log = log + "\n" + "Checking " + values.length + " sentence(s)";
  log = log + "\n" + "_____________________________________";
  calcLog.setText(log, width/2);
  for (int i = 0; i < values.length; i++){

    checkSentence cs = new checkSentence(values[i]);
    //check part of speech
    ArrayList<String> tokenRaw = cs.getToken("PartOfSpeech");
    ArrayList<String> tokenText = cs.getToken("Text");
    ArrayList<String> tokenSentiment = cs.getToken("SentimentClass");

    //check sentence sentiment [negative, neutral, positive]
    String sentenceSentiment = cs.getSentiment();
    calc.sentimentCalc.add(sentenceSentiment); //add calculated sentiment to arraylist
    if (sentenceSentiment.equalsIgnoreCase("Negative")){sentNeg++;}
    if (sentenceSentiment.equalsIgnoreCase("Neutral")){sentNeu++;}
    if (sentenceSentiment.equalsIgnoreCase("Positive")){sentPos++;}

    ArrayList<String> txtToken = calc.getSentenceText(tokenText);
    ArrayList<String> sentimentToken = calc.getSentenceText(tokenSentiment);
    String[] textTest2 = calc.getArray(sentimentToken); //debug
    System.out.println(Arrays.toString(textTest2)); //debug
    ArrayList<String> token = new ArrayList<String>();
    for(int j = 0; j < tokenRaw.size(); j++){
        String cleanOutput = tokenRaw.get(j);
        cleanOutput = cleanOutput.substring(cleanOutput.lastIndexOf("=") + 1);
        cleanOutput = cleanOutput.substring(0, cleanOutput.length() - 1);
        token.add(cleanOutput);
        calc.speechChecker(cleanOutput, values[i], txtToken.get(j), sentimentToken.get(j));
    }
    calc.checkPTerms(values[i]);
    /* Update text and visualizer in realtime */
    // for visualizer, 90 is 0 and 270 is 100
    int max = 0;
    int sentIndex = 0;
    int[] decMax = {sentNeg, sentNeu, sentPos};
    float sentScale = 90;
    for (int counter = 0; counter < decMax.length; counter++){
      if (decMax[counter] > max){
        max = decMax[counter];
        sentIndex = counter;
      }
    }
    if (sentIndex == 0){textSent = "negative";sentColor = #f22222;sentScale = (270+90) / (100/((100 / textLength) * sentNeg));}
    if (sentIndex == 1){
      if (decMax[0] != 0 || decMax[2] != 0){
        if (decMax[0] > decMax[2]){
          //negative is higher
          textSent = "negative";
          sentColor = #f22222;
          sentScale = (270+90) / (100/((100 / textLength) * sentNeg));
        }else{
          //positive is higher
          textSent = "positive";
          sentColor = #2264f2;
          sentScale = (270+90) / (100/((100 / textLength) * sentPos));
        }
      }else{
        textSent = "neutral";
        sentColor = #c9c9c9;
        sentScale = (270+90) / (100/((100 / textLength) * sentNeu));
      }
    }
    if (sentIndex == 2){textSent = "positive";sentColor = #2264f2;sentScale = (270+90) / (100/((100 / textLength) * sentPos));}

    sentimentVis.updateDegree(int(sentScale));
    float negPerc = (100 / textLength) * sentNeg;
    float neuPerc = (100 / textLength) * sentNeu;
    float posPerc = (100 / textLength) * sentPos;
    sentPercent_Neg = "Negative: " + negPerc + "%";
    sentPercent_Neu = "Neutral: " + neuPerc + "%";
    sentPercent_Pos = "Positive: " + posPerc + "%";
  }
  
  String[] textTest = calc.getArray(calc.pTerms);
  log = log + "\n" + "_____________________________________\n Some words that may have triggered the analyzer";
  log = log + "\n" + Arrays.toString(textTest);
  log = log + "\n" + "Comparative Adverb: " + calc.compAdv;
  log = log + "\n" + "Comparative Adjective: " + calc.compAdj;
  log = log + "\n" + "Adverb: " + calc.advb;
  log = log + "\n" + "Interjection: " + calc.interj;
  log = log + "\n" + "Adjective: " + calc.adj;
  log = log + "\n" + "Verb: " + calc.vb;
  log = log + "\n" + "Verb 3rd Person: " + calc.vb3rd;
  log = log + "\n" + "Verb gerund: " + calc.vbg;
  log = log + "\n" + "Common Noun: " + calc.cNoun;
  calcLog.setText(log, width/2);
}



void buildFrame() {
  mp = new Menu(this, "Media", 800, 500);
}
