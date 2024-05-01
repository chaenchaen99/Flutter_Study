import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_sample/src/app.dart';
import 'package:movie_search_sample/src/bloc/movie_bloc.dart';
import 'package:movie_search_sample/src/cubit/movie_cubit.dart';
import 'package:movie_search_sample/src/movie_repository.dart';

void main() {
  runApp(const MyApp());
}

// CUBIT 사용시

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: RepositoryProvider(
//         //Repository Provider를 통해 Repository 등록
//         create: (context) => MovieRepository(),
//         child: BlocProvider(
//           //Bloc이나 Cubit도 BlocProvider를 통해 등록
//           create: (context) => MovieCubit(context.read<MovieRepository>()),
//           child: const App(),
//         ),
//       ),
//     );
//   }
// }

//BLOC 사용시
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RepositoryProvider(
        //Repository Provider를 통해 Repository 등록
        create: (context) => MovieRepository(),
        child: BlocProvider(
          //Bloc이나 Cubit도 BlocProvider를 통해 등록
          create: (context) => MovieBloc(context.read<MovieRepository>()),
          child: const App(),
        ),
      ),
    );
  }
}
