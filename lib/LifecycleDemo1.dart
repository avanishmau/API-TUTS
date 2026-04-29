import 'package:flutter/material.dart';

// Entry point widget
class LifecycleDemo extends StatefulWidget {
  const LifecycleDemo({Key? key}) : super(key: key);

  @override
  State<LifecycleDemo> createState() {
    // Called once: creates the mutable state object
    return _LifecycleDemoState();
  }
}

class _LifecycleDemoState extends State<LifecycleDemo> {

  int counter = 0;

  @override
  void initState() {
    super.initState();
    // 🔹 Called only ONCE when the widget is inserted into the tree
    // 🔹 Best place for:
    //    - API calls
    //    - Initializing controllers (AnimationController, TextEditingController)
    //    - Subscribing to streams
    print("initState called");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 🔹 Called after initState AND when dependencies change
    // 🔹 Example:
    //    - When using InheritedWidget (Theme, MediaQuery)
    // 🔹 Can be called multiple times
    print("didChangeDependencies called");
  }

  @override
  void didUpdateWidget(covariant LifecycleDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 🔹 Called when parent widget rebuilds and passes new data
    // 🔹 Compare old vs new widget values here
    print("didUpdateWidget called");
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Called MANY times
    // 🔹 Responsible for rendering UI
    // 🔹 Triggered by:
    //    - setState()
    //    - Parent rebuild
    print("build called");

    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Lifecycle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter: $counter"),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // 🔹 setState triggers rebuild → calls build()
                  counter++;
                });
              },
              child: const Text("Increment"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    // 🔹 Called when widget is REMOVED from tree temporarily
    // 🔹 Example:
    //    - Navigating to another screen
    // 🔹 Might be reinserted later
    print("deactivate called");
  }

  @override
  void dispose() {
    // 🔹 FINAL method before object is destroyed
    // 🔹 Clean up resources:
    //    - controllers.dispose()
    //    - stream subscriptions.cancel()
    print("dispose called");

    super.dispose();
  }
}