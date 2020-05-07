import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:io';
import 'dart:async';


class PushNotificationsProvider{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications(){
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print('Firecloud Token');
      print(token);
      //fDcJXsPItoE:APA91bFiuG281AmUWk9mi1yeGQjJER-7l_Cki_HmXTZmZTFprIZaUxe-juiXZquGaObQ0XqnzWZywJY04OiUMCYxmN3wgI0Tn_cbA_VyzfdcWRxzEepT6ucwhueLC-t1mKFTLFKjzd8o
    });

    _firebaseMessaging.configure(
      onMessage: (info) async{
        print('======== On Message ===========');
        print(info);
        String argument = 'no-data';
        if(Platform.isAndroid){
          argument = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argument);
      },

      onLaunch: (info) async{
        print('======== On Launch ===========');
        print(info);
      },
      onResume: (info) async{
        print('======== On Resume ===========');
        print(info);
        // final notification = info['data']['comida'];
        // print(notification);
        String argument = 'no-data';
        if(Platform.isAndroid){
          argument = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argument);
      }
    );
  }

  dispose(){
    _mensajesStreamController?.close();
  }
}