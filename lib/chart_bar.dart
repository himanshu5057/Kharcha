import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double dayExpense;
  final String day;
  final double expensePercent;
  ChartBar(
      {@required this.day,
      @required this.dayExpense,
      @required this.expensePercent});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(child: Text('₹${dayExpense.toStringAsFixed(0)}',style: TextStyle(fontSize: MediaQuery.of(context).devicePixelRatio*7),)),
        SizedBox(
          height: 4,
        ),
        Container(
          height: MediaQuery.of(context).devicePixelRatio*30,
          width: MediaQuery.of(context).devicePixelRatio*4.5,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: expensePercent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(day,style: TextStyle(fontSize: MediaQuery.of(context).devicePixelRatio*7),)
      ],
    );
  }
}
