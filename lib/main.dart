import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/blocs/bolc_exports.dart';
import 'package:task_app/screens/task_screen.dart';
import 'package:task_app/services/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(
    MyApp(appRouter: AppRouter()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Task App',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blue,
        ),
        home: const TaskScreen(),
        onGenerateRoute: appRouter.ongenerateRoute,
      ),
    );
  }
}
