import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Utils/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'myHome.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({
    Key? key
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyLoginPageState();
}

class MyLoginPageState extends State<MyLoginPage> {
  late VideoPlayerController _controller;

  bool _isSecret = true; // cacher le mdp

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          // App bar ///////////////////////////////////////////////////////////
          appBar: AppBar(
            title: const Text('Connexion'),
            backgroundColor: Theme.of(context).primaryColor,
          ),


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

                  Expanded(
                    child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //////////////////////////////////////////////////////////////
                                // Logo SAPA /////////////////////////////////////////////////
                                const Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage("assets/logo_ss86.png"),
                                    ),
                                  ),
                                ),

                                //////////////////////////////////////////////////////////////
                                // Formulaire de connexion ///////////////////////////////////
                                Expanded(
                                  flex: 5,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 15.0,
                                        ),

                                        //////////////////////////////////////////////////////
                                        // Identifiant ///////////////////////////////////////
                                        TextFormField(
                                          validator: (value) => validateUsername(value),
                                          decoration: InputDecoration(
                                            hintText: 'Identifiant...',
                                            contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10.0
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              borderSide: BorderSide(
                                                color: Theme.of(context).focusColor,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 15.0,
                                        ),

                                        //////////////////////////////////////////////////////
                                        // Mot de passe //////////////////////////////////////
                                        TextFormField(
                                          validator: (value) => validatePassword(value),
                                          obscureText: _isSecret,
                                          decoration: InputDecoration(
                                            hintText: 'Mot de passe...',
                                            contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10.0
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              borderSide: BorderSide(
                                                color: Theme.of(context).focusColor,
                                              ),
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () =>
                                                  setState(() => _isSecret = !_isSecret),
                                              child: Icon(!_isSecret
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 15.0,
                                        ),

                                        ////////////////////////////////////////////
                                        // Bouton //////////////////////////////////
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0)
                                                ),
                                                color: Theme.of(context).primaryColor,
                                                elevation: 0,
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                ),
                                                onPressed: () => {
                                                  if(_formKey.currentState!.validate()) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => const MyHomePage(),
                                                        )
                                                    ),
                                                  }
                                                },
                                                child: Text(
                                                  'Connexion',
                                                  style: TextStyle(
                                                    color: Theme.of(context).splashColor,
                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),

                                        const SizedBox(
                                          height: 15.0,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                ////////////////////////////////////////////////////////
                                // Texte de consentement ///////////////////////////////
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text: "En vous connectant, vous acceptez d'échanger dans un cadre de respect et vous reconnaissez avoir lu ",
                                            style: TextStyle(
                                              color: Theme.of(context).focusColor,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'nos mentions légales.',
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () => launch(
                                                      'https://sportsante86.fr/mentions-legales/'
                                                  ),
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ]
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ]
                    ),
                  ),
                ]
            ),
          ),
        ),

      );
  }

  // ------------------------------------------------------------------------ //
  // Fonction pour contraindre l'id ----------------------------------------- //
  dynamic validateUsername(var value) {
    if (value == null || value.isEmpty) {
      return ('L\'identifiant ne peut être vide.');
    }
    loggedUsername = value;
    return null;
  }

  // ------------------------------------------------------------------------ //
  // Fonction pour contraindre le mdp --------------------------------------- //
  dynamic validatePassword(var value) {
    if (value == null || value.isEmpty) {
      return ('Le mot de passe ne peut être vide.');
    } else if (value.length < 8) {
      return ('Le mot de passe doit contenir au moins 8 caractères.'); // TODO voir pour faire revenir le texte à la ligne si besoin
    } else if (!containUppercase(value)) {
      return ('Le mot de passe doit contenir au moins une majuscule.'); // TODO voir pour faire revenir le texte à la ligne si besoin
    }
    return null;
  }

  // ------------------------------------------------------------------------ //
  // Fonction pour vérifier au moins 1 majuscule dans le mdp ---------------- //
  bool containUppercase(value) {
    bool containUppercase = false;
    for (var i = 0; i < value.length; i++) {
      if (value[i] == value[i].toUpperCase()) {
        containUppercase = true;
        break;
      }
    }
    return containUppercase;
  }
}
