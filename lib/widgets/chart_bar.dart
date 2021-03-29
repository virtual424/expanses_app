import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String _label;
  final double _spendingAmount;
  final double _spendingPercentageofTotal;

  ChartBar(this._label, this._spendingAmount, this._spendingPercentageofTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contex, constraints) {
      return Container(
        child: Column(children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text("\$${_spendingAmount.toStringAsFixed(0)}"),
            ),
          ), //fittedbox scales and positions its child to be fitted inside it
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: _spendingPercentageofTotal,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              )),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(_label)))
        ]),
      );
    });
  }
}
