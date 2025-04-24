import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrisolutions_mobile/shared/custom_drawer.dart';
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
  final appLinks = AppLinks();
  bool _initialUriHandled = false;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initDeepLinkListener();
    });
  }

  Future<void> _initDeepLinkListener() async {
    if (!_initialUriHandled) {
      _initialUriHandled = true;
      try {
        final uri = await appLinks.getInitialLink();
        if (uri != null) {
          debugPrint('Initial URI: $uri');
          _handleDeepLink(uri);
        }
      } catch (e) {
        debugPrint('Error getting initial URI: $e');
      }
    }

    _sub = appLinks.uriLinkStream.listen((Uri uri) {
      print('uri detected: $uri');
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    print('Context type: ${context.widget.runtimeType}');

    if (!mounted) return;
    try {
      if (uri.pathSegments.length >= 2 &&
          uri.pathSegments[0] == 'reset-password') {
        final token = uri.pathSegments[1];
        final navContext = rootNavigatorKey.currentContext;
        if (navContext != null) {
          GoRouter.of(navContext).go('/reset-password?token=$token');
        } else {
          print('Navigator context not ready');
        }
      }
    } catch (e, stack) {
      print('Error handling deep link: $e\n$stack');
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

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
