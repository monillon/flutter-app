import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/Components/maNavDrawer.dart';
import 'package:flutter_application_3/Screens/Components/monAppBar.dart';

class MyScrollView extends StatefulWidget {
  const MyScrollView({Key? key}) : super(key: key);

  @override
  _MyScrollViewState createState() => _MyScrollViewState();
}

class _MyScrollViewState extends State<MyScrollView> {
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          // App bar ///////////////////////////////////////////////////////////
          appBar: MonAppBar(
            myTitle: 'Paramètres',
          ),
          drawer: const MyNavDrawer(),

          body: Padding(
            padding: const EdgeInsets.only(
                left: 25.0,
                top: 15.0,
                right: 25.0,
                bottom: 15.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // étire sur tt l'écran
              children: [

                //////////////////////////////////////////////////////////////////
                // Titre /////////////////////////////////////////////////////////
                // TODO : titre

                //////////////////////////////////////////////////////////////////
                // Scroll view ///////////////////////////////////////////////////
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [

                        Center(
                          child: Text('🔨 Cette pages est en cours de construction !')
                        )

                        // TODO : corps de la page

                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15.0,
                ),

                /////////////////////////////////////////////
                // Bouton ///////////////////////////////////
                // TODO : bouton
              ],
            ),
          ),
        ),
      );
  }
}