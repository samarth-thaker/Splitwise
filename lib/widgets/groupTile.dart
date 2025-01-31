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
        ],
      ),
    );
  }
}
