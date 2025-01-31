import 'package:flutter/material.dart';
import 'package:splitwise/widgets/groupTile.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}
void addGroup(){}
class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>{

        }, icon: Icon(Icons.delete_rounded)),
        title: const Text(
          "Your groups",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        
        ),
        
      ),
      body:SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SearchBar(
              
            ),
            SizedBox(height: 15,),
            Grouptile(groupname: 'Cup of tea', groupBalance: 500),
            Grouptile(groupname: 'Manali', groupBalance: 1500),

          ],
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addGroup(),
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