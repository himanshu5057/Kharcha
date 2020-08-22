import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTran;
  final List<Transactions> transactions;
  TransactionList(this.transactions,this.deleteTran);
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Container(
        child: transactions.isEmpty?
        Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
          Text("No Transactions",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),)
        ],) :
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.red)),
                    padding: EdgeInsets.all(7),
                    child: Text(
                      '₹${transactions[index].expense.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transactions[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed:() =>deleteTran(transactions[index].id),
                    color: Colors.red[400],
                  )
                ],
              ),
            );
          },
          itemCount: transactions.length,
        ),
      ),
    );
  }
}
