import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_redirect/store_redirect.dart';

import 'package:sumeer/features/auth/feat_auth.dart';
import 'package:sumeer/shared/constants/app_lists.dart';
import 'package:sumeer/shared/shared.dart';
import 'package:sumeer/utils/utils.dart';
import 'widgets/home_auth_notice_card.dart';
import 'widgets/home_banner_card.dart';
import 'widgets/home_create_button_row.dart';

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
          CarouselSlider(
            options: CarouselOptions(
              // height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
            items: bannerList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () async {
                      StoreRedirect.redirect(
                        androidAppId: 'com.systematic.clickjob',
                        iOSAppId: '1541128188',
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          i,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          )
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 16,
          //     vertical: 8,
          //   ),
          //   child: Consumer(
          //     builder: (context, ref, child) {
          //       return ElevatedButton(
          //         onPressed: () async {
          //           final currentUser =
          //               ref.read(authRepositoryProvider).currentUser;
          //           if (currentUser == null) return;
          //           final resumeData = await getDummyResumeData();
          //           ref
          //               .read(upsertResumeDataNotifierProvider.notifier)
          //               .upsertResumeData(
          //                 userId: currentUser.uid,
          //                 resumeData: resumeData,
          //               );
          //         },
          //         child: const Text("Add Dummy Data"),
          //       );
          //     },
          //   ),
          // ),
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
