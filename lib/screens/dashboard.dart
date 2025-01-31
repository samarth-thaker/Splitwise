import 'package:flutter/material.dart';
import 'package:splitwise/widgets/groupTile.dart';
import 'package:splitwise/widgets/loginButton.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String selectedSplitType = 'Equal';
  String? selectedGroup;
  String? selectedPayer;
  List<String> selectedParticipants = [];
  String splitType = "Equally";
  bool isLoading = false;
  Map<String, TextEditingController> userController = {};
  final List<String> groups = ["Cup of tea", "Manali"];
  final List<String> participants = ["Samarth", "Yash", "Birju", "Aditya"];
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
    double totalAmount = double.tryParse(_amountController.text) ?? 0.0;
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

  void customSplit() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _amountController,
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
                  child: const Text("Confirm Split"),
                )
              ],
            ),
          );
        });
  }

  void addSplit({String? key}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 15,
              right: 15,
              left: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                SizedBox(
                  height: 5,
                ),
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
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    prefixIcon: Icon(Icons.edit),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField<String>(
                  value: selectedPayer,
                  decoration: InputDecoration(
                    labelText: "Who Paid?",
                    border: OutlineInputBorder(),
                  ),
                  items: participants.map((friend) {
                    return DropdownMenuItem(value: friend, child: Text(friend));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedPayer = value);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Select Participants",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: participants.map((friend) {
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
                SizedBox(
                  height: 5,
                ),
                Text("Split Type",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Radio(
                      value: "Equally",
                      groupValue: splitType,
                      onChanged: (value) {
                        setState(() => splitType = value.toString());
                        customSplit();
                      },
                    ),
                    Text("Equally"),
                    SizedBox(width: 20),
                    Radio(
                      value: "Custom",
                      groupValue: splitType,
                      onChanged: (value) {
                        setState(() => splitType = value.toString());
                        customSplit();
                      },
                    ),
                    Text("Custom"),
                  ],
                ),
              ],
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/userProfile');
          },
          icon: const CircleAvatar(),
        ),
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Balance Summary",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: const [
                              Text("Owed by you",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              Text("₹${120.50}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: const [
                              Text("Owed to you",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              Text("₹${200.00}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    const Center(
                      child: Text("Net Balance: +₹${79.50}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //Grouptile(groupname: 'Cup of tea', groupBalance: 500),
              SizedBox(
                height: 20,
              ),
              //Grouptile(groupname: 'Manali Trip', groupBalance: 10000),
              LoginButton(
                  label: 'Groups',
                  onPressed: ()=>{
                    Navigator.pushNamed(context, '/group'),
                  },
                  buttonWidth: MediaQuery.of(context).size.width * 0.8)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addSplit(),
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
