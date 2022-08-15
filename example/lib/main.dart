import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:creme_sharing/creme_sharing.dart';
import 'package:creme_sharing/utils/recipe_sticker_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CremeSharing cremeSharing;
  final backgroundVideoUrl =
      'https://storage.googleapis.com/muxdemofiles/mux-video-intro.mp4';
  bool generateWithBackgroundVideo = false;
  bool? instagramIsAvailableToShare;
  bool? whatsappIsAvailableToShare;
  bool? twitterIsAvailableToShare;
  bool loading = false;
  Duration? durationToShare;

  @override
  void initState() {
    cremeSharing = CremeSharing();
    cremeSharing.instagramIsAvailableToShare().then(
          (value) => WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              instagramIsAvailableToShare = value;
            });
          }),
        );
    cremeSharing.whatsappIsAvailableToShare().then(
          (value) => WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              whatsappIsAvailableToShare = value;
            });
          }),
        );
    cremeSharing.twitterIsAvailableToShare().then(
          (value) => WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              twitterIsAvailableToShare = value;
            });
          }),
        );
    super.initState();
  }

  @override
  void dispose() {
    cremeSharing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaPadding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Can share whatsapp: $whatsappIsAvailableToShare",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await cremeSharing.shareTextToWhatsapp(
                      text: "Testing to share with link https://google.com",
                    );
                  },
                  child: const Text('share text to whatsapp'),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Can share twitter: $twitterIsAvailableToShare",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await cremeSharing.shareTextToTwitter(
                      text: "Testing to share with link https://google.com",
                    );
                  },
                  child: const Text('share text to twitter'),
                ),
              ],
            ),
          ),
          if (instagramIsAvailableToShare == null || loading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
          if (instagramIsAvailableToShare != null &&
              !instagramIsAvailableToShare! &&
              !loading)
            const SliverFillRemaining(
              child: Center(child: Text('Instagram is not available to share')),
            ),
          if ((instagramIsAvailableToShare ?? false) && !loading)
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: safeAreaPadding.top + 24),
                  if (durationToShare != null)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                          'took ${durationToShare?.abs().toString()} to share in the last interection'),
                    ),
                  if (durationToShare != null) const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        final initialDateTime = DateTime.now();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            loading = true;
                          });
                        });
                        await cremeSharing.shareCreatorToInstagramStories(
                          backgroundVideoUrl: generateWithBackgroundVideo
                              ? backgroundVideoUrl
                              : null,
                          creatorAvatarUrl:
                              'https://images.ctfassets.net/3p29fwo3qudu/40EFY4w8CnahIpQUtuRqlH/77e42391bc90af801454acccb8da1857/creme-marcio-silva-30-output.jpg',
                          creatorName: 'Márcio Silva',
                          creatorTag: 'Mixologist',
                          cremeLogoMessage: 'Just joined',
                          context: context,
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            loading = false;
                            durationToShare =
                                initialDateTime.difference(DateTime.now());
                          });
                        });
                      },
                      child: const Text('share creator to instagram stories'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        final initialDateTime = DateTime.now();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            loading = true;
                          });
                        });
                        await cremeSharing.shareRecipesToInstagramStories(
                          creatorTag: 'Mixologist',
                          extraRecipesToShow: [],
                          backgroundVideoUrl: generateWithBackgroundVideo
                              ? backgroundVideoUrl
                              : null,
                          recipeImageUrl:
                              'https://images.ctfassets.net/3p29fwo3qudu/6FeBEw8yYlcOwxnCYemQey/5c526b3e4d13e9373678cb759e71d9ba/creme-marcio-silva-1-output.jpg',
                          creatorAvatarUrl:
                              'https://images.ctfassets.net/3p29fwo3qudu/40EFY4w8CnahIpQUtuRqlH/77e42391bc90af801454acccb8da1857/creme-marcio-silva-30-output.jpg',
                          creatorName: 'Márcio Silva',
                          recipeName: 'Simple Syrup',
                          cremeLogoMessage: 'Cook with',
                          context: context,
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            loading = false;

                            durationToShare =
                                initialDateTime.difference(DateTime.now());
                          });
                        });
                      },
                      child: const Text('share 1 recipe to instagram stories'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        final initialDateTime = DateTime.now();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            loading = true;
                          });
                        });
                        await cremeSharing.shareRecipesToInstagramStories(
                          creatorTag: 'Mixologist',
                          extraRecipesToShow: [
                            const RecipeData(
                              recipeName: 'Simple Syrup',
                              recipeImageUrl:
                                  'https://images.ctfassets.net/3p29fwo3qudu/6FeBEw8yYlcOwxnCYemQey/5c526b3e4d13e9373678cb759e71d9ba/creme-marcio-silva-1-output.jpg',
                              recipeImageBytes: null,
                            ),
                            const RecipeData(
                              recipeName: 'Simple Syrup',
                              recipeImageUrl:
                                  'https://images.ctfassets.net/3p29fwo3qudu/6FeBEw8yYlcOwxnCYemQey/5c526b3e4d13e9373678cb759e71d9ba/creme-marcio-silva-1-output.jpg',
                              recipeImageBytes: null,
                            ),
                          ],
                          backgroundVideoUrl: generateWithBackgroundVideo
                              ? backgroundVideoUrl
                              : null,
                          recipeImageUrl:
                              'https://images.ctfassets.net/3p29fwo3qudu/6FeBEw8yYlcOwxnCYemQey/5c526b3e4d13e9373678cb759e71d9ba/creme-marcio-silva-1-output.jpg',
                          creatorAvatarUrl:
                              'https://images.ctfassets.net/3p29fwo3qudu/40EFY4w8CnahIpQUtuRqlH/77e42391bc90af801454acccb8da1857/creme-marcio-silva-30-output.jpg',
                          creatorName: 'Márcio Silva',
                          recipeName: 'Simple Syrup',
                          cremeLogoMessage: 'Cook with',
                          context: context,
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            loading = false;

                            durationToShare =
                                initialDateTime.difference(DateTime.now());
                          });
                        });
                      },
                      child: const Text('share 3 recipes to instagram stories'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        final initialDateTime = DateTime.now();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            loading = true;
                          });
                        });
                        await cremeSharing.shareCookedToInstagramStories(
                          backgroundVideoUrl: generateWithBackgroundVideo
                              ? backgroundVideoUrl
                              : null,
                          userName: 'Fe de Lamare',
                          userAvatarUrl:
                              'https://cdn.cre.me/avatar/b5d90c37-2d66-49b5-a148-51006bdb2f7f.jpg',
                          cookedImageUrl:
                              'https://cdn.cre.me/share/1141003d-7c9d-4b71-b280-e16a13eba904.jpg',
                          creatorAvatarUrl:
                              'https://downloads.ctfassets.net/3p29fwo3qudu/7HxtqQ26sWwCyZHZSoYDpF/771125e358cce423da4384ae486badcf/040A0810.jpeg',
                          creatorName: 'Astor Bar',
                          recipeName: 'Smoked Salmon Club Sandwich',
                          cremeLogoMessage: 'Cooked with',
                          context: context,
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            loading = false;
                            durationToShare =
                                initialDateTime.difference(DateTime.now());
                          });
                        });
                      },
                      child: const Text('share cooked to instagram stories'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CupertinoSwitch(
                          value: generateWithBackgroundVideo,
                          onChanged: (value) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                generateWithBackgroundVideo = value;
                              });
                            });
                          },
                        ),
                        const SizedBox(width: 4),
                        const Text('Generate with Background video'),
                      ],
                    ),
                  ),
                  SizedBox(height: safeAreaPadding.bottom + 24)
                ],
              ),
            ),
        ],
      ),
    );
  }
}
