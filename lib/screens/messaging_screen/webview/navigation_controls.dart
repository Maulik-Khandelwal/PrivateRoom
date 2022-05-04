import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privateroom/retro/back_button.dart';
import 'package:privateroom/utility/ui_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls(
      this._webViewControllerFuture, this.toggleBrowser, this.toggleFullScreen)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;
  final Function toggleBrowser;
  final Function toggleFullScreen;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Container(
          color: kImperialRed,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  appBarBackButton(context, Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.black,
                  ), !webViewReady
                      ? null
                      : () async {
                    if (await controller.canGoBack()) {
                      await controller.goBack();
                    }
                  }, 35, 35),
                  appBarBackButton(context,
                    Icon(
                      FontAwesomeIcons.chevronRight,
                      color: Colors.black,
                    ),
                    !webViewReady
                        ? null
                        : () async {
                            if (await controller.canGoForward()) {
                              await controller.goForward();
                            }
                          }, 35, 35
                  ),
                  appBarBackButton(context,
                    const Icon(
                      FontAwesomeIcons.redo,
                      color: Colors.black,
                    ),
                    !webViewReady
                        ? null
                        : () {
                            controller.reload();
                          }, 35, 35
                  ),
                  appBarBackButton(context,
                    const Icon(
                      FontAwesomeIcons.expand,
                      color: Colors.black,
                    ),
                    () => toggleFullScreen(), 35, 35
                  ),
                  appBarBackButton(context,
                    const Icon(
                      FontAwesomeIcons.times,
                      color: Colors.black,
                    ),
                    () => toggleBrowser(), 35, 35
                  ),
                ],
              ),
              SizedBox(height: 10,)
            ],
          ),
        );
      },
    );
  }
}
