import 'package:cta/Pages/Login/Login_page.dart';
import 'package:cta/Pages/controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  final _questions = [
    {
      'question': 'What is your favorite color?',
      'options': [
        {'text': 'Red', 'score': 10},
        {'text': 'Blue', 'score': 20},
        {'text': 'Green', 'score': 30},
        {'text': 'Yellow', 'score': 40},
      ],
    },
    {
      'question': 'What is your favorite animal?',
      'options': [
        {'text': 'Dog', 'score': 10},
        {'text': 'Cat', 'score': 20},
        {'text': 'Bird', 'score': 30},
        {'text': 'Fish', 'score': 40},
      ],
    },
    {
      'question': 'What is your favorite food?',
      'options': [
        {'text': 'Pizza', 'score': 10},
        {'text': 'Burger', 'score': 20},
        {'text': 'Pasta', 'score': 30},
        {'text': 'Salad', 'score': 40},
      ],
    },
    {
      'question': 'What is your favorite hobby?',
      'options': [
        {'text': 'Reading', 'score': 10},
        {'text': 'Traveling', 'score': 20},
        {'text': 'Cooking', 'score': 30},
        {'text': 'Sports', 'score': 40},
      ],
    },
    {
      'question': 'What is your favorite season?',
      'options': [
        {'text': 'Spring', 'score': 10},
        {'text': 'Summer', 'score': 20},
        {'text': 'Autumn', 'score': 30},
        {'text': 'Winter', 'score': 40},
      ],
    },
  ];
  var logincontroller = Get.put(Logincontroller());

  int _currentQuestionIndex = 0;
  int _totalScore = 0;
  int? _selectedOption;

  void _answerQuestion() {
    if (_selectedOption != null) {
      setState(() {
        if (_currentQuestionIndex < _questions.length) {
          final question = _questions[_currentQuestionIndex];
          final options = question['options'] as List<Map<String, Object>>;
          if (_selectedOption! < options.length) {
            _totalScore += options[_selectedOption!]['score'] as int;
            _currentQuestionIndex++;
            _selectedOption = null;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Assessment'),
        ),
        body: _currentQuestionIndex < _questions.length
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _questions[_currentQuestionIndex]['question']
                              as String? ??
                          'No question',
                      style: TextStyle(fontSize: 20.0.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0.h),
                    Column(
                      children: (_questions[_currentQuestionIndex]['options']
                                  as List<Map<String, Object>>?)
                              ?.asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            Map<String, Object> option = entry.value;
                            return RadioListTile<int>(
                              title: Text(
                                  option['text'] as String? ?? 'No option'),
                              value: index,
                              groupValue: _selectedOption,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedOption = value;
                                });
                              },
                            );
                          }).toList() ??
                          [],
                    ),
                    SizedBox(height: 20.0.h),
                    ElevatedButton(
                      onPressed: _selectedOption == null
                          ? null
                          : () {
                              _answerQuestion();
                            },
                      child: Text('Next'),
                    ),
                  ],
                ),
              )
            : logincontroller.isSignedin == true
                ? Center(
                    child: Text('Your total Score is ${_totalScore}'),
                  )
                : Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You need to login before seeing your results '),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(
                                  () => LoginPage(),
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ));
  }
}
