import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/provider/topic_page_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/topic_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicsPage extends StatefulWidget {
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TopicPageModel>(
        model: TopicPageModel(),
        onModelInit: (model) {
          model.refresh();
        },
        builder: (context, model, child) {
          return LoadingContainer(
              loading: model.loading,
              child: SmartRefresher(
                  controller: model.refreshController,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: true,
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return TopicWidgetItem(
                            itemModel: model.itemList[index]);
                      },
                      itemCount: model.itemList.length)));
        });
  }

  @override
  bool get wantKeepAlive => true;
}
