import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget(
      {super.key,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.controller});
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      decoration: InputDecoration(
          suffixIcon: widget.suffixIcon ??
              IconButton(
                  onPressed: () {
                    widget.controller?.clear();
                    widget.onChanged!('');
                  },
                  icon: const Icon(Icons.clear)),
          prefixIcon: widget.prefixIcon ?? const Icon(Icons.search),
          hintText: widget.hintText ?? AppLocalizations.of(context)!.search,
          labelText: widget.labelText),
    );
  }
}
