import 'package:flutter/material.dart';
import 'package:splitwise/widgets/groupTile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
          padding: const EdgeInsets.all(16.0), // Adds spacing around content
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity, // Takes full width
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
              Grouptile(groupname: 'Cup of tea', groupBalance: 500),
              SizedBox(height: 20,),
              Grouptile(groupname: 'Manali Trip', groupBalance: 10000),
              
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
                
                onPressed: () => {
                  Navigator.pushNamed(context, '/addExpense'),
                },
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
