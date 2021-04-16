import 'package:flutter/material.dart';

class Bars extends StatelessWidget {
  final String label;
  final double spAmnt;
  final double spPctAmntSum;

  Bars(this.label, this.spAmnt, this.spPctAmntSum);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (cont, constraints){

      return Column(
        children: [

          Container(
              height: constraints.maxHeight *0.16 ,
              child: FittedBox(child: Text('\$${spAmnt.toStringAsFixed(0)}'))),
          SizedBox(
            height:constraints.maxHeight *0.04 ,
          ),
          Container(
            height: constraints.maxHeight *0.6,
            width: 19,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    color: Color.fromRGBO(221, 242, 225, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spPctAmntSum,
                  child: Container(
                      height: constraints.maxHeight *0.1,
                      decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(14))),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight *0.04,
          ),
          Container(height:constraints.maxHeight *0.16,child: FittedBox(child: Text(label))),
        ],
      );
    } );
  }
}

