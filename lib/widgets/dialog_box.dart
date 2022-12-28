import 'package:flutter/material.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/constants/ui.dart';
import 'package:nappy_mobile/util/responsive.dart';

enum DialogType {
  info,
  error,
  success,
}

class DialogBox extends StatelessWidget {
  final String title;
  final String content;
  final ButtonStyleButton? cancelHandle;
  final VoidCallback continueHandle;
  final String continueText;
  final DialogType type;
  const DialogBox({
    super.key,
    required this.title,
    required this.content,
    this.cancelHandle,
    required this.continueHandle,
    required this.continueText,
    this.type = DialogType.error,
  });

  static const Map<DialogType, Color> _colorMap = {
    DialogType.info: NappyColors.divider,
    DialogType.error: NappyColors.danger,
    DialogType.success: NappyColors.success,
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = _colorMap[type]!;
    final isMobile = Responsive.isSmallScreen(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: color, // wtf is null?
              ),
              iconTheme: IconThemeData(color: color),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  kDefaultMargin,
                  Wrap(
                    children: [
                      const Icon(Icons.info),
                      const SizedBox(
                        width: 8,
                      ),
                      SelectableText(
                        title,
                        style: textTheme.headline1!.copyWith(
                          fontSize: isMobile ? 20 : 22,
                          color: _colorMap[type],
                        ),
                      ),
                    ],
                  ),
                  kDefaultMargin,
                  SelectableText(
                    content,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: NappyColors.dark,
                        ),
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: color.withOpacity(0.1),
                    ),
                    onPressed: continueHandle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: Text(
                        continueText,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: color,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required String continueText,
    VoidCallback? onContinue,
    required DialogType type,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          type: type,
          title: title,
          content: content,
          continueHandle: onContinue ?? () => Navigator.pop(context),
          continueText: continueText,
        );
      },
    );
  }
}
