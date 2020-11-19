import 'dart:async';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
// import 'splashscreen.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:easy_alert/easy_alert.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:timer_builder/timer_builder.dart';
QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(SplashScreen());
  // runApp(SplashScreen());
}
Timer _timer;
int _start = 60;
int correct=0;
int wrong=0;
var minutes;
var seconds;
List<int> wrong_answers=[];
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => QuizApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>  {
  // DateTime alert;

  // @override
  // void initState() {
  //   super.initState();
  //   alert = DateTime.now().add(Duration(seconds: 10));
  // }
  List<Widget> scoreKeeper = [];
  bool change=false;
  int next_que=-1;
  int working=0;

  List<Widget> _getList(BuildContext context) {
    List<String> options= quizBrain.getoptions();
    // print(options.length);
    List<Widget> temp = [];
    for (var q = 1; q<=options.length; q++) {
      temp.add(
         new Container(
             decoration: new BoxDecoration(
               gradient: new LinearGradient(
                 colors: [Colors.red, Colors.blue],
                 begin: FractionalOffset.centerLeft,
                 end: FractionalOffset.centerRight,
               ),
             ),
             width: double.infinity,

             child:Column(children: [
               FlatButton(
                 // color: Colors.tealAccent,
                 textColor: Colors.black,
                 child: new Text(options[q-1],style: TextStyle(fontSize: 25),),
                 onPressed: () {
                   checkAnswer(q,context);
                 },
               ),
               SizedBox(
                 height: 20,
                 child:  Divider(height: 4,color: Colors.white,),
               )

             ],)

         )

      );
    }
    return temp;
  }
  void checkAnswer(int userPickedAnswer,BuildContext context) {
    int correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        // Alert.alert(context, title: "Hello", content: "this is a alert")
        //     .then((_) => Alert.toast(context, "You just click ok"));
        // Alert(
        //   context: this.context,
        //   title: 'Finshed',
        //   desc: 'You\'ve reached the end of the quiz.\nTrue Answer: $correct \n Wrong Answer: $wrong',
        // ).show();
        if (userPickedAnswer == correctAnswer) {
          correct+=1;
          scoreKeeper.add(Icon(
            Icons.thumb_up,
            color: Colors.white,
          ));
        } else {
          wrong_answers.add(quizBrain.get_number());
          wrong+=1;
          scoreKeeper.add(Icon(
            Icons.thumb_down,
            color: Colors.black,
          ));
        }
        // print(wrong);
        // print(correct);
        quizBrain.reset();
        quizBrain.shuffle();
        scoreKeeper = [];

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute()));
      }
      else {
        if (userPickedAnswer == correctAnswer) {
          correct+=1;
          scoreKeeper.add(Icon(
            Icons.thumb_up,
            color: Colors.white,
          ));
        } else {
          wrong_answers.add(quizBrain.get_number());


          scoreKeeper.add(
              IconButton(
                icon: Icon(
                  Icons.thumb_down,
                  color: Colors.black,
                ),
                onPressed: () {

                  print("Wrong");
                  // setState(() {
                    quizBrain.change_question(quizBrain.get_number());

                    // _volume += 10;
                  // });
                  next_que = quizBrain.get_number();
                  working=wrong;
                  change=true;
                },
              ),

              );
          wrong+=1;
        }
        if (change==true){
          quizBrain.change_question(next_que);
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        TweenAnimationBuilder<Duration>(

            duration: Duration(minutes: 1),
            tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
            onEnd: () {

              print('Timer ended');
              quizBrain.reset();
              quizBrain.shuffle();
              scoreKeeper = [];

              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()));
            },
            builder: (BuildContext context, Duration value, Widget child) {
              minutes = value.inMinutes;
              seconds = value.inSeconds % 60;
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('$minutes:$seconds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)));
            }),


        // RaisedButton(
        //   onPressed: () {},
        //   textColor: Colors.white,
        //   padding: const EdgeInsets.all(0.0),
        //   child: Container(
        //
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: <Color>[
        //           Color(0xFF0D47A1),
        //           Color(0xFF1976D2),
        //           Color(0xFF42A5F5),
        //         ],
        //       ),
        //     ),
        //     padding: const EdgeInsets.all(10.0),
        //     child:
        //     const Text('Stop Quiz', style: TextStyle(fontSize: 20)),
        //   ),
        // ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: _getList(context),
        ),

        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsets.all(15.0),
        //     child: FlatButton(
        //       textColor: Colors.white,
        //       color: Colors.green,
        //       child: Text(
        //         'True',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 20.0,
        //         ),
        //       ),
        //       onPressed: () {
        //         checkAnswer(true);
        //         //The user picked true.
        //       },
        //     ),
        //   ),
        // ),
        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsets.all(15.0),
        //     child: FlatButton(
        //       color: Colors.red,
        //       child: Text(
        //         'False',
        //         style: TextStyle(
        //           fontSize: 20.0,
        //           color: Colors.white,
        //         ),
        //       ),
        //       onPressed: () {
        //         checkAnswer(false);
        //         //The user picked false.
        //       },
        //     ),
        //   ),
        // ),
        Row(
          children: scoreKeeper,
        ),
        Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
            ),
          ),
          height: 50,
          width: 150,
          child: FlatButton(
            //color: Colors.white,

            textColor: Colors.white,
            child: new Text("Stop Quiz",style: TextStyle(fontSize: 25),),
            onPressed: () {
              quizBrain.reset();
              quizBrain.shuffle();
              scoreKeeper = [];
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()));
            },
          ),),
      ],
    );
  }
}

// /*
// question1: 'You can lead a cow down stairs but not up stairs.', false,
// question2: 'Approximately one quarter of human bones are in the feet.', true,
// question3: 'A slug\'s blood is green.', true,
// */
class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: (){ Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizApp()));
            wrong=0;correct=0;
            wrong_answers=[];
            }
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text('True Answer: $correct'),
          Text('Wrong Answer: $wrong'),
          Column(
            children: quizBrain.getallquestion(wrong_answers),
          )
        ],)

      ),
    );
  }
}