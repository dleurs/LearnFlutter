import 'package:flutter/material.dart';

// I need a Stateful Widget, and not a Stateless Widget, because I need the widget to rebuild when show is put to false
class WelcomeUser extends StatefulWidget { 
  final double opacity;
  final Color color;
  final Widget child;
  bool show;

  WelcomeUser({
    Key key,
    this.opacity = 0.7,
    this.color = Colors.white,
    this.show = true,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _WelcomeUserState createState() => _WelcomeUserState();
}

class _WelcomeUserState extends State<WelcomeUser> {
  void hideWelcomeWidget() {
    setState(() {
      this.widget.show = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(widget.child);
    if (this.widget.show) {
      Widget welcomeUser;
      welcomeUser = Center(
          child: Container(
              height: 200,
              width: 400,
              //need this due to bug...https://github.com/flutter/flutter/issues/18399
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text("Hello World"),
                    RaisedButton(
                      onPressed: () => hideWelcomeWidget(),
                      child: const Text('Discover the app',
                          style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              )));
      final modal = [
        new Opacity(
          child: new ModalBarrier(color: widget.color),
          opacity: this.widget.opacity,
        ),
        welcomeUser
      ];
      widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}
