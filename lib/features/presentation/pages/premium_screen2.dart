import 'package:flutter/material.dart';
class premium_screen2 extends StatelessWidget {
  premium_screen2({super.key});
  final ScrollController _scrollController = ScrollController();
  final GlobalKey sectionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                Scrollable.ensureVisible(
                  sectionKey.currentContext!,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Container(
              key: sectionKey,
              height: 150,
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.all(24), // Uniform spacing from all sides
              decoration: BoxDecoration(
                color: Color(0xFFe7f0ff),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.block,color: Colors.blueAccent,),
                        Text("No Ads ",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Align(alignment: Alignment.centerLeft,
                        child: Text("Enjoy Safedail without any ads",style: TextStyle(fontSize: 16,color: Colors.grey),)),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,),
                            Text("Premium"),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,),
                            Text("Family"),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
    ;
  }
}
