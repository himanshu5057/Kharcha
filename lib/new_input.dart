import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void function() {}

class NewInput extends StatefulWidget {
  final Function addTx;

  NewInput(this.addTx);

  @override
  _NewInputState createState() => _NewInputState();
}

class _NewInputState extends State<NewInput> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  DateTime selectedDate;
  void constraints() {
    if (_titleController.text.isEmpty ||
        double.parse(_amountController.text) < 0|| selectedDate==null) return;
    widget.addTx(_titleController.text, double.parse(_amountController.text),selectedDate);
    Navigator.of(context).pop();
  }

  void date() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 7)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+10,top: 10),
        child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Card(
        child: TextField(
          decoration: InputDecoration(
            labelText: '  Title',
          ),
          controller: _titleController,
          keyboardType: TextInputType.text,
          onSubmitted: (_) => constraints(),
        ),
      ),
      Card(
        
        child: TextField(
          decoration: InputDecoration(
            labelText: '  Amount',
          ),
          controller: _amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => constraints(),
        ),
      ),
      Container(
        height: 70,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(selectedDate == null
                  ? 'No date choosen'
                  : DateFormat.yMd().format(selectedDate)),
            ),
            IconButton(
                onPressed: date, icon: Icon(Icons.date_range,size: 45,color: Colors.green,),),
          ],
        ),
      ),
      FlatButton(
        child: Text(
          'Submit',
        ),
        onPressed: () {
          constraints();
        },
        color: Colors.yellow[400],
      )
    ],
        ),
      );
  }
}
