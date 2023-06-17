import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

var wcLink;
var connected = false;
var address;

class IApplied extends StatefulWidget {
  const IApplied({Key? key}) : super(key: key);

  @override
  State<IApplied> createState() => _IAppliedState();
}

class _IAppliedState extends State<IApplied> {
  List<String> transactionHistory = [
    "Payment received from John Doe - \$50",
    "Payment sent to Jane Smith - \$30",
    "Payment received from Mark Johnson - \$20",
  ];

  double balanceRemaining = 250.0;

  void depositMoney(double amount) async {
    if (connected) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String connectedAccount = prefs.getString("connectedAccount") ?? "";

      final connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: PeerMeta(
          name: 'WalletConnect',
          description: 'WalletConnect Developer App',
          url: 'https://walletconnect.org',
          icons: [
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      );

      connector.on('connect', (session) {
        if (session is SessionStatus && session.accounts.isNotEmpty) {
          final connectedAccount = session.accounts[0];
          print("Connected account address: $connectedAccount");
          prefs.setString("connectedAccount", connectedAccount);
        }
      });

      if (!connector.connected) {
        final session = await connector.createSession(
          chainId: 4160,
          onDisplayUri: (uri) async {
            wcLink = uri;
            print(uri);
            await launch(wcLink);
            print("Launched");
          },
        );
      }

      final rpcUrl = connector.session?.rpcUrl;
      if (rpcUrl != null) {
        final request = {
          'jsonrpc': '2.0',
          'method': 'eth_sendTransaction',
          'params': [
            {
              'from': connectedAccount,
              'to': '0x017d9Fa382BD869C5840bf8E9dd9761754A879ec',
              'value': '0x${(amount * 1e18).toInt().toRadixString(16)}',
            }
          ],
          'id': 1,
        };

        final response = await http.post(Uri.parse(rpcUrl), body: jsonEncode(request));
        final responseData = jsonDecode(response.body);
        print('Transaction response: $responseData');
      }
    }
  }


  @override
  void initState() {
    super.initState();
    connected = false;
    checkConnection();
    connectWallet();
  }

  void connectWallet() async {
    final connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: [
          'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    );

    connector.on('connect', (session) {
      print("one");
      print(session);

      if (session is SessionStatus && session.accounts.isNotEmpty) {
        final connectedAccount = session.accounts[0];
        print("Connected account address: $connectedAccount");
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("connectedAccount", connectedAccount);
          setState(() {
            connected = true;
            address = connectedAccount;
          });
        });
      }
    });

    connector.on('session_update', (payload) {
      print("two");
      print(payload);
    });

    connector.on('disconnect', (session) {
      print("3");
      print(session);
    });

    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 4160,
        onDisplayUri: (uri) async {
          wcLink = uri;
          print(uri);
          await launch(wcLink);
          print("Launched");
        },
      );
    }
  }

  void checkConnection() {
    SharedPreferences.getInstance().then((prefs) {
      String connectedAccount = prefs.getString("connectedAccount") ?? "";

      if (connectedAccount != "") {
        setState(() {
          connected = true;
          address = connectedAccount;
        });
      } else {
        setState(() {
          connected = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.network(
                "https://gingersauce.co/wp-content/uploads/2020/09/image14.png",
                width: 60,
              ),
              Text(
                'Assignease',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist',
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/1652029477671645184/LkQIxDCE_400x400.jpg"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment method",
                    style: TextStyle(
                      color: Color.fromRGBO(36, 107, 253, 1),
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Paypal",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction History",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: transactionHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(transactionHistory[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance Remaining",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "\$$balanceRemaining",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deposit Money",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      hintText: "Enter amount to deposit",
                    ),
                    onChanged: (value) {
                      double amount = double.tryParse(value) ?? 0.0;
                      depositMoney(amount);
                    },
                  ),
                ],
              ),
            ),
            connected == false
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  connectWallet();
                },
                child: Text("Connect Wallet"),
              ),
            )
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connected Wallet",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Assignease',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: IApplied(),
  ));
}
