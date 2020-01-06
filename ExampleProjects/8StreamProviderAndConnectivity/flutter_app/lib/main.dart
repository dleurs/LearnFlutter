import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/network_provider.dart';
import 'package:connectivity/connectivity.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stream Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Stream Provider Demo'),
          centerTitle: true,
        ),
        body: Provider<NetworkProvider>(
          create: (context) => NetworkProvider(),
          child: Consumer<NetworkProvider>(
            builder: (context, value, _) => Center(
              child: NetworkStatusBasedWidget(
                networkProvider: value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NetworkStatusBasedWidget extends StatefulWidget {
  final NetworkProvider networkProvider;

  NetworkStatusBasedWidget({@required this.networkProvider});

  @override
  _NetworkStatusBasedWidgetState createState() =>
      _NetworkStatusBasedWidgetState();
}

class _NetworkStatusBasedWidgetState extends State<NetworkStatusBasedWidget> {
  @override
  void dispose() {
    widget.networkProvider.disposeStreams();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityResult>.value(
      value: widget.networkProvider.networkStatusController.stream,
      child: Consumer<ConnectivityResult>(
        builder: (context, value, _) {
          if (value == null) {
            return Container();
          }
          return Text(
            "You are ${(value != ConnectivityResult.none) ? "online" : "offline"} now",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}
