import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisolutions_mobile/shared/custom_drawer.dart';
import 'package:uni_links/uni_links.dart';
import 'app_observer.dart';
import 'core/theme/theme.dart';
import 'routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    observers: [AppObserver()],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialUriHandled = false;
  StreamSubscription? _sub;
  void _initDeepLinkListener() {
    // Handle initial URI that may have launched the app
    if (!_initialUriHandled) {
      _initialUriHandled = true;
      try {
        getInitialUri().then((Uri? uri) {
          if (uri != null) {
            debugPrint('Initial URI: $uri');
            _handleDeepLink(uri);
          }
        });
      } catch (e) {
        // Changed from specific exception types to a general catch
        debugPrint('Error getting initial URI: $e');
      }
    }

    // Listen for subsequent URI events
    try {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (uri != null) {
          debugPrint('Got URI: $uri');
          _handleDeepLink(uri);
        }
      }, onError: (Object err) {
        debugPrint('URI stream error: $err');
      });
    } catch (e) {
      // Changed from specific exception types to a general catch
      debugPrint('Failed to subscribe to URI links: $e');
    }
  }

  void _handleDeepLink(Uri uri) {
    try {
      if (uri.pathSegments.length >= 2 &&
          uri.pathSegments[0] == 'reset-password') {
        final token = uri.pathSegments[1];
        context.go('/reset-password?token=$token');
      }
    } catch (e) {
      print('Error handling deep link: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDeepLinkListener();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      routerConfig: appRouter,
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: CustomDrawer(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle button press
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
