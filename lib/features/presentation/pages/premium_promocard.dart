import 'package:flutter/material.dart';

class PremiumPromoCard extends StatelessWidget {
  final List<String> features = [
    "No Ads",
    "Advanced Spam Blocking",
    "Verification Badge",
    "Fraud Insurance*",
    "Call Recording",
    "Truecaller Assistant",
    "Who Viewed My Profile",
    "Who Searched For Me",
    "Contact Requests",
    "Incognito Mode",
    "Family Sharing (up to 4 accounts)",
  ];
  IconData getFeatureIcon(String feature) {
    if (feature.contains("Ads")) return Icons.block;
    if (feature.contains("Spam")) return Icons.report;
    if (feature.contains("Verification")) return Icons.verified;
    if (feature.contains("Insurance")) return Icons.security;
    if (feature.contains("Recording")) return Icons.mic;
    if (feature.contains("Assistant")) return Icons.assistant;
    if (feature.contains("Viewed") || feature.contains("Searched")) return Icons.visibility;
    if (feature.contains("Contact")) return Icons.contact_mail;
    if (feature.contains("Incognito")) return Icons.visibility_off;
    if (feature.contains("Family")) return Icons.close;
    return Icons.check_circle;
  }
  PremiumPromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:Row(
          children:[Container(
            width: 350,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child:
            Card(
              color: const Color(0xFF0086ff),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Safedail", style: TextStyle(fontFamily: 'safedailfont', color: Colors.white, fontSize: 30)),
                        Text("Premium", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 5),
                    ...features.map((feature) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Icon(getFeatureIcon(feature), color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(child: Text(feature, style: TextStyle(fontSize: 15, color: Colors.white))),
                        ],
                      ),
                    )).toList(),
                    SizedBox(height: 5),
                    Text("3 days free trial for new subscribers only.", style: TextStyle(color: Colors.white, fontSize: 13), textAlign: TextAlign.center),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0086ff),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.white, width: 2),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            children: [
                              Text("MONTHLY PLAN", style: TextStyle(fontSize: 20, color: Colors.white)),
                              SizedBox(height: 2),
                              Text("₹99.00/Month", style: TextStyle(fontSize: 15, color: Colors.white)),
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF096cfe),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: Column(
                            children: [
                              Text("YEARLY PLAN", style: TextStyle(fontSize: 20, color: Colors.white)),
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("₹899.00/Year  ", style: TextStyle(fontSize: 15, color: Colors.white)),
                                  Container(decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    border: Border.all(
                                      color: Colors.yellow, // Border color
                                      width: 1,           // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(4), // Optional: rounded corners
                                  ),
                                      child: Text("Save 25%", style: TextStyle(fontSize: 15, color: Colors.black))),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
            Container(
              width: 350,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                color: const Color(0xFF0147FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Safedail", style: TextStyle(fontFamily: 'safedailfont', color: Colors.white, fontSize: 30)),
                          Text("Premium", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 5),
                      ...features.map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Icon(getFeatureIcon(feature), color: Colors.white),
                            SizedBox(width: 8),
                            Expanded(child: Text(feature, style: TextStyle(fontSize: 15, color: Colors.white))),
                          ],
                        ),
                      )).toList(),
                      SizedBox(height: 5),
                      Text("3 days free trial for new subscribers only.", style: TextStyle(color: Colors.white, fontSize: 13), textAlign: TextAlign.center),
                      SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0147FF),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onPressed: () {},
                            child: Column(
                              children: [
                                Text("MONTHLY PLAN", style: TextStyle(fontSize: 20, color: Colors.white)),
                                SizedBox(height: 2),
                                Text("₹99.00/Month", style: TextStyle(fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),
                          SizedBox(height: 3),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF096cfe),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: Column(
                              children: [
                                Text("YEARLY PLAN", style: TextStyle(fontSize: 20, color: Colors.white)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("₹899.00/Year  ", style: TextStyle(fontSize: 15, color: Colors.white)),
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          border: Border.all(
                                            color: Colors.yellow, // Border color
                                            width: 1,           // Border width
                                          ),
                                          borderRadius: BorderRadius.circular(4), // Optional: rounded corners
                                        ),child: Text("Save 25%", style: TextStyle(fontSize: 15, color: Colors.black))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                color: const Color(0xFFc8bcee),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Text("Safedail", style: TextStyle(fontFamily: 'safedailfont', color: Colors.black, fontSize: 30)),
                          Text("Premium", style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 5),
                      ...features.map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Icon(getFeatureIcon(feature), color: Colors.black),
                            SizedBox(width: 8),
                            Expanded(child: Text(feature, style: TextStyle(fontSize: 15, color: Colors.black))),
                          ],
                        ),
                      )).toList(),
                      SizedBox(height: 5),
                      Text("3 days free trial for new subscribers only.", style: TextStyle(color: Colors.black, fontSize: 13), textAlign: TextAlign.center),
                      SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFc8bcee),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onPressed: () {},
                            child: Column(
                              children: [
                                Text("MONTHLY PLAN", style: TextStyle(fontSize: 20, color: Colors.black)),
                                SizedBox(height: 2),
                                Text("₹99.00/Month", style: TextStyle(fontSize: 15, color: Colors.black)),
                              ],
                            ),
                          ),
                          SizedBox(height: 3),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF096cfe),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: Column(
                              children: [
                                Text("YEARLY PLAN", style: TextStyle(fontSize: 20, color: Colors.black)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("₹899.00/Year  ", style: TextStyle(fontSize: 15, color: Colors.black)),
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          border: Border.all(
                                            color: Colors.yellow, // Border color
                                            width: 1,           // Border width
                                          ),
                                          borderRadius: BorderRadius.circular(4), // Optional: rounded corners
                                        ),child: Text("Save 25%", style: TextStyle(fontSize: 15, color: Colors.black))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceTile extends StatelessWidget {
  final String label;
  final String price;
  final bool highlight;
  final String? subtitle;
  final Color textColor;

  const PriceTile({
    required this.label,
    required this.price,
    this.highlight = false,
    this.subtitle,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

