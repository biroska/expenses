import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double value;
  final double percentage;

  final double _radius = 5;
  final double _barHeight = 60;

  ChartBar({
    this.label,
    this.value,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('R\$${value.toStringAsFixed(2)}'),
        SizedBox( height: 5),
        Container(height: _barHeight, width: 10,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                color: Colors.black12,
                borderRadius: BorderRadius.circular( _radius ),
              ),
            ),
            FractionallySizedBox(
              heightFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular( _radius ),
                ),
              ),
            ),
          ],
        ),),
        SizedBox( height: 5),
        Text( label ),
      ],
    );
  }
}
