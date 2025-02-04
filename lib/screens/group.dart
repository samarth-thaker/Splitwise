import 'package:flutter/material.dart';
import 'package:splitwise/widgets/groupTile.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});
  
  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final TextEditingController groupController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  List<Map<String, dynamic>> groupTile = [
    {"groupname": 'Cup of tea', "groupBalance": 500},
    {"groupname": 'Manali', "groupBalance": 1500},
  ];

  void addGroup(BuildContext context) {
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

                    if (groupName.isNotEmpty && amount != null) {
                      setState(() {
                        
                        groupTile.add({"groupname": groupName, "groupBalance": amount});
                      });
                      groupController.clear();
                      amountController.clear();
                      Navigator.pop(context);
                    }
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
        onPressed: () => addGroup(context),
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
