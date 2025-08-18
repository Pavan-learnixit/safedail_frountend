import 'package:flutter/material.dart';
import 'premium_promocard.dart';
import 'premium_screen2.dart';
import 'premium_listtiles.dart';

class premiumscreen extends StatefulWidget {
  const premiumscreen({super.key});

  @override
  State<premiumscreen> createState() => _premiumscreenState();
}

class _premiumscreenState extends State<premiumscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Truecaller Premium',
      home: Scaffold(
          body: SafeArea(child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(16),
                    child:Text("Choose a Plan",textAlign: TextAlign.center,style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                    PremiumPromoCard(),
                    SizedBox(height: 15,),
                    Center(child: Text("Discover features and compare plans",style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold),),),
                    premium_screen2(),
                    SizedBox(height: 7,),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Upgrade Now", // <-- Your button label
                    style: TextStyle(
                      color: Colors.blueAccent, // Customize color
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                ,
                SizedBox(height: 7,),
                premium_listtiles(),
              ],
            ),
          )),
      )
    );
  }
}

