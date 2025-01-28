import 'package:flutter/material.dart';

class Customsplit extends StatefulWidget {
  const Customsplit({super.key});

  @override
  State<Customsplit> createState() => _CustomsplitState();
}

class _CustomsplitState extends State<Customsplit> {
  String selectedSplitType = 'Equal';
  final TextEditingController totalAmountController = TextEditingController();
  Map<String, TextEditingController> userController = {};
  List<String> participants = ['Samarth', 'Yash', 'Birju', 'Aditya'];
  @override
  void initState() {
    super.initState();
    _initializeUserControllers();
  }

  void _initializeUserControllers() {
    for (String user in participants) {
      userController[user] = TextEditingController();
    }
  }

  void _calculateSplit() {
    double totalAmount = double.tryParse(totalAmountController.text) ?? 0.0;
    if (totalAmount <= 0) return;
    setState(() {
      if (selectedSplitType == 'Equal') {
        double share = totalAmount / participants.length;
        for (var user in participants) {
          userController[user]!.text = share.toStringAsFixed(2);
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Custom Split",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: totalAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Total amount'),
                onChanged: (value) => _calculateSplit(),
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButton(
                value: selectedSplitType,
                onChanged: (newValue) {
                  setState(() {
                    selectedSplitType = newValue!;
                    _calculateSplit();
                  });
                },
                items: ["Equal", "Unequal"].map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: participants.length,
                    itemBuilder: (context, index) {
                      String user = participants[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: TextField(
                          controller: userController[user],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "$user's Share",
                            suffixIcon: const Icon(Icons.account_circle),
                          ),
                          onChanged: (value) {
                            if (selectedSplitType != "Equal") {
                              _calculateSplit();
                            }
                          },
                        ),
                      );
                    }),
                    
              ),
              SizedBox(height: 15),
              ElevatedButton(
              onPressed: () {
               
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Split Confirmed!")),
                );
              },
              child: const Text("Confirm Split"),)
            ],
          ),
        ));
  }
}
