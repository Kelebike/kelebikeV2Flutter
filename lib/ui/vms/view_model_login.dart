import 'package:flutter/material.dart';
import '../../core/services/service_route.gr.dart';
import '../base/base_view_model.dart';
import '../../core/utils/utilities.dart';

class ViewModelLogin extends ViewModelBase {
  ViewModelLogin(BuildContext context) {
    this.context = context;
  }

  void onPressedUnauthenticatedLogin() {
    Utilities.hideKeyboard(context);
    Utilities.startNewView(context, route: const ViewLoginRoute(), isReplace: true, clearStack: true);
  }
}
