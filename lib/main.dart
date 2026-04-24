import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:parcial_2/views/home/home_screen.dart';
import 'package:parcial_2/views/accidentes/accidentes_screen.dart';
import 'package:parcial_2/views/establecimientos/establecimientos_screen.dart';
import 'package:parcial_2/views/establecimientos/establecimiento_form_screen.dart';
import 'package:parcial_2/views/establecimientos/establecimiento_detalle_screen.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/accidentes',
      builder: (context, state) => const AccidentesScreen(),
    ),
    GoRoute(
      path: '/establecimientos',
      builder: (context, state) => const EstablecimientosScreen(),
    ),
    GoRoute(
      path: '/establecimientos/crear',
      builder: (context, state) => const EstablecimientoFormScreen(),
    ),
    GoRoute(
      path: '/establecimientos/editar/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final extra = state.extra as Map<String, dynamic>;
        return EstablecimientoFormScreen(id: id, datosIniciales: extra);
      },
    ),
    GoRoute(
      path: '/establecimientos/detalle/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final extra = state.extra as Map<String, dynamic>;
        return EstablecimientoDetalleScreen(id: id, datos: extra);
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Parcial Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}