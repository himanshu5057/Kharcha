import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kharcha/chart_bar.dart';
import './transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transactions> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      double totalSum = 0.0;

      final weekday = DateTime.now().subtract(Duration(days: index));
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year)
          totalSum += recentTransactions[i].expense;
      }
      // print(DateFormat.E().format(weekday));
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    }
    ).reversed.toList();
  }
 double get maxExpense{
   return groupedTransactions.fold(0.0, (sum,item){
     return sum+item['amount'];
   });
 } 
  totall(){
  double total=0.0;
  for(int i=0;i<recentTransactions.length;i++){
    total+=recentTransactions[i].expense;
  }
  if(total==0)
  return 1;
  return total;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:groupedTransactions.map((data)
              {return Flexible(
                child:ChartBar(day:data['day'],dayExpense:data['amount'],expensePercent:((data['amount']as double)/totall())));}
              ).toList()
            ),
    );
  }
}
