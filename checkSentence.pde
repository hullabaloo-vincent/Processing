import java.io.*;
import java.util.*;
import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;
import javax.swing.*;

import edu.stanford.nlp.ling.*;
import edu.stanford.nlp.pipeline.*;
import edu.stanford.nlp.util.*;
import edu.stanford.nlp.sentiment.SentimentCoreAnnotations;

class checkSentence{
    String userSentence;
    String sProperty;
    String sentimentVal;
    Annotation annotation;

    checkSentence(String _userSentence){
      userSentence = _userSentence;
      
      Properties props = new Properties();
      props.setProperty("annotators", "tokenize, ssplit, pos, lemma, ner, parse, sentiment");

      StanfordCoreNLP pipeline = new StanfordCoreNLP(props);

      annotation= new Annotation(_userSentence);
    
      pipeline.annotate(annotation);
      }

      public ArrayList<String> getToken(String _sProperty){
        sProperty = _sProperty;
        ArrayList<String> tokenHolder = new ArrayList<String>();
        List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
        if (sentences != null && ! sentences.isEmpty()) {
          CoreMap sentence = sentences.get(0);
          for (CoreMap token : sentence.get(CoreAnnotations.TokensAnnotation.class)) {
            tokenHolder.add(token.toShorterString(_sProperty));
          }
      }
      return tokenHolder;
    }
    public String getSentiment(){
      List<CoreMap> sentences = annotation.get(CoreAnnotations.SentencesAnnotation.class);
      CoreMap sentence = sentences.get(0);
      return sentence.get(SentimentCoreAnnotations.SentimentClass.class);
    }
}