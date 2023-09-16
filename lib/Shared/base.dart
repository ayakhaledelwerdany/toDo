import 'package:flutter/material.dart';

abstract class BaseConnector {
  showLoading();
  showMessage(String message);
  hideDialog();
}

class BaseViewModel<C extends BaseConnector> extends ChangeNotifier {
  C? connector;
}

abstract class BaseView<S extends StatefulWidget, VM extends BaseViewModel>
    extends State<S> implements BaseConnector {
  late VM viewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  VM initMyViewModel();
  BaseView() {
    viewModel = initMyViewModel();
  }
  @override
  hideDialog() {
    Navigator.pop(context);
  }

  @override
  showLoading() {
    showDialog(
        context: context, builder: (context) => CircularProgressIndicator());
  }

  @override
  showMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text(message),
            ));
  }
}
