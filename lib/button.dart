import 'package:flutter/material.dart';

import 'appColors.dart';

class OFFButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  final FocusNode focusNode;
  final double elevation;
  final double hoverElevation;
  final double focusElevation;
  final double highlightElevation;

  OFFButton(
      {@required this.text,
      this.onPressed,
      this.focusNode,
      this.elevation = 2.0,
      this.hoverElevation = 4.0,
      this.focusElevation = 4.0,
      this.highlightElevation = 8.0})
      : assert(text != null);

  @override
  _OFFButtonState createState() => _OFFButtonState();
}

class _OFFButtonState extends State<OFFButton> {
  bool _highlight = false;
  bool _focused = false;
  bool _hovering = false;

  void _handleHighlightChanged(bool value) {
    if (_highlight != value) {
      setState(() {
        _highlight = value;
      });
    }
  }

  @override
  @override
  void didUpdateWidget(OFFButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_highlight) {
      _highlight = false;
    }
  }

  double _effectiveElevation() {
    if (_highlight) {
      return widget.highlightElevation;
    }
    if (_hovering) {
      return widget.hoverElevation;
    }
    if (_focused) {
      return widget.focusElevation;
    }
    return widget.elevation;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: true,
      child: Focus(
        focusNode: widget.focusNode,
        onFocusChange: (bool focused) => setState(() {
          _focused = focused;
        }),
        child: Material(
          clipBehavior: Clip.antiAlias,
          textStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          color: Colors.transparent,
          elevation: _effectiveElevation(),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: const [
                AppColors.toolbar_gradient_start,
                AppColors.toolbar_gradient_end
              ],
              begin: AlignmentDirectional.centerEnd,
              end: AlignmentDirectional.centerStart,
            )),
            child: InkWell(
              onHighlightChanged: _handleHighlightChanged,
              onTap: widget.onPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35.0, vertical: 15.0),
                child: Text(widget.text.toUpperCase(),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const BoxConstraints _kFABSizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

class OFFFloatingActionButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  final FocusNode focusNode;
  final double elevation;
  final double hoverElevation;
  final double focusElevation;
  final double highlightElevation;

  OFFFloatingActionButton(
      {@required this.icon,
      this.onPressed,
      this.focusNode,
      this.elevation = 2.0,
      this.hoverElevation = 4.0,
      this.focusElevation = 4.0,
      this.highlightElevation = 8.0})
      : assert(icon != null);

  @override
  _OFFFloatingActionButtonState createState() =>
      _OFFFloatingActionButtonState();
}

class _OFFFloatingActionButtonState extends State<OFFFloatingActionButton> {
  bool _highlight = false;
  bool _focused = false;
  bool _hovering = false;

  void _handleHighlightChanged(bool value) {
    if (_highlight != value) {
      setState(() {
        _highlight = value;
      });
    }
  }

  @override
  @override
  void didUpdateWidget(OFFFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_highlight) {
      _highlight = false;
    }
  }

  double _effectiveElevation() {
    if (_highlight) {
      return widget.highlightElevation;
    }
    if (_hovering) {
      return widget.hoverElevation;
    }
    if (_focused) {
      return widget.focusElevation;
    }
    return widget.elevation;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: true,
      child: Focus(
        focusNode: widget.focusNode,
        onFocusChange: (bool focused) => setState(() {
          _focused = focused;
        }),
        child: Material(
          clipBehavior: Clip.antiAlias,
          textStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
          shape: const CircleBorder(),
          color: Colors.transparent,
          elevation: _effectiveElevation(),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: const [
              AppColors.toolbar_gradient_start,
              AppColors.toolbar_gradient_end
            ])),
            child: InkWell(
              onHighlightChanged: _handleHighlightChanged,
              onTap: widget.onPressed,
              child: IconTheme.merge(
                data: IconThemeData(
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .foregroundColor),
                child: Container(
                  constraints: _kFABSizeConstraints,
                  child: Icon(widget.icon, size: 21.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
