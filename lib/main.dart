import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zohodesk_portal_apikit/common/ZDPortalAPIKitConstants.dart';
import 'package:zohodesk_portal_apikit/zohodesk_portal_apikit.dart' show ZohodeskPortalApikit;
import 'package:zohodesk_portal_ticket/zohodesk_portal_ticket.dart' show ZohodeskPortalTicket;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () async {
                // generate jwt
                String token =
                    "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAzNThBNzQ0OTk2NEIyMzc1Q0MxNTc3QTAxMEEwOUFCMzFEQTJFNDlSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6IkExaW5SSmxrc2pkY3dWZDZBUW9KcXpIYUxrayJ9.eyJuYmYiOjE2OTMzOTg1NTEsImV4cCI6MTY5MzQwMjE1MSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eXRlc3RzaXRlY29yZS5henVyZXdlYnNpdGVzLm5ldCIsImF1ZCI6WyJTaXRlY29yZUFwaSIsImh0dHBzOi8vaWRlbnRpdHl0ZXN0c2l0ZWNvcmUuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIl0sImNsaWVudF9pZCI6Im1vYmlsZSIsInN1YiI6ImFhZGFjYTczLTQ3NjgtNGU5OC1hN2EzLWVkZDFjMWZjNGY4OSIsImF1dGhfdGltZSI6MTY5MzM5ODU1MSwiaWRwIjoibG9jYWwiLCJnaXZlbl9uYW1lIjoibWVtYmVyIiwiZmFtaWx5X25hbWUiOiJtZW1iZXIiLCJ1X2siOiJxOGZGRXhRdURKY0g2WFdjcnlzVU14UXhQa1NTV3g5S29TSFZvQ0hyTy9lU01IM1Rqc0NHTDlDZWRpT1laTlhpIiwiZW1haWwiOiJtZW0yQG1haWxuYS5jbyIsImp0aSI6IjBENjVFNzRGMjdDMzYxMUU3OUI1QjU5RkQ0RDI5MjBFIiwiaWF0IjoxNjkzMzk4NTUxLCJzY29wZSI6WyJJZGVudGl0eVNlcnZlckFwaSIsImxvY2FsX2FwaV9tb2JpbGVfc2NvcGUiLCJTaXRlY29yZUFwaS5TMSJdLCJhbXIiOlsicHdkIl19.XOEkVuU9Ki_SoUJeLFIF7E6BXRE6kVzxJ6Y8-CCZjYtisbmkjQq-2ZbViz6RZvipi0W4ehozugE-iXSH6bT-zExvaKkN1H2VlJ2pOVwpBmFuff6ZB5jX8zjsRVhvIQkQy6bDtiV-NBWpNhZlKWDOioacmehiyxDlKBL2euq00NvvniDooyUfBJvKU1xhvisP_mN2lECW9OO335i4yx97_lsifTTMunHMbbulQ0r6swEuI6KlbQ78b2lzU188TlRv5-FQWSeFbPI8hv02VgJcz1Z0FSxTLAQF88qJm5j3qbV-9RimpZhKnT3Je0K2S63YLH0VQQmIVwg4UfVj8QGZXA";
                var response = await Dio().post("https://identitytestsitecore.azurewebsites.net/api/accountmobile/GenerateJwt?usertoken=$token");

                // init sdk
                var datacenter = ZDPDataCenter.US;
                ZohodeskPortalApikit.initializeSDK(
                  "772007754",
                  "edbsn0aa30d069760e8835119870f3942b335e4ae9493a6bb327a1b355ddb0a4d24cb",
                  datacenter,
                );

                // ios
                if (Platform.isIOS) {
                  await ZohodeskPortalApikit.login(response.data, (isSuccess) async {
                    if (isSuccess) {
                      await ZohodeskPortalTicket.show();
                    }
                  });
                }

                // Native Android
                if (Platform.isAndroid) {
                  MethodChannel channel = const MethodChannel("ZOHO_DESK");
                  await channel.invokeMethod("ZOHO_DESK/OPEN_TICKETS", {
                    "jwt": response.data,
                  });
                }
              },
              child: const Text("Show User Tickets"),
            ),
          ],
        ),
      ),
    );
  }
}
