import 'package:flutter/material.dart';

class LifecycleDemo extends StatefulWidget {
  const LifecycleDemo({Key? key}) : super(key: key);

  @override
  State<LifecycleDemo> createState() => _LifecycleDemoState();
}

class _LifecycleDemoState extends State<LifecycleDemo>
    with WidgetsBindingObserver {

  /// 🔹 FLUTTER: Called once when State object is created
  /// 🔸 ANDROID: Similar to onCreate()
  @override
  void initState() {
    super.initState();

    print("initState called");

    // Register app lifecycle listener
    WidgetsBinding.instance.addObserver(this);
  }

  /// 🔹 FLUTTER: Called when dependencies change (InheritedWidget)
  /// 🔸 ANDROID: No exact equivalent (closest: after onCreate / config change)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies called");
  }

  /// 🔹 FLUTTER: Builds UI (called MANY times)
  /// 🔸 ANDROID: UI inflation in onCreate() + manual updates later
  @override
  Widget build(BuildContext context) {
    print("build called");

    return Scaffold(
      appBar: AppBar(title: const Text("Lifecycle Demo")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              // 🔹 FLUTTER: Triggers rebuild
              // 🔸 ANDROID: Similar to manually updating UI (e.g., setText())
              print("setState triggered");
            });
          },
          child: const Text("Rebuild UI"),
        ),
      ),
    );
  }

  /// 🔹 FLUTTER: Called when widget configuration changes
  /// 🔸 ANDROID: Similar to Activity receiving new Intent / config update
  @override
  void didUpdateWidget(covariant LifecycleDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget called");
  }

  /// 🔹 FLUTTER: Widget removed temporarily from tree
  /// 🔸 ANDROID: Similar to onPause() (partially hidden)
  @override
  void deactivate() {
    super.deactivate();
    print("deactivate called");
  }

  /// 🔹 FLUTTER: Cleanup resources
  /// 🔸 ANDROID: Similar to onDestroy()
  @override
  void dispose() {
    print("dispose called");

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 🔹 FLUTTER APP LIFECYCLE (System-level)
  /// 🔸 ANDROID ACTIVITY LIFECYCLE MAPPING
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // 🔹 App in foreground
        // 🔸 ANDROID: onResume()
        print("App Resumed");
        break;

      case AppLifecycleState.inactive:
        // 🔹 Temporary interruption (call, overlay)
        // 🔸 ANDROID: between onPause() and onResume()
        print("App Inactive");
        break;

      case AppLifecycleState.paused:
        // 🔹 App in background
        // 🔸 ANDROID: onPause() + onStop()
        print("App Paused");
        break;

      case AppLifecycleState.detached:
        // 🔹 App engine running without UI
        // 🔸 ANDROID: Rare case (process still alive)
        print("App Detached");
        break;

      case AppLifecycleState.hidden:
        // 🔹 (Newer state) app hidden
        print("App Hidden");
        break;
    }
  }
}