import 'package:flutter/material.dart';

class Grouptile extends StatefulWidget {
  final String groupname;
  final double groupBalance;
  
  const Grouptile(
      {required this.groupname, required this.groupBalance, Key? key})
      : super(key: key);

  @override
  State<Grouptile> createState() => _GrouptileState();
}

class _GrouptileState extends State<Grouptile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(    
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.groupname,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "₹${widget.groupBalance.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 16, color: Colors.green),
          ),
          const SizedBox(width: 5),
          IconButton(
            icon: Icon(Icons.edit_sharp),
            onPressed: ()=>{
              showModalBottomSheet(context: context, builder: (BuildContext context)
              {
                return Padding(padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 15,
              right: 15,
              left: 15,
            ),
            child: Column(
              children: [
                TextField(decoration: InputDecoration(hintText: 'Edit group name'),),
                
                TextButton(child: Text('Save', style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),), onPressed: ()=>{})
              ],
            ),
            );
              })
            },
          ),
          const SizedBox(width: 5,),
           IconButton(
            icon: Icon(Icons.delete_sharp),
            onPressed: ()=>{
              showModalBottomSheet(
  context: context,
  isScrollControlled: true, // Ensures proper expansion
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
  builder: (BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16, // Adjust for keyboard
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 16),

          
          Text(
            "Are you sure you want to delete this group?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),

          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),

          
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
            }
              
  
)

            },
          ),
        ],
      ),
    );
  }
}
