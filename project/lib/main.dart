import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find the odd',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find the odd'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputWidget(
              onChanged: (text) {
                setState(() {
                  inputText = text;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                List<int> numbers = inputText.split(",").map(int.parse).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(numbers: numbers),
                  ),
                );
              },
              child: Text('Find'),
            ),
          ],
        ),
      ),
    );
  }
}

class InputWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;

  InputWidget({required this.onChanged});

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: "Enter numbers separated by commas",
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final List<int> numbers;

  ResultPage({required this.numbers});

  List<int> get oddNumbers => numbers.where((n) => n % 2 == 1).toList();

  @override
  Widget build(BuildContext context) {
    int result = oddNumbers.length == 1 ? oddNumbers.first : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Text(
          result != 0 ? result.toString() : "No odd numbers found",
          style: TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}
