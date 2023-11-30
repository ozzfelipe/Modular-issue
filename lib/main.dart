import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const MyHomePage(),
      children: [
        ModuleRoute('/first', module: FirstModule()),
        ModuleRoute('/second', module: SecondModule()),
      ],
    );
    r.module('/outside', module: OutsideModule());
    super.routes(r);
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/first');
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: const RouterOutlet(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              Modular.to.pushNamed('/first/');
              break;
            case 1:
              Modular.to.pushNamed('/second/');
              break;
            default:
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'first',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'second',
          ),
        ],
      ),
    );
  }
}

class FirstModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const FirstChildPage());
    super.routes(r);
  }
}

class FirstChildPage extends StatefulWidget {
  const FirstChildPage({super.key});

  @override
  State<FirstChildPage> createState() => _FirstChildPageState();
}

class _FirstChildPageState extends State<FirstChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('First module page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Modular.to.pushNamed('../outside');
          },
          child: const Text('go outise'),
        ),
      ),
    );
  }
}

class SecondModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const SecondChildPage());
    super.routes(r);
  }
}

class SecondChildPage extends StatefulWidget {
  const SecondChildPage({super.key});

  @override
  State<SecondChildPage> createState() => _SecondChildPageState();
}

class _SecondChildPageState extends State<SecondChildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: const Text('Second module page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Modular.to.pushNamed('../outside');
          },
          child: const Text('go outise'),
        ),
      ),
    );
  }
}

class OutsideModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const OutsidePage());
    super.routes(r);
  }
}

class OutsidePage extends StatefulWidget {
  const OutsidePage({super.key});

  @override
  State<OutsidePage> createState() => _OutsidePageState();
}

class _OutsidePageState extends State<OutsidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outside page'),
      ),
      body: const RouterOutlet(),
    );
  }
}
