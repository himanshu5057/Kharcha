import 'package:flutter/material.dart';
import './transaction.dart';
import 'transaction_list.dart';
import './new_input.dart';
import './chart.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
        //  fontFamily: 'DancingScript'
        ),
    title: 'Flutter app',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showCharts = false;
  final List<Transactions> _transactions = [
    // Transactions(
    //     id: DateTime.now().toString(),
    //     expense: 200.0,
    //     title: "Chocolate",
    //     date: DateTime.now())
  ];
  List<Transactions> get _recenttransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void newTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Transactions(
        expense: txAmount,
        title: txTitle,
        id: DateTime.now().toString(),
        date: date);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void addNewTransaction(BuildContext context) {
    showModalBottomSheet(
        builder: (_) {
          return NewInput(newTransaction);
        },
        context: context);
  }

  void deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          "Kharcha",
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addNewTransaction(context),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          if (landscape)
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text('Show charts'),
                Switch(
                    value: showCharts,
                    onChanged: (val) {
                      setState(() {
                        showCharts = val;
                      });
                    }),
              ],
            ),
          if (landscape)
            showCharts
                ? Chart(_recenttransactions)
                : TransactionList(_transactions, deleteTransaction),
          if (!landscape) Chart(_recenttransactions),
          if (!landscape)
            TransactionList(_transactions, deleteTransaction)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.amberAccent,
        onPressed: () => addNewTransaction(context),
      ),
    );
  }
}
