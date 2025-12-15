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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        highlightColor: Colors.blue.shade50, // background highlight when pressed
        splashColor: Colors.blue.shade100,   // ripple effect
        onTap: () {
          debugPrint("Tapped on $name");
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: (isFraud ?? false) ? Colors.red.shade100 : null,
                    child: Center(
                      child: (isFraud ?? false)
                          ? const Icon(Icons.safety_check, size: 40)
                          : Text(
                        char,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  if (label != null && label!.isNotEmpty && !(isFraud ?? false))
                    Positioned(
                      bottom: 0,
                      right: 7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (isFraud ?? false) trueWidget(),
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
          ),
        ),
      ),
    );
  }

  Widget trueWidget() {
    return Container(
      height: 20,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: const Center(
        child: Text(
          "true",
          style: TextStyle(color: Colors.blue, fontSize: 12),
        ),
      ),
    );
  }
}
