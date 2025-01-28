import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedGroup;
  String? selectedPayer;
  List<String> selectedParticipants = [];
  String splitType = "Equally";
  bool isLoading = false;

  final List<String> groups = ["Cup of tea", "Manali"];
  final List<String> friends = ["Samarth", "Yash", "Birju", "Aditya"];

  void _saveExpense() async {
    if (_amountController.text.isEmpty ||
        selectedGroup == null ||
        selectedPayer == null ||
        selectedParticipants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => isLoading = false);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Add Expense",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
      )),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                prefixIcon: Icon(Icons.currency_rupee_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedGroup,
              decoration: InputDecoration(
                labelText: "Select Group",
                border: OutlineInputBorder(),
              ),
              items: groups.map((group) {
                return DropdownMenuItem(value: group, child: Text(group));
              }).toList(),
              onChanged: (value) {
                setState(() => selectedGroup = value);
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedPayer,
              decoration: InputDecoration(
                labelText: "Who Paid?",
                border: OutlineInputBorder(),
              ),
              items: friends.map((friend) {
                return DropdownMenuItem(value: friend, child: Text(friend));
              }).toList(),
              onChanged: (value) {
                setState(() => selectedPayer = value);
              },
            ),
            SizedBox(height: 16),
            Text("Select Participants",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              children: friends.map((friend) {
                final isSelected = selectedParticipants.contains(friend);
                return ChoiceChip(
                  label: Text(friend),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedParticipants.add(friend);
                      } else {
                        selectedParticipants.remove(friend);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text("Split Type", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio(
                  value: "Equally",
                  groupValue: splitType,
                  onChanged: (value) {
                    setState(() => splitType = value.toString());
                  },
                ),
                Text("Equally"),
                SizedBox(width: 20),
                Radio(
                  value: "Custom",
                  groupValue: splitType,
                  onChanged: (value) {
                    setState(() => splitType = value.toString());
                    Navigator.pushNamed(context, '/customSplit');
                  },
                ),
                Text("Custom"),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: _saveExpense,
                      icon: Icon(Icons.add),
                      label: Text("Add Expense"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
