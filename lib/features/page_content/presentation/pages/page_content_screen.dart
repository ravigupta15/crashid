import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/lookup/language_provider.dart';
import 'package:crashid/core/widget/html_text_widget.dart';
import 'package:crashid/features/page_content/provider/page_content_notifier.dart';
import 'package:crashid/features/page_content/provider/page_content_state.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'hide Provider;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PageContentScreen extends ConsumerStatefulWidget {
static const kSlug = "/kSlug";

final String? slug;
  static void open(BuildContext context, {String? slug}) {
    context.push(AppRoutesPath.pageContentScreen,extra: {
      kSlug: slug
    });
  }

  const PageContentScreen({super.key, this.slug});

  @override
  ConsumerState<PageContentScreen> createState() => _PageContentScreenState();
}

class _PageContentScreenState extends ConsumerState<PageContentScreen> {

String currentLng = 'en';
 
final pageContentNotifier =
    AsyncNotifierProvider<PageContentNotifier, PageContentState>(PageContentNotifier.new);


@override
  void initState() {
    _callInitFunction();
    super.initState();
  }

 void _callInitFunction() {
  final current = Provider.of<LanguageProvider>(context, listen: false).locale;
      currentLng = current.languageCode;
      _callPageContentApi();
 }

  void _callPageContentApi() async{
    ref.read(pageContentNotifier.notifier).pageContent(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    final refState = ref.watch(pageContentNotifier);
    var model = refState.value?.pageContentResponseModel?.data;
    final cleanHtml = (model?.contentEn ?? '').replaceAll('&nbsp;', ' ');
    return Scaffold(
      appBar: CustomAppBar(
        title: currentLng == 'en' ? model?.titleEn : model?.titleDe,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.only(
        left: 20, right: 20, top: 20, bottom: 40
      ),
      child: Html(
          data: cleanHtml,
          style: {
            "h1": Style(
              fontSize: FontSize(24),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            "h2": Style(
              fontSize: FontSize(18),
              fontWeight: FontWeight.w600,
              margin: Margins.only(top: 12, bottom: 8),
            ),
            "p": Style(
              fontSize: FontSize(14),
              lineHeight: LineHeight.em(1.2),
            ),
          },
          onLinkTap: (url, attributes, element) async {
            if (url != null) {
              final Uri uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                debugPrint('Could not launch $url');
              }
            }
          },
          onAnchorTap: (url, attributes, element) async {
            if (url != null) {
              final Uri uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                debugPrint('Could not launch $url');
              }
            }
          },
        ),
      // ),
        // child: 
        // ),
      
    ));
  }
}