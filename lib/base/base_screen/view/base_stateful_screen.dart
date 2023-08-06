import 'package:flutter/material.dart';

import '../controller/base_stateful_controller.dart';

abstract class BaseStatefulScreen<T extends BaseStatefulController>
    extends StatefulWidget {
  const BaseStatefulScreen({
    super.key,
    required this.controller,
    this.withTicker = false,
  });
  final T controller;
  final bool withTicker;

  Widget buildView(BuildContext context);

  @override
  State<BaseStatefulScreen> createState() => withTicker
      ? _BaseStatefulScreenStateTicker()
      : _BaseStatefulScreenState();
}

class _BaseStatefulScreenState extends State<BaseStatefulScreen> {
  @override
  void initState() {
    widget.controller.initState(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.context = context;
    return widget.buildView(context);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}

class _BaseStatefulScreenStateTicker extends State<BaseStatefulScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    widget.controller.initState(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildView(context);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
