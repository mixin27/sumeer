import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/features/home/presentation/widgets/home_auth_notice_card.dart';
import 'package:sumeer/features/home/presentation/widgets/home_banner_card.dart';
import 'package:sumeer/features/home/presentation/widgets/home_create_button_row.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AssetPaths.logo,
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Consumer(
              builder: (context, ref, child) {
                final authStateChanges = ref.watch(authStateChangesProvider);

                return authStateChanges.when(
                  data: (data) {
                    if (data != null) {
                      return const HomeBannerCard();
                    } else {
                      return const HomeAuthNoticeCard();
                    }
                  },
                  error: (error, stackTrace) {
                    eLog(error.toString());
                    return const SizedBox();
                  },
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: HomeCreateButtonRow(),
          ),
          const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Lorem ipsum',
          //         style: Theme.of(context).textTheme.labelLarge,
          //       ),
          //       const SizedBox(height: 10),
          //       Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
