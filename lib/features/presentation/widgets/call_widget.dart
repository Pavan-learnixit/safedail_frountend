import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallWidget extends StatelessWidget {
  final String char;
  final String? label;
  final String name;
  final String time;
  final VoidCallback? onCallPressed;
  final bool? isFraud;

  const CallWidget({
    super.key,
    required this.char,
    this.label,
    this.name = "Null",
    this.time = "8:21 pm",
    this.onCallPressed,
    this.isFraud,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: (isFraud??false)?Colors.red.shade100:null,
              child: Center(
                child: (isFraud??false) ?
                    Icon(Icons.safety_check,size: 40)
                :Text(
                  char,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            if (label != null && label!.isNotEmpty&&!(isFraud ?? false))
              Positioned(
                bottom: 0,
                right: 7,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications, size: 15),
                      Text(
                        label!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(width: 10,),
                  if(isFraud??false)
                  trueWidget(),


                ],
              ),
              Row(
                children: [
                  const Icon(Icons.import_export),
                  const SizedBox(width: 4),
                  Text(time),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onCallPressed ?? () {},
          icon: const Icon(Icons.call, size: 35),
        ),
      ],
    );
  }
  Widget trueWidget(){
    return Container(
      height: 20,
      width: 40,
      child: Center(child: Text("true",style: TextStyle(color: Colors.blue,fontSize: 12),),),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue,),borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}