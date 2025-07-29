import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/colors.dart';
import '../core/theme/text_styles.dart';

enum BerryInputType {
  text,
  email,
  password,
  search,
  multiline,
}

class BerryInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final BerryInputType type;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final EdgeInsets? contentPadding;
  
  const BerryInput({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.type = BerryInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines,
    this.maxLength,
    this.textInputAction,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.contentPadding,
  });
  
  factory BerryInput.search({
    Key? key,
    String? hint = 'Search...',
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onTap,
    bool autofocus = false,
  }) {
    return BerryInput(
      key: key,
      type: BerryInputType.search,
      hint: hint,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      autofocus: autofocus,
      prefixIcon: const Icon(Icons.search, color: AppColors.neutralMedium),
      textInputAction: TextInputAction.search,
    );
  }
  
  factory BerryInput.password({
    Key? key,
    String? label = 'Password',
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? errorText,
  }) {
    return BerryInput(
      key: key,
      type: BerryInputType.password,
      label: label,
      hint: hint,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      textInputAction: TextInputAction.done,
    );
  }
  
  factory BerryInput.email({
    Key? key,
    String? label = 'Email',
    String? hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? errorText,
  }) {
    return BerryInput(
      key: key,
      type: BerryInputType.email,
      label: label,
      hint: hint,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      textInputAction: TextInputAction.next,
    );
  }
  
  @override
  State<BerryInput> createState() => _BerryInputState();
}

class _BerryInputState extends State<BerryInput> {
  bool _obscureText = true;
  late FocusNode _focusNode;
  bool _isFocused = false;
  
  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }
  
  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }
  
  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.labelLarge.copyWith(
              color: widget.errorText != null 
                  ? AppColors.error 
                  : AppColors.darkTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isFocused ? [
              BoxShadow(
                color: AppColors.primaryPurple.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            obscureText: widget.type == BerryInputType.password ? _obscureText : false,
            keyboardType: _getKeyboardType(),
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.type == BerryInputType.multiline 
                ? (widget.maxLines ?? 3) 
                : (widget.maxLines ?? 1),
            maxLength: widget.maxLength,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.bodyLarge.tertiary,
              prefixIcon: widget.prefixIcon,
              suffixIcon: _buildSuffixIcon(),
              errorText: widget.errorText,
              helperText: widget.helperText,
              filled: true,
              fillColor: _getFillColor(),
              border: _getBorder(false, false),
              enabledBorder: _getBorder(false, false),
              focusedBorder: _getBorder(true, false),
              errorBorder: _getBorder(false, true),
              focusedErrorBorder: _getBorder(true, true),
              contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              counterStyle: AppTextStyles.caption,
            ),
          ),
        ),
        
        if (widget.helperText != null && widget.errorText == null) ...[
          const SizedBox(height: 4),
          Text(
            widget.helperText!,
            style: AppTextStyles.caption.darkSecondary,
          ),
        ],
      ],
    );
  }
  
  Widget? _buildSuffixIcon() {
    if (widget.type == BerryInputType.password) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.neutralMedium,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    
    if (widget.type == BerryInputType.search && widget.controller?.text.isNotEmpty == true) {
      return IconButton(
        icon: const Icon(
          Icons.clear,
          color: AppColors.neutralMedium,
        ),
        onPressed: () {
          widget.controller?.clear();
          widget.onChanged?.call('');
        },
      );
    }
    
    return widget.suffixIcon;
  }
  
  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case BerryInputType.email:
        return TextInputType.emailAddress;
      case BerryInputType.multiline:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }
  
  Color _getFillColor() {
    if (!widget.enabled) {
      return AppColors.cardBackgroundDark.withValues(alpha: 0.5);
    }
    
    if (widget.errorText != null) {
      return AppColors.error.withValues(alpha: 0.05);
    }
    
    if (_isFocused) {
      return AppColors.cardBackgroundDark;
    }
    
    return AppColors.cardBackgroundDark;
  }
  
  OutlineInputBorder _getBorder(bool isFocused, bool hasError) {
    Color borderColor;
    double borderWidth;
    
    if (hasError) {
      borderColor = AppColors.error;
      borderWidth = 2.0;
    } else if (isFocused) {
      borderColor = AppColors.primaryPurple;
      borderWidth = 2.0;
    } else {
      borderColor = AppColors.cardBorder;
      borderWidth = 1.0;
    }
    
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    );
  }
}

// Specialized search bar with berry theme
class BerrySearchBar extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onFilterTap;
  final bool showFilter;
  final EdgeInsets? margin;
  
  const BerrySearchBar({
    super.key,
    this.hint = 'Search music, artists, albums...',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.showFilter = false,
    this.margin,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: BerryInput.search(
              hint: hint,
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          ),
          if (showFilter) ...[
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: onFilterTap,
                icon: const Icon(
                  Icons.tune,
                  color: AppColors.textOnPrimary,
                ),
                tooltip: 'Filters',
                iconSize: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }
}