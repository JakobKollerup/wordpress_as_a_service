import 'package:flutter/material.dart';
import 'package:wordpress_as_a_service/applicationlayer/pages/homepage/home_page.dart';
import 'package:wordpress_as_a_service/applicationlayer/pages/post/cubit/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider improves the readability and eliminates the need to nest multiple BlocProviders.
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostCubit>()),
      ],
      child: MaterialApp(
        title: 'Wordpress as a service',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
