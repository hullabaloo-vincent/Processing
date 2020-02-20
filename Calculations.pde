class Calculations{

    int compAdv, compAdj, interj, adj, vb = 0;
    ArrayList<String> sentimentCalc = new ArrayList<String>();

    Calculations(){} //init class
    void runEval(String _aText){
        String[] values = _aText.split("\\."); //split text into sentences
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
            sentimentCalc.add(sentenceSentiment); //add calculated sentiment to arraylist

            ArrayList<String> txtToken = getSentenceText(tokenText);
            ArrayList<String> sentimentToken = getSentenceText(tokenSentiment);

            ArrayList<String> token = new ArrayList<String>();
            for(int j = 0; j < tokenRaw.size(); j++){
                String cleanOutput = tokenRaw.get(j);
                cleanOutput = cleanOutput.substring(cleanOutput.lastIndexOf("=") + 1);
                cleanOutput = cleanOutput.substring(0, cleanOutput.length() - 1);
                token.add(cleanOutput);
                speechChecker(cleanOutput, values[i], txtToken.get(j));
            }
        }
    }

    void speechChecker(String _output, String _stringValue, String _txtValue){
        String[] abbr = {"RBR", "JJR", "UH", "JJ", "VB"};
        for (int i = 0; i < abbr.length -1; i++){
            if (_output.equalsIgnoreCase(abbr[i])){
                println("Testing: " + abbr[i]);
                if (_stringValue.indexOf('\"') == -1){
                    incrementValues(i);
                }else{
                    /*there are quotes in this sentence. Run check to see if word is inside quotes or not*/
                    String crop = _stringValue;
                    crop = crop.substring(crop.indexOf("\"") + 1);
                    crop = crop.substring(0, crop.lastIndexOf("\""));
                    if (crop.indexOf(_txtValue) != -1){
                        //inside quotes, don't do anything
                        println("Inside quotes");
                    }else{
                        //outside quotes
                        incrementValues(i);
                        println("Outside quotes");
                    }
                }
            }
        }
    }

    void incrementValues(int _inst){
        switch(_inst){
            case 0:
            compAdv+=1;
            break;
            case 1:
            compAdj+=1;
            break;
            case 2:
            interj+=1;
            break;
            case 3:
            adj+=1;
            break;
            case 4:
            vb+=1;
            break;
        }
    }

    ArrayList<String> getSentenceText(ArrayList<String> _base){
        ArrayList<String> textToken = new ArrayList<String>();
            for(int k = 0; k < _base.size(); k++){
                String cleanTextOutput =  _base.get(k);
                cleanTextOutput = cleanTextOutput.substring(cleanTextOutput.lastIndexOf("=") + 1);
                cleanTextOutput = cleanTextOutput.substring(0, cleanTextOutput.length() - 1);
                textToken.add(cleanTextOutput);
            }
        return textToken;
    }

    String[] getArray(ArrayList<String> al){
        String str[] = new String[al.size()]; 

        for (int j = 0; j < al.size(); j++) { 
            str[j] = al.get(j); 
        } 
        return str;
    }
    
    ArrayList<String> getSentiment(){
        return sentimentCalc;
    }
}

/*

 When there is no more use of t1, make the object referred by t1 eligible for garbage collection */        
  //      t1 = null; 
   
        // calling garbage collector 
     //   System.gc(); 
