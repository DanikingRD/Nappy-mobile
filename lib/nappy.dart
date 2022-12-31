import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/constants/themes.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/repositories/impl/auth_repository.dart';
import 'package:nappy_mobile/repositories/impl/user_repository.dart';
import 'package:nappy_mobile/router.dart';
import 'package:routemaster/routemaster.dart';

class Nappy extends ConsumerStatefulWidget {
  const Nappy({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NappyState();
}

class _NappyState extends ConsumerState<Nappy> {
  @override
  Widget build(BuildContext context) {
    final authEvents = ref.watch(authUpdateProvider);
    return authEvents.when(
      data: (optionalId) {
        return MaterialApp.router(
          routerDelegate: RoutemasterDelegate(
            routesBuilder: (context) {
              // This will rebuild when the user state changes
              return optionalId.match(
                () => Routes.publicRoutes,
                (id) {
                  setActiveUser(id);
                  return ref.read(userProvider).match(
                        () => Routes.publicRoutes,
                        (_) => Routes.privateRoutes,
                      );
                },
              );
            },
          ),
          routeInformationParser: const RoutemasterParser(),
          theme: kLightTheme,
          debugShowCheckedModeBanner: false,
        );
      },
      error: (error, stack) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: NappyColors.primary,
        ),
      ),
    );
  }

  Future<void> setActiveUser(Identifier id) async {
    final data = await ref.watch(userRepositoryProvider).watch(id).first;
    ref.read(userProvider.notifier).update((state) => Option.of(data));
    setState(() {}); // TODO: check if this setState is necessary.
  }
}

class ExtendedScrollBehaviour extends ScrollBehavior {
  const ExtendedScrollBehaviour();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}
