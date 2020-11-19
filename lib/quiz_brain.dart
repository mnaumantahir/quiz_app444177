import 'package:quizzler/question.dart';
import 'package:flutter/material.dart';
class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('When did India Join the UN?',["September 30, 1945","September 30, 1948","October 30, 1945","October 30, 1947"], 3),
    Question('Gwadar Port is constructed in the province of',["Balochistan","Kpk","Sindh","Punjab"], 1),
    Question('how many stanzas are there in pakistan national anthem?',["Seven","Three","Five","Six"], 2),
    Question('What was the old name of PIA:?',["Air Pakistan","Kolachi Airways","Independence Airways","Orient Airways"], 4),
    Question('What official name was given to Pakistan in 1956 constitution?',["United States of Pakistan","Republic of Pakistan","Islamic Republic of Pakistan","Islamic Pakistan"], 2),
    Question('Who was the Prime Minister of Pakistan during enforcement of first constitution?',["Choudhry Mohammad Ali","Ibrahim Ismail Chundrigar","Mohammad Ali Bogra","Khwaja Nazim Uddin"], 1),
    Question('When was Gas (Natural) discovered at Sui Baluchistan?',["1950","1954","1952","None of these"], 3),
    Question('Baluchistan got the status of province in?',["1970","1971","1930","1935"], 1),
    Question('Who composed the verses of Pakistan national Anthem?',["Faiz Ahmed Faiz","Allama Iqbal","Nasir Kazmi","Hafeez Jallandri"], 4),
    Question(' How many letters are there in Urdu alphabets?',["39","37","36","35"], 2),

    // Question('You can lead a cow down stairs but not up stairs.', false),
    // Question('Approximately one quarter of human bones are in the feet.', true),
    // Question('A slug\'s blood is green.', true),
    // Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    // Question('It is illegal to pee in the Ocean in Portugal.', true),
    // Question(
    //     'No piece of square dry paper can be folded in half more than 7 times.',
    //     false),
    // Question(
    //     'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
    //     true),
    // Question(
    //     'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
    //     false),
    // Question(
    //     'The total surface area of two human lungs is approximately 70 square metres.',
    //     true),
    // Question('Google was originally called \"Backrub\".', true),
    // Question(
    //     'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
    //     true),
    // Question(
    //     'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
    //     true),
  ];
  //Create Next Question Function
  void shuffle(){
  _questionBank..shuffle();
  }
  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }
void change_question(int index){
  _questionNumber=index;
}
  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }
  int get_number(){
    return _questionNumber;
  }
  int getCorrectAnswer() {
    return _questionBank[_questionNumber].index;
  }
  List<String> getoptions(){
    return _questionBank[_questionNumber].data;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }
  List<Widget> getallquestion(List<int> wrongans){
    List<Widget> temp = [];
    for(int i=0; i<wrongans.length;i++){
      int t=wrongans[i];
      temp.add(new Text( _questionBank[t].questionText+": "+_questionBank[t].data[_questionBank[t].index-1],style: TextStyle(fontSize: 20,backgroundColor: Colors.black38,color: Colors.white),));
    }
    return temp;
  }
  void reset() {
    _questionNumber = 0;
  }
}

//  void nextQuestion() {
//    if (_questionNumber < _questionBank.length - 1) {
//      _questionNumber++;
//    }
//  }
//
//  String getQuestionText() {
//    return _questionBank[_questionNumber].questionText;
//  }
//
//  bool getCorrectAnswer() {
//    return _questionBank[_questionNumber].questionAnswer;
//  }

//TODO: Step 3 Part A - Create a method called isFinished() here that checks to see if we have reached the last question. It should return (have an output) true if we've reached the last question and it should return false if we're not there yet.

//TODO: Step 3 Part B - Use a print statement to check that isFinished is returning true when you are indeed at the end of the quiz and when a restart should happen.

//TODO: Step 4 Part B - Create a reset() method here that sets the questionNumber back to 0.
//}
