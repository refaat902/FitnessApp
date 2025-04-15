import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class EnterCredentialsText extends StatelessWidget {
  const EnterCredentialsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AutoSizeText(
            "Please enter your credentials to proceed",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
