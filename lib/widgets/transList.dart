import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/transction.dart';

class TransList extends StatelessWidget {
  final List<Transaction> transac;
  final Function deleTrans;
  TransList(this.transac, this.deleTrans);

  @override
  Widget build(BuildContext context) {
    return transac.isEmpty
        ? LayoutBuilder(builder: (cont, constraints) {
            return Column(
              children: [
                Text(
                  "Add Transactions...",
                  style:Platform.isIOS?Theme.of(context).textTheme.title: GoogleFonts.openSans(

                      color: Colors.white70,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: constraints.maxHeight * 0.80,
                  child: Image.asset(
                    'assets/images/trois.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (con, ind) {
              return Card(
                elevation: 7,
                margin: EdgeInsets.symmetric(
                  vertical: 9,
                  horizontal: 6,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child:
                            FittedBox(child: Text('\$${transac[ind].amount}'))),
                  ),
                  title: Text(transac[ind].title),
                  subtitle: Text(DateFormat.yMMMd().format(transac[ind].date)),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                    textColor: Colors.green,
                      onPressed: () {
                        deleTrans(transac[ind].id);
                      },  icon: Icon(Icons.delete), label: Text('Delete'))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.green,
                          onPressed: () {
                            deleTrans(transac[ind].id);
                          },
                        ),
                ),
              );
            },
            itemCount: transac.length,
          );
  }
}
