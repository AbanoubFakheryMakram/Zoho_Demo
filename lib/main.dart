import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zohodesk_portal_apikit/common/ZDPortalAPIKitConstants.dart';
import 'package:zohodesk_portal_apikit/zohodesk_portal_apikit.dart' show ZohodeskPortalApikit;
import 'package:zohodesk_portal_core/zohodesk_portal_core.dart' show ZohodeskPortalCore;
import 'package:zohodesk_portal_ticket/zohodesk_portal_ticket.dart' show ZohodeskPortalTicket;
import 'package:zohodesk_portal_community/zohodesk_portal_community.dart' show ZohodeskPortalCommunity;
import 'package:zohodesk_portal_kb/zohodesk_portal_kb.dart' show ZohodeskPortalKb;
import 'package:zohodesk_portal_community/zohodesk_portal_community.dart' show ZohodeskPortalCommunity;
import 'package:zohodesk_portal_ticket/zohodesk_portal_ticket.dart' show ZohodeskPortalTicket;
import 'package:zohodesk_portal_apikit/zohodesk_portal_apikit.dart' show ZohodeskPortalApikit;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// android -> androidx
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () async {
                // native token from native login from app
                String applicationToken =
                    "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAzNThBNzQ0OTk2NEIyMzc1Q0MxNTc3QTAxMEEwOUFCMzFEQTJFNDlSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6IkExaW5SSmxrc2pkY3dWZDZBUW9KcXpIYUxrayJ9.eyJuYmYiOjE2OTM3MzgyMzYsImV4cCI6MTY5Mzc0MTgzNiwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eXRlc3RzaXRlY29yZS5henVyZXdlYnNpdGVzLm5ldCIsImF1ZCI6WyJTaXRlY29yZUFwaSIsImh0dHBzOi8vaWRlbnRpdHl0ZXN0c2l0ZWNvcmUuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIl0sImNsaWVudF9pZCI6Im1vYmlsZSIsInN1YiI6ImFhZGFjYTczLTQ3NjgtNGU5OC1hN2EzLWVkZDFjMWZjNGY4OSIsImF1dGhfdGltZSI6MTY5MzczODIzNiwiaWRwIjoibG9jYWwiLCJnaXZlbl9uYW1lIjoibWVtYmVyIiwiZmFtaWx5X25hbWUiOiJtZW1iZXIiLCJ1X2siOiJxOGZGRXhRdURKY0g2WFdjcnlzVU14UXhQa1NTV3g5S29TSFZvQ0hyTy9lU01IM1Rqc0NHTDlDZWRpT1laTlhpIiwiZW1haWwiOiJtZW0yQG1haWxuYS5jbyIsImp0aSI6IjBDRDdCQjFGNzczMTI1N0M3QkFDMzdCNDdDRTI3N0Y5IiwiaWF0IjoxNjkzNzM4MjM2LCJzY29wZSI6WyJJZGVudGl0eVNlcnZlckFwaSIsImxvY2FsX2FwaV9tb2JpbGVfc2NvcGUiLCJTaXRlY29yZUFwaS5TMSJdLCJhbXIiOlsicHdkIl19.XTQJbwV4nAD8P7MIHE74YQ_DBQwaEeQbsiDeaKDrm0pechEk3R-Jhm7Ozo3RkdCrhiHf44K5a0lO9iU6F3FTBQBZx8i1eT77aCG1ASM5wNmCBRwId7dJoBxHN9fMoQIYtoU9ede3dJZnQNCvjAqszZdPitqo28RZ9LrRrXPITce11m9CgTVcnXJFLUVhE6mqmKp1nkS9PFe9qG5yLqetM1VCawH7yKF7_B0XhJU8lStVabnDQR1d_a6VubmdkdZ0n8Tu4zO4pA4GS59f6qVSLS3gh8jhm1GhLpJcW2r7Yinv1rlc1W6183_Nf8VghH8C0IGSVvSJg95ZjrZJf1U6nQ";

                // GenerateJwt
                var response = await Dio().post("https://identitytestsitecore.azurewebsites.net/api/accountmobile/GenerateJwt?usertoken=$applicationToken");
                print('jwt --> ${response.data}');

                print("init sdk");
                var datacenter = ZDPDataCenter.US;
                ZohodeskPortalApikit.initializeSDK(
                  "772007754",  // organization id
                  "edbsn0aa30d069760e8835119870f3942b335e4ae9493a6bb327a1b355ddb0a4d24cb",  // app id
                  datacenter,  // data center
                );

                // try to login with {response.data} -> jwt
                await ZohodeskPortalApikit.login(response.data, (isSuccess) async {
                  print(isSuccess);
                  if (isSuccess) {
                    // in case if success try to user tickets
                    await ZohodeskPortalTicket.show();
                  }
                });
              },
              color: Theme.of(context).colorScheme.inversePrimary,
              child: const Text("Show Tickets"),
            ),
          ],
        ),
      ),
    );
  }
}
