import 'package:flutter/material.dart';
import 'package:splitwise/widgets/groupTile.dart';
import 'package:hive/hive.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final TextEditingController groupController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  Box groupBox = Hive.box("MyBox");
  List<Map<String, dynamic>> groupTile = [
    /* {"groupname": 'Cup of tea', "groupBalance": 500.0},
    {"groupname": 'Manali', "groupBalance": 1500.0}, */
  ];
  Future<void> _openBox() async {
    groupBox = Hive.openBox("MyBox") as Box;
  }

  void initState() {
    super.initState();
    _openBox().then((_) => setState(() {}));
  }

  void dispose() {
    amountController.dispose();
    groupController.dispose();
    super.dispose();
  }

  void addOrUpdateGroup({String? key}) {
    if (key != null) {
      final group = groupBox.get(key);
      if (group != null) {
        groupController.text = group['group'] ?? "";
        amountController.text = group['amount']?.toString() ?? "";
      }
    } else {
      groupController.clear();
      amountController.clear();
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Create a Group",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: groupController,
                  decoration: InputDecoration(
                    labelText: 'Group Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      String groupName = groupController.text;
                      double? amount = double.tryParse(amountController.text);
                      if (groupName.isEmpty || amount == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Fill all the details')));
                        return;
                      }

                      if (groupName.isNotEmpty && amount != null) {
                        setState(() {
                          groupTile.add(
                              {"groupname": groupName, "groupBalance": amount});
                        });
                        groupController.clear();
                        amountController.clear();
                        Navigator.pop(context,
                            groupTile.map((g) => g['groupname']).toList());
                      }
                      if (key == null) {
                        final newKey =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        groupBox.put(newKey,
                            {"groupName": groupName, "groupBalance": amount});
                      } else {
                        groupBox.put(key,
                            {"groupName": groupName, "groupBalance": amount});
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Add Group",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void deleteGroup(dynamic index) {
    setState(() {
      groupTile.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your groups",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SearchBar(),
              SizedBox(height: 15),
              ...groupTile.map((group) {
                return Grouptile(
                  groupname: group['groupname'],
                  groupBalance: group['groupBalance'],
                  onDelete: () {
                    deleteGroup(groupTile.indexOf(group));
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addOrUpdateGroup(),
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
