import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWidget extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeMode;
  const HomeWidget({super.key, required this.themeMode});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final ScrollController _scrollController = ScrollController();
  void toggleThemeMode(BuildContext context) {
    widget.themeMode.value = widget.themeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception("Could not launch url $_url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 60),
        actions: [
          TextButton(
            onPressed: _scrollToBottom,
            child: Text(
              tr("works"),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          IconButton(
            icon: Icon(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Theme.of(context).iconTheme.color!,
            ),
            tooltip:
                MediaQuery.of(context).platformBrightness == Brightness.light
                ? tr("light")
                : tr("dark"),
            onPressed: () => toggleThemeMode(context),
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              color: Theme.of(context).iconTheme.color!,
            ),
            tooltip: tr("toggle_language"),
            onPressed: () {
              // Toggle between English and Persian locales
              if (context.locale.languageCode == 'en') {
                context.setLocale(Locale('fa'));
              } else {
                context.setLocale(Locale('en'));
              }
            },
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  ? 64
                  : 140,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 7.78,
              ),
              child: ResponsiveRowColumn(
                rowSpacing: 16,
                columnSpacing: 32,
                layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                rowTextDirection:
                    EasyLocalization.of(context)!.locale.toLanguageTag() == "en"
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  ResponsiveRowColumnItem(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(240),
                      child: Image.asset(
                        'assets/images/image.png',
                        height: 240,
                        width: 240,
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 9,
                    rowFit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("header"),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Gap(40),
                        Text(
                          tr("p1"),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        // Gap(40),
                        // OutlinedButton(
                        //   style: OutlinedButton.styleFrom(
                        //     padding: EdgeInsets.symmetric(
                        //       horizontal: 20,
                        //       vertical: 16,
                        //     ),
                        //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //     backgroundColor: Colors.red[400],
                        //     foregroundColor: Colors.white,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(2.0),
                        //     ),
                        //     side: BorderSide.none,
                        //   ),

                        //   onPressed: () => _launchUrl(
                        //     Uri.parse(
                        //       "https://mzn928.ir/assets/assets/images/resume.pdf",
                        //     ),
                        //   ),
                        //   child: Text(
                        //     tr("resume_download"),
                        //     style: TextStyle(
                        //       fontFamily: "Modam",
                        //       fontSize: 19,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Gap(
                      ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                          ? 32
                          : 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  ? 0
                  : 80,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              // height: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
              // ? 1000
              // : 420,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 7.78,
                vertical: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                    ? 8
                    : 32,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              child: ExpandableCarousel(
                options: ExpandableCarouselOptions(
                  // height: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  //     ? 1000
                  //     : 420,
                  // // height: 346.0,
                  viewportFraction: 1,
                ),
                items: [
                  MiniApp(context: context),
                  WinApp(context: context),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 80)),
          SliverToBoxAdapter(
            child: ResponsiveRowColumn(
              layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              columnCrossAxisAlignment: CrossAxisAlignment.center,
              rowMainAxisAlignment: MainAxisAlignment.center,
              rowSpacing: 16,
              columnSpacing: 24,
              children: [
                ResponsiveRowColumnItem(
                  child: Text(
                    tr("connect"),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: InkWell(
                    onTap: () =>
                        _launchUrl(Uri.parse("https://github.com/mzn928")),
                    child: SizedBox(
                      width: 130,
                      child: Row(
                        mainAxisAlignment:
                            ResponsiveBreakpoints.of(
                              context,
                            ).smallerThan(DESKTOP)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedGithub,
                            color: Theme.of(context).iconTheme.color!,
                            size: 48,
                          ),
                          Gap(4),
                          Text(
                            "Github",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: InkWell(
                    onTap: () => _launchUrl(Uri.parse("https://t.me/mzn928")),
                    child: SizedBox(
                      width: 130,
                      child: Row(
                        mainAxisAlignment:
                            ResponsiveBreakpoints.of(
                              context,
                            ).smallerThan(DESKTOP)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedTelegram,
                            color: Theme.of(context).iconTheme.color!,
                            size: 48,
                          ),
                          Gap(4),
                          Text(
                            "Telegram",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: InkWell(
                    onTap: () =>
                        _launchUrl(Uri.parse("mailto:mzn928@gmail.com")),
                    child: SizedBox(
                      width: 130,
                      child: Row(
                        mainAxisAlignment:
                            ResponsiveBreakpoints.of(
                              context,
                            ).smallerThan(DESKTOP)
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedMail01,
                            color: Theme.of(context).iconTheme.color!,
                            size: 48,
                          ),
                          Gap(4),
                          Text(
                            "Email",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 80)),
          SliverToBoxAdapter(child: Center(child: Text(tr("flutter")))),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}

class MiniApp extends StatelessWidget {
  const MiniApp({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        // border: Border.all(color: Colors.red[400]!, width: 2),
      ),
      child: ResponsiveRowColumn(
        columnSpacing: 16,
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowSpacing: 16,
        columnMainAxisSize: MainAxisSize.min,
        columnMainAxisAlignment: MainAxisAlignment.spaceBetween,
        rowMainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ResponsiveRowColumnItem(
            columnOrder: 1,
            child: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                ? Text(
                    tr("miniapp"),
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                : SizedBox.shrink(),
          ),
          ResponsiveRowColumnItem(
            columnOrder: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () => showImageViewer(
                  context,
                  Image.asset(
                    "assets/images/miniapp.png",
                    fit: BoxFit.fill,
                  ).image,
                  useSafeArea: true,
                  swipeDismissible: true,
                  doubleTapZoomable: true,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(4),
                  child: Image.asset(
                    "assets/images/miniapp.png",
                    fit: BoxFit.fitHeight,
                    height: 500,
                  ),
                ),
              ),
            ),
          ),
          ResponsiveRowColumnItem(
            columnOrder: 2,
            rowOrder: 1,
            // columnFit: FlexFit.tight,
            rowFlex: 7,
            rowFit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...(ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                    ? [SizedBox.shrink()]
                    : [
                        Text(
                          tr("miniapp"),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Gap(8),
                        Text(
                          tr("miniappDesc"),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Gap(8),
                      ]),
                IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedNanoTechnology,
                                color: Theme.of(context).iconTheme.color!,
                              ),
                              Gap(8),
                              Flexible(child: Text(tr("miniapp1"))),
                            ],
                          ),
                        ),
                        Gap(8),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedMolecules,
                                color: Theme.of(context).iconTheme.color!,
                              ),
                              Gap(8),
                              Flexible(child: Text(tr("miniapp2"))),
                            ],
                          ),
                        ),
                        Gap(8),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedStatus,
                                color: Theme.of(context).iconTheme.color!,
                              ),
                              Gap(8),
                              Flexible(child: Text(tr("miniapp3"))),
                            ],
                          ),
                        ),
                        Gap(8),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedUser,
                                color: Theme.of(context).iconTheme.color!,
                              ),
                              Gap(8),
                              Flexible(child: Text(tr("miniapp4"))),
                            ],
                          ),
                        ),
                        Gap(8),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedTimeHalfPass,
                                color: Theme.of(context).iconTheme.color!,
                              ),
                              Gap(8),
                              Flexible(child: Text(tr("miniapp5"))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WinApp extends StatelessWidget {
  const WinApp({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(8),
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          // border: Border.all(color: Colors.red[400]!, width: 2),
        ),
        child: ResponsiveRowColumn(
          columnSpacing: 16,
          layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          rowMainAxisAlignment: MainAxisAlignment.spaceAround,
          columnMainAxisSize: MainAxisSize.min,
          // columnMainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ResponsiveRowColumnItem(
              columnOrder: 1,
              child: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                  ? Text(
                      tr("winapp"),
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  : SizedBox.shrink(),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 6,
              rowFit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...(ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                      ? [SizedBox.shrink()]
                      : [
                          Text(
                            tr("winapp"),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Gap(16),
                        ]),
                  IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedNanoTechnology,
                                  color: Theme.of(context).iconTheme.color!,
                                ),
                                Gap(8),
                                Expanded(child: Text(tr("winapp1"))),
                              ],
                            ),
                          ),
                          Gap(8),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedArcBrowser,
                                  color: Theme.of(context).iconTheme.color!,
                                ),
                                Gap(8),
                                Expanded(child: Text(tr("winapp2"))),
                              ],
                            ),
                          ),
                          Gap(8),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedStatus,
                                  color: Theme.of(context).iconTheme.color!,
                                ),
                                Gap(8),
                                Expanded(child: Text(tr("winapp3"))),
                              ],
                            ),
                          ),
                          Gap(8),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedUser,
                                  color: Theme.of(context).iconTheme.color!,
                                ),
                                Gap(8),
                                Expanded(child: Text(tr("winapp4"))),
                              ],
                            ),
                          ),
                          Gap(8),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedTimeHalfPass,
                                  color: Theme.of(context).iconTheme.color!,
                                ),
                                Gap(8),
                                Flexible(child: Text(tr("winapp5"))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: () => showImageViewer(
                    context,
                    Image.asset(
                      "assets/images/winapp.jpg",
                      fit: BoxFit.fill,
                    ).image,
                    useSafeArea: true,
                    swipeDismissible: true,
                    doubleTapZoomable: true,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(4),
                    child: Image.asset(
                      "assets/images/winapp.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
