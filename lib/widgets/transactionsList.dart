import 'package:expanses_app/models/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> _transactionsList;
  final Function _deleteTransactions;

  TransactionsList(this._transactionsList, this._deleteTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _transactionsList.isEmpty
            ? LayoutBuilder(builder: (context, constraints) {
                return Column(children: <Widget>[
                  Text("No Transactions Added yet",
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 10),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ))
                ]);
              })
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(
                                  child: Text(
                                      "\$${_transactionsList[index].amount}"))),
                        ),
                        title: Text(
                          "\$${_transactionsList[index].title}",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(DateFormat.yMMMd()
                            .format(_transactionsList[index].date)),
                        trailing: MediaQuery.of(context).size.width < 460
                            ? IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).errorColor,
                                ),
                                onPressed: () => _deleteTransactions(
                                    _transactionsList[index].id),
                              )
                            : TextButton.icon(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        Theme.of(context).errorColor)),
                                onPressed: () => _deleteTransactions(
                                    _transactionsList[index].id),
                                icon: Icon(Icons.delete),
                                label: Text("Delete")),
                      ));
                },
                itemCount: _transactionsList.length,
              ));
  }
}
