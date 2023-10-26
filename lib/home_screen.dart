import 'dart:math';
import 'package:bmi_app/age_widget.dart';
import 'package:bmi_app/gender_widget.dart';
import 'package:bmi_app/height_widget.dart';
import 'package:bmi_app/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _gender = 0;
  int _height = 0;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMI Calculator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 60,bottom: 60),
          child: Column(
            children: [
              Card(
                elevation: 12,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Column(
                  children: [
                    GenderWidget(
                      onChange: (genderVal){
                      _gender = genderVal;
                    },),
                    HeightWidget(
                      onChange: (heightVal){
                      _height = heightVal;
                    },),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AgeWidget(onChange: (ageVal){
                          _age = ageVal;
                        },
                            title: "Age",
                            intiValue: 30,
                            min: 0,
                            max: 100),
                        AgeWidget(onChange: (weightVal){
                          _weight = weightVal;
                        },
                            title: "Weight(Kg)",
                            intiValue: 50,
                            min: 0,
                            max: 200),
                      ],
                    ),

                  ],
                ),
              ),
               SizedBox(height: 30,),
               Card(
                 color: Colors.blueAccent.shade100,
                 elevation: 12,
                 shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 60
                      ),
                      child: SwipeableButtonView(
                          isFinished: _isFinished,
                          onFinish: () async {

                            await Navigator.push(
                                context,
                                PageTransition(
                                    child: ScoreScreen(
                                      bmiScore: _bmiScore,
                                      age: _age,
                                    ),
                                    type: PageTransitionType.fade
                                ));

                            setState(() {
                              _isFinished = false;
                            });
                          },
                          onWaitingProcess: (){
                            //BMI Calculate here
                            calculateBmi();
                            Future.delayed(const Duration(seconds: 1),(){
                              setState(() {
                                _isFinished = true;
                              });
                            });
                          },
                          activeColor: Colors.black,
                          buttonWidget: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.black,),
                          buttonText: "Calculate"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void calculateBmi()
  {
    _bmiScore = _weight/pow(_height/100, 2);
  }
}
