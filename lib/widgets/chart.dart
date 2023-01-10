import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  //list of the recent transactions
  final List<Transaction> recentTransactions;

  //constuctor
  Chart(this.recentTransactions);

  //getter of transaction values grouped by weekday
  List<Map<String, Object>> get weekDayTotalValues {
    return List.generate(7, (index) {
      //generates a new list with 7 elements
      //executes the function for every element

      //create weekday object for current day
      final weekDay = DateTime.now().subtract(Duration(days: index));

      //create variable to store sum
      var totalSum = 0.0;

      //loop and sum amounts of the same day
      for (var transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalSum += transaction.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      }; //return list of maps
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    //print(recentTransactions);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDayTotalValues.map((dayData) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    dayData['day'].toString(),
                    (dayData['amount']) as double,
                    totalSpending == 0.0
                        ? 0.0
                        : ((dayData['amount']) as double) / totalSpending),
              );
            }).toList()),
      ),
    );
  }

  double get totalSpending {
    return weekDayTotalValues.fold(0.0, (sum, element) {
      return sum + ((element['amount']) as double);
    });
  }
}
