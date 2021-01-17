import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  // spending perentage should be in between 0 and 1 for adding color to bar
  final double spendingPercentage;
  ChartBar({this.label, this.spendingAmount, this.spendingPercentage});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Total Amount per day
        Container(
            height: 20,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: 4,
        ),
        // container for bar
        Container(
            height: 100,
            width: 20,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                //  bar's background
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // this box is for filling color
                FractionallySizedBox(
                    heightFactor: spendingPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF3A4664),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ))
              ],
            )),
        SizedBox(
          height: 5,
        ),
        // text for days
        Text('$label'),
      ],
    );
  }
}
