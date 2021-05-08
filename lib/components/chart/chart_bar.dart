import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  final double _radius = 5;
  final double _barHeight = 0.60;
  final double _labelHeight = 0.15;
  final double _spaceBetween = 0.05;

  ChartBar({
    this.label,
    this.value,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // LayoutBuilder oferece recurso de obter as areas disponiveis
        builder: (context, constraints ) {
          return Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * _labelHeight,
                // Forca o texto ficar naquela area, sem quebrar a linha e estragar o
                // layout, no exemplo, ele reduziu o tamanho da fonte
                child: FittedBox(
                  child: Text('${value.toStringAsFixed(2)}'),
                ),
              ),
              // Espacamento entre os numeros e as barras
              SizedBox(height: constraints.maxHeight * _spaceBetween ),
              Container(
                height: constraints.maxHeight * _barHeight,
                width: 10,
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
                        borderRadius: BorderRadius.circular(_radius),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(_radius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: constraints.maxHeight * _spaceBetween ),
              Container(
                  height: constraints.maxHeight * _labelHeight,
                  child: Text(label),
              ),
            ],
          );
        });
  }
}
