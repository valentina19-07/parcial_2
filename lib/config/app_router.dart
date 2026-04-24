import 'package:go_router/go_router.dart';
import '../views/home/home_screen.dart';
import '../views/accidentes/accidentes_screen.dart';
import '../views/establecimientos/establecimientos_screen.dart';
import '../views/establecimientos/establecimiento_form_screen.dart';
import '../views/establecimientos/establecimiento_detalle_screen.dart';

final appRouter = GoRouter(
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
        return EstablecimientoFormScreen(
          id: id,
          datosIniciales: extra,
        );
      },
    ),
    GoRoute(
      path: '/establecimientos/detalle/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final extra = state.extra as Map<String, dynamic>;
        return EstablecimientoDetalleScreen(
          id: id,
          datos: extra,
        );
      },
    ),
  ],
);