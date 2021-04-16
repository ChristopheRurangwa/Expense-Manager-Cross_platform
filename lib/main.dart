import 'dart:io';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/newTransc.dart';
import 'package:expenses/widgets/transList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/transction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amount;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransac = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 55.09, date: DateTime.now()),
    // Transaction(id: 't2', title: 'PS4', amount: 555.09, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'Air-Pods', amount: 331.09, date: DateTime.now()),
  ];

  bool _showChar = false;

  List<Transaction> get _novaTransx {
    return _userTransac.where((trx) {
      return trx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransc(String item, double amount, DateTime tm) {
    final transc = Transaction(
        title: item, amount: amount, date: tm, id: DateTime.now().toString());

    setState(() {
      _userTransac.add(transc);
    });
  }

  void _initiateTransac(BuildContext cont) {
    showModalBottomSheet(
        context: cont,
        builder: (_) {
          return GestureDetector(
              onTap: () {}, child: NewTransac(_addNewTransc));
        });
  }

  void _deletTrans(String id) {
    setState(() {
      _userTransac.removeWhere((e) {
        return e.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaqueries = MediaQuery.of(context);

    final isScape = mediaqueries.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar1 = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Personal Expenses",
              style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _initiateTransac(context),
                )
              ],
            ),
          )
        : AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(
              "Personal Expenses",
              style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _initiateTransac(context))
            ],
          );
    final txLis = Container(
        height: (mediaqueries.size.height -
                appBar1.preferredSize.height -
                mediaqueries.padding.top) *
            0.7,
        child: TransList(_userTransac, _deletTrans));

    final theBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isScape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.title,
                ),
                Switch.adaptive(
                  activeColor: Colors.blueGrey,
                  value: _showChar,
                  onChanged: (val) {
                    setState(() {
                      _showChar = val;
                    });
                  },
                ),
              ],
            ),
          if (!isScape)
            Container(
                height: (mediaqueries.size.height -
                        appBar1.preferredSize.height -
                        mediaqueries.padding.top) *
                    0.3,
                child: Chart(_novaTransx)),
          if (!isScape) txLis,
          if (isScape)
            _showChar
                ? Container(
                    height: (mediaqueries.size.height -
                            appBar1.preferredSize.height -
                            mediaqueries.padding.top) *
                        0.5,
                    child: Chart(_novaTransx))
                : txLis
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: theBody,
            navigationBar: appBar1,
          )
        : Scaffold(
            appBar: appBar1,
            body: theBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _initiateTransac(context),
                  ),
          );
  }
}
