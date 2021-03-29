import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function _addTransaction;

  NewTransactions(this._addTransaction);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget._addTransaction(enteredTitle, enteredAmount,
        selectedDate); //since addtransaction property is a part of different class i.e NewTransacrions class and we have to use it in the NewTransactionsState class we use widget.(property of another class). using widget property we can access properties of another class.

    Navigator.of(context)
        .pop(); // to close the modalBottomsheet on pressing the submitted button.
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime
                .now(), //initial date date should be diplayed when this picker is opened.
            firstDate: DateTime(2019), //oldest date that a user can choose
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    }); //latest date that a user can choose
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _titleController,
                    onSubmitted: (_) {
                      _submitData();
                    }),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {
                    // here onSubmitted takes a function which needs a string as an input,but as here we do not need any onput and hence we placed a
                    //(_)underscore as an input which means that we dont use that input . it is just there to prevent the error.
                    _submitData();
                  },
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(selectedDate == null
                            ? "No Date chosen"
                            : "Picked Date: ${DateFormat.yMd().format(selectedDate)}"),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        onPressed: _presentDatePicker,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: Text("Add Transaction"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).textTheme.button.color)),
                )
              ],
            ),
          )),
    );
  }
}
