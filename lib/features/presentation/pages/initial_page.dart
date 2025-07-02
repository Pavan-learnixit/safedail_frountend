import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:truecaller_clone/features/presentation/pages/language_screen.dart';

import '../utilities/colors.dart';
import '../widgets/custom_button.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.safeDial,style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.blue,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.knowText,style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 40,

                      decoration: const BoxDecoration(
                          color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      height: 10,
                      width: 40,

                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      height: 10,
                      width: 40,

                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ],
                ),
                const Placeholder(fallbackHeight: 400,fallbackWidth: 10,),
                const SizedBox(height: 50,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>LanguageScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.language,color: Colors.blue.shade900,size: 30,),
                      Text(AppLocalizations.of(context)!.changeLanguage,style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.blue.shade900,fontWeight: FontWeight.normal),),
                    ],
                  ),
                ),
                const SizedBox(height: 30,),

                customButton(
                    onPressed: () {
                      //MyApp.setLocale(context, const Locale('en'));
                      // handle login
                    },
                    label: AppLocalizations.of(context)!.getStarted,
                    width: MediaQuery.sizeOf(context).width,
                    height: 60,
                    isLoading: false,
                    backgroundColor:CustomColors.buttonColor,
                    //Colors.green,
                    borderRadius: 16,
                    textColor: Colors.white,
                    fontSize: 20
                    // border: Border.all(color: Colors.deepPurple)
                ),
                const SizedBox(height: 16,),
                Text(AppLocalizations.of(context)!.privacyText,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey,fontWeight: FontWeight.normal),),



              ],
            ),
          ),
        ),
      ),

    );
  }
}
