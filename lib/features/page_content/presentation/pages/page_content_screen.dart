import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/lookup/language_provider.dart';
import 'package:crashid/core/widget/html_text_widget.dart';
import 'package:crashid/features/page_content/provider/page_content_notifier.dart';
import 'package:crashid/features/page_content/provider/page_content_state.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'hide Provider;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: CustomAppBar(
        title: currentLng == 'en' ? model?.titleEn : model?.titleDe,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.only(
        left: 20, right: 20, top: 20, bottom: 40
      ),
        child: HtmlTextWidget(  
          htmlContent: currentLng == 'en' ? model?.contentEn ?? '' : model?.contentDe ?? '',
        ),
      
    ));
  }
}