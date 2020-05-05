import 'package:baseapp/p_main_app/z_main_files_p/AppValuesFilesLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class ManageCards extends StatefulWidget {
  @override
  _ManageCardsState createState() => new _ManageCardsState();
}

class _ManageCardsState extends State<ManageCards> {
  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context,int index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 60),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10)),
                        child: SvgPicture.asset(
                            "assets/images/home/payment_info/deleteIcon.svg",
                            width: AppValuesFilesLink()
                                .appValuesDimens
                                .widthDynamic(value: 20),
                            height: AppValuesFilesLink()
                                .appValuesDimens
                                .widthDynamic(value: 20),
                            fit: BoxFit.scaleDown),
                      ), Padding(
                        padding: EdgeInsets.all(AppValuesFilesLink().appValuesDimens.verticalMarginPadding(value: 10)),
                        child: SvgPicture.asset(
                            "assets/images/home/payment_info/handleIcon.svg",
                            width: AppValuesFilesLink()
                                .appValuesDimens
                                .widthDynamic(value: 20),
                            height: AppValuesFilesLink()
                                .appValuesDimens
                                .widthDynamic(value: 20),
                            fit: BoxFit.scaleDown),
                      )
                    ],
                  )
                ),
                secondaryActions: <Widget>[
                 Container(
                   height: AppValuesFilesLink().appValuesDimens.heightDynamic(value: 60),
                   color:Colors.red,
                   child: Center(
                     child: Text("Delete", style: TextStyle(
                         fontFamily: AppValuesFilesLink()
                             .appValuesFonts
                             .defaultFont,
                         fontWeight: FontWeight.w400,
                         fontSize: AppValuesFilesLink()
                             .appValuesDimens
                             .fontSize(value: 14),
                         fontStyle: FontStyle.normal,
                         color: AppValuesFilesLink()
                             .appValuesColors
                             .white),),
                   )
                 )
                ],
              );
            }),
      ),

      /*new ListView(
        children: ListTile
            .divideTiles(
          context: context,
          tiles: new List.generate(42, (index) {
            return new SlideMenu(
              child: new ListTile(
                title: new Container(child: new Text("Drag me")),
              ),
              menuItems: <Widget>[
                new Container(
                  child: new IconButton(
                    icon: new Icon(Icons.delete),
                  ),
                ),
                new Container(
                  child: new IconButton(
                    icon: new Icon(Icons.info),
                  ),
                ),
              ],
            );
          }),
        )
            .toList(),
      ),*/
    );
  }
}

class SlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  SlideMenu({this.child, this.menuItems});

  @override
  _SlideMenuState createState() => new _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = new Tween(
        begin: const Offset(0.0, 0.0),
        end: const Offset(-0.2, 0.0)
    ).animate(new CurveTween(curve: Curves.decelerate).animate(_controller));

    return new GestureDetector(
      onHorizontalDragUpdate: (data) {
        // we can access context.size here
        setState(() {
          _controller.value -= data.primaryDelta / context.size.width;
        });
      },
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity > 2500)
          _controller.animateTo(.0); //close menu on fast swipe in the right direction
        else if (_controller.value >= .5 || data.primaryVelocity < -2500) // fully open if dragged a lot to left or on fast swipe to left
          _controller.animateTo(1.0);
        else // close if none of above
          _controller.animateTo(.0);
      },
      child: new Stack(
        children: <Widget>[
          new SlideTransition(position: animation, child: widget.child),
          new Positioned.fill(
            child: new LayoutBuilder(
              builder: (context, constraint) {
                return new AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return new Stack(
                      children: <Widget>[
                        new Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth * animation.value.dx * -1,
                          child: new Container(
                            color: Colors.black26,
                            child: new Row(
                              children: widget.menuItems.map((child) {
                                return new Expanded(
                                  child: child,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}