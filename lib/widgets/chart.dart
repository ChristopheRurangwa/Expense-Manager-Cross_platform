import 'package:expenses/models/transction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'bars.dart';

class Chart extends StatelessWidget {
  final List<Transaction> novaTransacs;

  Chart(this.novaTransacs);

  List<Map<String, Object>> get groupedValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double sum = 0.0;

      for (var i = 0; i < novaTransacs.length; i++) {
        if (novaTransacs[i].date.day == weekDay.day &&
            novaTransacs[i].date.month == weekDay.month &&
            novaTransacs[i].date.year == weekDay.year) {
          sum += novaTransacs[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum
      };
    });//.reversed.toList();
  }

  double get allSpng {
    return groupedValues.fold(0.0, (total, el) {
      return total + el['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        margin: EdgeInsets.all(21),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedValues.map((elem) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: Bars(elem['day'], elem['amount'],
                      allSpng == 0 ? 0.0 : (elem['amount'] as double) / allSpng));
            }).toList(),
          ),
        ),
      );

  }
}
