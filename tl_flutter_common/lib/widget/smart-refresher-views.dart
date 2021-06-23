import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartRefresherViews {
  static Widget getFooter(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("pull up load");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("Load Failed!Click retry!");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("release to load more");
        } else {
          body = Text("No more Data");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  static getHeader(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus mode) {
        Widget body;
        if (mode == RefreshStatus.idle) {
          body = Text("pull down refresh");
        } else if (mode == RefreshStatus.refreshing) {
          body = CupertinoActivityIndicator();
        } else if (mode == RefreshStatus.canRefresh) {
          body = Text("release to refresh");
        } else if (mode == RefreshStatus.completed) {
          body = Text("refreshCompleted!");
        }
        return Container(
          height: 60.0,
          child: Center(
            child: body,
          ),
        );
      },
    );
  }
}
