import 'package:flutter/material.dart';
import 'package:sync_scroll/sync_scroll.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SyncScroll Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DemoScreen(),
    );
  }
}

class DemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DefaultSyncScrollController(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // First ListView
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ClientScrollController(
                      builder: (context, controller) => ListView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        itemBuilder: (context, index) => Container(
                          width: 80,
                          height: 60,
                          alignment: Alignment.center,
                          child: Text('Cell $index'),
                        ),
                      ),
                    ),
                  ),

                  const Divider(),

                  // Second ListView
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ClientScrollController(
                      builder: (context, controller) => ListView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        itemBuilder: (context, index) => Container(
                          width: 80,
                          height: 60,
                          alignment: Alignment.center,
                          child: Text('Cell $index'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
