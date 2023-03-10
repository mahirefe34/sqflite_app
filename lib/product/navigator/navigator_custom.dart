import 'package:flutter/material.dart';
import '../../features/bpm/model/bp_model.dart';
import '../../features/bpm/page/bp_add_edit_view.dart';
import '../../features/bpm/page/bp_home_view.dart';
import '../../features/bpm/page/bp_detail_view.dart';

mixin NavigatorCustom on Widget {
  static const _paraf = "/";

  Route<dynamic>? onGenerareRoute(RouteSettings routeSettings) {
    if (routeSettings.name?.isEmpty ?? true) {
      return _navigateToNormal(const BPHomePage());
    }

    final routes = routeSettings.name == NavigatorCustom._paraf
        ? NavigateCustomEnum.init
        : NavigateCustomEnum.values.byName(
            routeSettings.name!.substring(1),
          );

    switch (routes) {
      case NavigateCustomEnum.init:
        return _navigateToNormal(const BPHomePage());

      case NavigateCustomEnum.addEditBP:
        var model = routeSettings.arguments as BPModel?;

        return _navigateToNormal(BPAddEditPage(
          model: model,
        ));

      case NavigateCustomEnum.detailBP:
        var model = routeSettings.arguments as BPModel;
        return _navigateToNormal(BPDetailPage(modelId: model.id!),
            isFullScreenDialog: true);
    }
  }

  Route<dynamic>? _navigateToNormal(Widget child, {bool? isFullScreenDialog}) {
    return MaterialPageRoute(
      fullscreenDialog: isFullScreenDialog ?? false,
      builder: (context) {
        return child;
      },
    );
  }
}

extension NavigateCustomExtension on NavigateCustomEnum {
  String get withParaf => "/$name";
}

enum NavigateCustomEnum { init, addEditBP, detailBP }
