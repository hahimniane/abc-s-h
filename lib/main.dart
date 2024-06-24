// import 'package:firebase_core/firebase_core.dart';
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import 'firebase_options.dart';
// //
// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }
// //
// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
// //
// //   WebViewController _controller = WebViewController();
// //
// //   Future<void> _getPermission() async {
// //     NotificationSettings settings = await _messaging.requestPermission(
// //       alert: true,
// //       announcement: false,
// //       badge: true,
// //       carPlay: false,
// //       criticalAlert: false,
// //       provisional: false,
// //       sound: true,
// //     );
// //
// //     print('User granted permission: ${settings.authorizationStatus}');
// //     print('The token is ${await _messaging.getToken()}');
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _getPermission();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     _controller = WebViewController()
// //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
// //       ..setBackgroundColor(const Color(0x00000000))
// //       ..setNavigationDelegate(
// //         NavigationDelegate(
// //           onProgress: (int progress) {
// //             // Update loading bar.
// //           },
// //           onPageStarted: (String url) {},
// //           onPageFinished: (String url) async {
// //             // Optionally, you can evaluate JavaScript to debug the toggle button.
// //             await _controller.runJavaScriptReturningResult(
// //                 "document.querySelector('your-toggle-button-selector').click();");
// //           },
// //           onHttpError: (HttpResponseError error) {},
// //           onWebResourceError: (WebResourceError error) {},
// //           onNavigationRequest: (NavigationRequest request) {
// //             // Uncomment and modify the following line if you want to restrict navigation to specific URLs.
// //             // if (request.url.startsWith('https://www.abcbul.com/')) {
// //             //   return NavigationDecision.prevent;
// //             // }
// //             return NavigationDecision.navigate;
// //           },
// //         ),
// //       )
// //       ..loadRequest(Uri.parse('https://abcbul.com/'));
// //     return Scaffold(
// //       body: WebViewWidget(
// //         controller: _controller,
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // theme: ThemeData(useMaterial3: true),
//       home: WebViewApp(),
//     ),
//   );
// }
//
// class WebViewApp extends StatefulWidget {
//   @override
//   State<WebViewApp> createState() => _WebViewAppState();
// }
//
// class _WebViewAppState extends State<WebViewApp> {
//   late final WebViewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..loadRequest(
//         //https://www.abcbul.com/
//         Uri.parse('https:www.abcbul.com/'),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff10172A),
//       // appBar: AppBar(
//       //   title: const Text('Flutter WebView'),
//       // ),
//       body: SafeArea(
//         child: WebViewWidget(
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }
//**************************************************************************************************************
// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
//     await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
//   }
//
//   runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final GlobalKey webViewKey = GlobalKey();
//
//   InAppWebViewController? webViewController;
//   InAppWebViewSettings settings = InAppWebViewSettings(
//       isInspectable: kDebugMode,
//       mediaPlaybackRequiresUserGesture: false,
//       allowsInlineMediaPlayback: true,
//       iframeAllow: "camera; microphone",
//       iframeAllowFullscreen: true);
//
//   PullToRefreshController? pullToRefreshController;
//   String url = "";
//   double progress = 0;
//   final urlController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     pullToRefreshController = kIsWeb
//         ? null
//         : PullToRefreshController(
//             settings: PullToRefreshSettings(
//               color: Colors.blue,
//             ),
//             onRefresh: () async {
//               if (defaultTargetPlatform == TargetPlatform.android) {
//                 webViewController?.reload();
//               } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//                 webViewController?.loadUrl(
//                     urlRequest:
//                         URLRequest(url: await webViewController?.getUrl()));
//               }
//             },
//           );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: Column(children: <Widget>[
//       TextField(
//         decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
//         controller: urlController,
//         keyboardType: TextInputType.url,
//         onSubmitted: (value) {
//           var url = WebUri(value);
//           if (url.scheme.isEmpty) {
//             url = WebUri("https://www.google.com/search?q=$value");
//           }
//           webViewController?.loadUrl(urlRequest: URLRequest(url: url));
//         },
//       ),
//       Expanded(
//         child: Stack(
//           children: [
//             InAppWebView(
//               key: webViewKey,
//               initialUrlRequest: URLRequest(url: WebUri("https://abcbul.com/")),
//               initialSettings: settings,
//               pullToRefreshController: pullToRefreshController,
//               onWebViewCreated: (controller) {
//                 webViewController = controller;
//               },
//               onLoadStart: (controller, url) {
//                 setState(() {
//                   this.url = url.toString();
//                   urlController.text = this.url;
//                 });
//               },
//               onPermissionRequest: (controller, request) async {
//                 return PermissionResponse(
//                     resources: request.resources,
//                     action: PermissionResponseAction.GRANT);
//               },
//               shouldOverrideUrlLoading: (controller, navigationAction) async {
//                 var uri = navigationAction.request.url!;
//
//                 if (![
//                   "http",
//                   "https",
//                   "file",
//                   "chrome",
//                   "data",
//                   "javascript",
//                   "about"
//                 ].contains(uri.scheme)) {
//                   if (await canLaunchUrl(uri)) {
//                     // Launch the App
//                     await launchUrl(
//                       uri,
//                     );
//                     // and cancel the request
//                     return NavigationActionPolicy.CANCEL;
//                   }
//                 }
//
//                 return NavigationActionPolicy.ALLOW;
//               },
//               onLoadStop: (controller, url) async {
//                 pullToRefreshController?.endRefreshing();
//                 setState(() {
//                   this.url = url.toString();
//                   urlController.text = this.url;
//                 });
//               },
//               onReceivedError: (controller, request, error) {
//                 pullToRefreshController?.endRefreshing();
//               },
//               onProgressChanged: (controller, progress) {
//                 if (progress == 100) {
//                   pullToRefreshController?.endRefreshing();
//                 }
//                 setState(() {
//                   this.progress = progress / 100;
//                   urlController.text = url;
//                 });
//               },
//               onUpdateVisitedHistory: (controller, url, androidIsReload) {
//                 setState(() {
//                   this.url = url.toString();
//                   urlController.text = this.url;
//                 });
//               },
//               onConsoleMessage: (controller, consoleMessage) {
//                 if (kDebugMode) {
//                   print(consoleMessage);
//                 }
//               },
//             ),
//             progress < 1.0
//                 ? LinearProgressIndicator(value: progress)
//                 : Container(),
//           ],
//         ),
//       ),
//       ButtonBar(
//         alignment: MainAxisAlignment.center,
//         children: <Widget>[
//           ElevatedButton(
//             child: const Icon(Icons.arrow_back),
//             onPressed: () {
//               webViewController?.goBack();
//             },
//           ),
//           ElevatedButton(
//             child: const Icon(Icons.arrow_forward),
//             onPressed: () {
//               webViewController?.goForward();
//             },
//           ),
//           ElevatedButton(
//             child: const Icon(Icons.refresh),
//             onPressed: () {
//               webViewController?.reload();
//             },
//           ),
//         ],
//       ),
//     ])));
//   }
// }
import 'dart:async';
import 'package:abcbull/firebase_options.dart';
import 'package:abcbull/token_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    userAgent:
        "Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36",
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  String? _deviceToken;

  @override
  void initState() {
    getUserToken();
    super.initState();

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(color: Colors.blue),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                  urlRequest:
                      URLRequest(url: await webViewController?.getUrl()),
                );
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        child: const Icon(
          Icons.notification_add,
          size: 40,
          color: Colors.purple,
        ),
        onPressed: () {
          TokenService tokenService = TokenService();
          tokenService.sendTokenForNotification(
              email: "hassimiou.niane@maine.edu", token: 'testtoken');
        },
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // TextField(
              //   decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
              //   controller: urlController,
              //   keyboardType: TextInputType.url,
              //   onSubmitted: (value) {
              //     var url = WebUri(value);
              //     if (url.scheme.isEmpty) {
              //       url = WebUri("https://www.google.com/search?q=$value");
              //     }
              //     webViewController?.loadUrl(urlRequest: URLRequest(url: url));
              //   },
              // ),
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialUrlRequest: URLRequest(
                        url: WebUri("https://abcbul.com/"),
                        headers: {"Authorization": "Bearer initial"},
                      ),
                      initialSettings: settings,
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },

                      onLoadStart: (controller, url) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },

                      shouldInterceptRequest: (controller, request) async {
                        var headers = request.headers ?? {};
                        headers['Authorization'] = 'Bearer YOUR_TOKEN_HERE';
                        return WebResourceResponse(
                          // data: request.toString(),
                          headers: headers,
                          statusCode: 200,
                          reasonPhrase: 'OK',
                        );
                      },
                      onPermissionRequest: (controller, request) async {
                        return PermissionResponse(
                          resources: request.resources,
                          action: PermissionResponseAction.GRANT,
                        );
                      },
                      // shouldOverrideUrlLoading:
                      //     (controller, navigationAction) async {
                      //   var uri = navigationAction.request.url!;
                      //   var headers = {
                      //     ...navigationAction.request.headers ?? {},
                      //     "Authorization": "Bearer YOUR_TOKEN_HERE"
                      //   };

                      //   print('Loading URL: ${uri.toString()}');
                      //   print('Headers: $headers');

                      //   await controller.loadUrl(
                      //     urlRequest: URLRequest(
                      //       url: uri,
                      //       headers: headers,
                      //     ),
                      //   );
                      //   return NavigationActionPolicy.CANCEL;
                      // },
                      onLoadStop: (controller, url) async {
                        pullToRefreshController?.endRefreshing();
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onReceivedError: (controller, request, error) {
                        pullToRefreshController?.endRefreshing();
                      },
                      onProgressChanged: (controller, progress) {
                        if (progress == 100) {
                          pullToRefreshController?.endRefreshing();
                        }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = url;
                        });
                      },
                      onUpdateVisitedHistory:
                          (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        if (kDebugMode) {
                          print(consoleMessage);
                        }
                      },
                    ),
                    progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container(),
                  ],
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     ElevatedButton(
              //       child: const Icon(Icons.arrow_back),
              //       onPressed: () {
              //         webViewController?.goBack();
              //       },
              //     ),
              //     ElevatedButton(
              //       child: const Icon(Icons.arrow_forward),
              //       onPressed: () {
              //         webViewController?.goForward();
              //       },
              //     ),
              //     ElevatedButton(
              //       child: const Icon(Icons.refresh),
              //       onPressed: () {
              //         webViewController?.reload();
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getUserToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      setState(() {
        _deviceToken = token;
      });
      print("Device Token: $_deviceToken");
    } catch (e) {
      print("Error getting device token: $e");
    }
  }
}
