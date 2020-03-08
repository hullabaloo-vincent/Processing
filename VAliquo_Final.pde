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
String docText;

GTextArea textArea;
GTextArea calcLog;

boolean revealNeg, revealPos = false;

void setup(){
  buildFrame();
  smooth();
  sentimentVis = new scaleVisualizer(700, 200);
  calc = new Calculations();
  calc.checkPTerms("");
  buttons = new ArrayList<Button>();
  buttons.add(new Button(650, 40, 100, 50, "Run", 20));
  mainText = "But, despite his endorsements and win by a massive margin in South Carolina's primary on Saturday,"+
 " Biden remains vulnerable on a variety of fronts, including his repeated gaffes. On Monday, he slipped up twice"+
 " during a rally -- at one point, badly garbling the Declaration of Independence before giving up, and at another,"+
 " saying \"Super Thursday\" was coming up.";

  textArea = new GTextArea(this, 0, 0, 400+40, height/2, G4P.SCROLLBARS_BOTH | G4P.SCROLLBARS_AUTOHIDE);
  textArea.setText(mainText, 400);
  textArea.setLocalColorScheme(6, true);
  textArea.setSelectedTextStyle(G4P.WEIGHT, G4P.WEIGHT_BOLD);
  textArea.setPromptText("Please enter some text");

  log = "Log";

  calcLog = new GTextArea(this, 0, 240, 400+40, 200, G4P.SCROLLBARS_BOTH | G4P.SCROLLBARS_AUTOHIDE);
  calcLog.setText(log, 400);
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
  square(600, 200, 400);
  textSize(20);
  fill(0);
  text(textSentStart, 650, 240);
  fill(sentColor);
  text(textSent, 800, 240);
  fill(0);
  textAlign(CENTER, CENTER);
  text(sentPercent_Neg, 710, 270);
  text(sentPercent_Neu, 710, 300);
  text(sentPercent_Pos, 710, 330);
  fill(#f22222);
  if (revealNeg){
    text ("Warning: Text contains a very negative sentence", 710, 360);
  }
  if (revealPos){
    text ("Warning: Text contains a very positive sentence", 710, 390);
  }
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
  String tmp = textArea.getText();
  String textCleanup = tmp.replace("...","");
  String[] values = textCleanup.split("\\."); //split text into sentences
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

    //check sentence sentiment [very negative, negative, neutral, positive, very positive]
    String sentenceSentiment = cs.getSentiment();
    String sentimentColorVal = "#c9c9c9";
    String sentimentColorTextVal = "#c9c9c9";

    println(values[i] + " : " + sentenceSentiment);
    calc.sentimentCalc.add(sentenceSentiment); //add calculated sentiment to arraylist
    if (sentenceSentiment.equalsIgnoreCase("Very Negative")){sentNeg++;sentimentColorVal = "#ffa6a6 ";}
    if (sentenceSentiment.equalsIgnoreCase("Neutral")){sentNeu++;sentimentColorVal = "#ebebeb";}
    if (sentenceSentiment.equalsIgnoreCase("Positive")){sentPos++;sentimentColorVal = "#a1bfff";}
    if (sentenceSentiment.equalsIgnoreCase("Very Positive")){sentPos++;sentimentColorVal = "#a1bfff";}

    if (sentenceSentiment.equalsIgnoreCase("Very Negative")){
      revealNeg = true;
    }
    if (sentenceSentiment.equalsIgnoreCase("Very Positive")){
      revealPos = true;
    }

    ArrayList<String> txtToken = calc.getSentenceText(tokenText);
    ArrayList<String> sentimentToken = calc.getSentenceText(tokenSentiment);
    //0 = very negative; 1 = negative; 2 = neutral; 3 = positive; 4 = very positive;
    println("_______________________________________________________________");
    if (!sentimentToken.contains("Negative") && sentenceSentiment.equalsIgnoreCase("Negative")){
      int posValues = 0;
      for (int g = 0; g < sentimentToken.size(); g++){
        if (sentimentToken.get(g).equalsIgnoreCase("Positive")){
          posValues++;
          sentimentColorVal = "#a1bfff";
        }
      }
      println("Pos values: " + posValues);
      if (posValues > 1){
        sentPos++;
        sentimentColorVal = "#a1bfff";
        println("Changing sentence to positive");
      }else{
        sentNeu++;
        sentimentColorVal = "#ebebeb";
        println("Changing sentence to negative");
      }
    }else{
      if (!sentenceSentiment.equalsIgnoreCase("Neutral")){
        sentNeg++;
        sentimentColorVal = "#ffa6a6";
        println("Keeping negative status");
      }
    }

    println("_______________________________________________________________");
    String[] textTest2 = calc.getArray(sentimentToken); //debug
    System.out.println(Arrays.toString(textTest2)); //debug
    ArrayList<String> token = new ArrayList<String>();
    for(int j = 0; j < tokenRaw.size(); j++){
        String cleanOutput = tokenRaw.get(j);
        cleanOutput = cleanOutput.substring(cleanOutput.lastIndexOf("=") + 1);
        cleanOutput = cleanOutput.substring(0, cleanOutput.length() - 1);
        token.add(cleanOutput);

        /*
        #941212 = very negative
        #f22222 = negative
        #c9c9c9 = neutral
        #2264f2 = positive
        #17419c = very positive
        */

        if (sentimentToken.get(j).equalsIgnoreCase("Very Negative")){sentimentColorTextVal = "#941212";}
        if (sentimentToken.get(j).equalsIgnoreCase("Negative")){sentimentColorTextVal = "#f22222";}
        if (sentimentToken.get(j).equalsIgnoreCase("Neutral")){sentimentColorTextVal = "#c9c9c9";}
        if (sentimentToken.get(j).equalsIgnoreCase("Positive")){sentimentColorTextVal = "#2264f2";}
        if (sentimentToken.get(j).equalsIgnoreCase("Very Positive")){sentimentColorTextVal = "#17419c";}

        docText = docText + "<span style=\"background-color:" + sentimentColorVal +";color:" + sentimentColorTextVal + ";\"> " + txtToken.get(j)  + " </span>";
        calc.speechChecker(cleanOutput, values[i], txtToken.get(j), sentimentToken.get(j));
    }
    calc.checkPTerms(values[i]);
    /* Update text and visualizer in realtime */
    // for visualizer, 90 is 0 and 270 is 100
    int max = 0;
    int sentIndex = 0;
    int[] decMax = {sentNeg, sentNeu, sentPos};
    double sentScale = 90;
    for (int counter = 0; counter < decMax.length; counter++){
      if (decMax[counter] > max){
        max = decMax[counter];
        sentIndex = counter;
      }
    }

    if (sentIndex == 0){
      textSent = "negative";
      sentColor = #f22222;
      sentScale = 360 / ((double)100/(((double)100 / textLength) * sentNeg));
    }
    if (sentIndex == 1){
        if ((decMax[1] < decMax[0] && decMax[1] < decMax[2])){
          if (decMax[0] > decMax[2]){
            //negative is higher
            textSent = "negative";
            sentColor = #f22222;
            sentScale = (270+90) / ((double)100/(((double)100 / textLength) * sentNeg));
          }else{
            //positive is higher
            textSent = "positive";
            sentColor = #2264f2;
            sentScale = (270+90) / ((double)100/(((double)100 / textLength)  * sentPos));
          }
      }else{
        textSent = "neutral";
        sentColor = #c9c9c9;
        sentScale = (270+90) / ((double)100/(((double)100 / textLength) * sentNeu));
      }
    }
    if (sentIndex == 2){
      textSent = "positive";
      sentColor = #2264f2;
      sentScale = (270+90) / ((double)100/(((double)100 / textLength) * sentPos));
    }

    sentimentVis.updateDegree(int((float)sentScale));

    double negPerc = (double)100 / calc.sentimentCalc.size() * sentNeg;
    double neuPerc = (double)100 / calc.sentimentCalc.size() * sentNeu;
    double posPerc = (double)100 / calc.sentimentCalc.size() * sentPos;
    println(negPerc);
    sentPercent_Neg = "Negative: " + round((float)negPerc) + "%";
    sentPercent_Neu = "Neutral: " + round((float)neuPerc) + "%";
    sentPercent_Pos = "Positive: " + round((float)posPerc) + "%";
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
  documentExport de = new documentExport(docText, "Testing123");
}

void buildFrame() {
  mp = new Menu(this, "Media", 1000, 500);
}