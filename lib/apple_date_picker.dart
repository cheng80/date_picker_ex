import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AppleDatePicker extends StatefulWidget {
  const AppleDatePicker({super.key});

  @override
  State<AppleDatePicker> createState() => _AppleDatePickerState();
}

class _AppleDatePickerState extends State<AppleDatePicker> {
  //Property
  //late 는 초기화를 나중으로 미룸
  late DateTime _currentDateTime; //날짜 저장 변수
  late String _currentDate; //선택한 날짜 문자열로 저장 변수; 
  DateTime? _chosenDateTime;   //선택한 날짜 DateTime으로 저장 변수
  late bool _isRunning; //타이머 실행 여부 저장 변수
  late Timer? _timer; //타이머 변수
  late Color _setColor; //배경색 저장 변수

  @override
  void initState() { //페이지가 새로 생성 될때 무조건 1번 사용 됨
    super.initState();
    _currentDateTime = DateTime.now(); //현재 날짜로 초기화
    _currentDate = ""; //선택한 날짜 문자열로 초기화
    _isRunning = true; //타이머 실행 여부 초기화
    _setColor = Colors.white; //배경색 초기화
    _timer = null; //
      
    if(_isRunning){
      _startTimer(() { //타이머 시작

        _currentDateTime = DateTime.now();
        _currentDate = _currentDateTime.toString().substring(0,16); //년-월-일 시:분

        _diffTimeCheck();
        setState(() {
          
        });
      });
    }
  }

  
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _setColor,
      appBar: AppBar(
        title: const Text("애플 데이터 피커 - 알람체크"),
        backgroundColor: Colors.blue, // AppBar 배경색
        foregroundColor: Colors.white, // AppBar 글자색
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(
              width: 300,
              child: Text("현재 일자: ${_returnDateNow(_currentDateTime)}", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))),
            SizedBox(
              width: 300,
              child: Text("현재 시간: ${_returnTimeNow(_currentDateTime)}", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))),
           
            SizedBox(height: 20),
            SizedBox(
              width: 300 ,
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: _currentDateTime,
                minimumDate: DateTime(_currentDateTime.year -1),
                maximumDate: DateTime(_currentDateTime.year +5),
                use24hFormat: true,
                onDateTimeChanged: (value) {
                  _chosenDateTime = value;
                  setState(() {});
                },
              ),
            ), 
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: Text("선택하신 시간 : ${_chosenDateTime != null ? _chosenDateText(_chosenDateTime!) : "선택하신 날짜 : 없음"}", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ],

        ),
      ),
    );
  }


  //--------Functions ------------
 

  String _returnDateNow(DateTime date){
    //.toString().padLeft(2,'0') 는 한자리 수를 두자리 수로 맞춰줌
    return "${date.year} - ${date.month.toString().padLeft(2,'0')} - ${date.day.toString().padLeft(2,'0')} ${_getWeekdayText(date.weekday)}";
  }

  String _returnTimeNow(DateTime date){
    //.toString().padLeft(2,'0') 는 한자리 수를 두자리 수로 맞춰줌
    return "${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}:${date.second.toString().padLeft(2,'0')}";
  }

  _startTimer(Function? callback) { //1초마다 인자로 받은 콜백 함수 실행
    //
    if (_timer?.isActive ?? false) {
      //타이머가 이미 실행중이면
      print("Timer is already running.");
      _stopTimer(); 
    }
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      callback?.call(); //1초 마다 콜백 함수 실행
    });
  }

  _stopTimer() { //타이머 멈추기
    //
    print("Stop Timer");
    _timer?.cancel();
  }

  _getWeekdayText(int weekday){
    //
    switch(weekday){
      case 1:
        return "월";
      case 2:
        return "화";
      case 3:
        return "수";
      case 4:
        return "목";
      case 5:
        return "금";
      case 6:
        return "토";
      case 7:
        return "일";
      default:
        return "";
    }
  }

  String _chosenDateText(DateTime now){
    //
    return "${now.year} - ${now.month} - ${now.day} ${_getWeekdayText(now.weekday)} ${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}";
  }

  _diffTimeCheck(){ //
    if(_chosenDateTime == null) return;
    if(_currentDate == _chosenDateTime.toString().substring(0,16)){
      //배경색 변경
      if(_currentDateTime.second % 2 == 0)
      {
        _setColor = Colors.yellow;
      
      } else {
        _setColor = Colors.red;
      }
    } else {
      _setColor = Colors.white;
    }
    // 
  } 
  
  //------------------------------
}