class Calculations{

    int compAdv, compAdj, interj, adj, vb = 0;
    ArrayList<String> sentimentCalc = new ArrayList<String>();
    ArrayList<String> pTerms = new ArrayList<String>(); //adds problematic terms to array

    Calculations(){} //init class
    void runEval(String _aText){
        String[] values = _aText.split("\\."); //split text into sentences
        for (int i = 0; i < values.length; i++){
        
            checkSentence cs = new checkSentence(values[i]); //initiates NLP API and runs a sentence through it
            //get raw data collected through the NLP API
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

    void checkPTerms(String _aText){
       try{ 
            String programDir =  dataPath("");
            String aWords = new Scanner(new File(programDir + "//Alerts.words")).useDelimiter("\\A").next();
            String[] aWordsSplit = aWords.split("\\,");
            
            for (int i = 0; i < aWordsSplit.length; i++){
                //check if word word is present in string
                if (_aText.indexOf(aWordsSplit[i]) != -1){
                   if (!insideQuotes(_aText,aWordsSplit[i])){
                       println("Problem word found: " + aWordsSplit[i]);
                       pTerms.add(aWordsSplit[i]);
                   }
                }
            }
        }catch(FileNotFoundException fx){
            println("Couldn't find word library");
        }
    }

    /*----------------------------------------*/
    /* Check if potentially problamatic parts of speech are present in the sentence*/
    void speechChecker(String _output, String _stringValue, String _txtValue){
        String[] abbr = {"RBR", "JJR", "UH", "JJ", "VB"};
        for (int i = 0; i < abbr.length -1; i++){
            if (_output.equalsIgnoreCase(abbr[i])){
                println("Testing: " + abbr[i]);
                if (_stringValue.indexOf('\"') == -1){
                    incrementValues(i);
                }else{
                    /*there are quotes in this sentence. Run check to see if word is inside quotes or not*/
                    if (insideQuotes(_stringValue, _txtValue)){
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
    /*----------------------------------------*/

    /*----------------------------------------*/
    /* FIncrement parts of speech */
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
    /*----------------------------------------*/

    /*----------------------------------------*/
    /* Function to check whether _text is inside quotes present in String _input */
    boolean insideQuotes(String _input, String _text){
        String crop = _input;
        crop = crop.substring(crop.indexOf("\"") + 1);
        crop = crop.substring(0, crop.lastIndexOf("\""));
        if (crop.indexOf(_text) != -1){
            //inside quotes
            return true;
        }else{
            //outside quotes
            return false;
        }
    }
    /*----------------------------------------*/

    
    /*----------------------------------------*/
    /* Turns the raw data from the NLP API into an easily readable string */
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
    /*----------------------------------------*/

    /*----------------------------------------*/
    /* Converts ArrayList into string array */
    String[] getArray(ArrayList<String> al){
        String str[] = new String[al.size()]; 

        for (int j = 0; j < al.size(); j++) { 
            str[j] = al.get(j); 
        } 
        return str;
    }
    /*----------------------------------------*/
    
    ArrayList<String> getSentiment(){
        return sentimentCalc;
    }
}