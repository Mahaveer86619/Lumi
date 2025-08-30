import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:country_picker/country_picker.dart';

class MyFormTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final String label;
  final bool obscureText;
  final String? Function(String?) validator;
  final String? initialText;
  final bool? disableInput;

  const MyFormTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.keyboardAction,
    this.obscureText = false,
    required this.validator,
    this.initialText,
    this.disableInput = false,
  });

  @override
  State<MyFormTextField> createState() => _MyFormTextFieldState();
}

class _MyFormTextFieldState extends State<MyFormTextField> {
  bool _visibility = true; // For password field

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialText,
      validator: widget.validator,
      obscureText: widget.obscureText ? _visibility : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.keyboardAction,
      enabled: !widget.disableInput!,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = value;
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _visibility ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  setState(() {
                    _visibility = !_visibility;
                  });
                },
              )
            : null,
      ),
    );
  }
}

class MyBigTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final int? lines;
  final String? initialValue;
  final bool? disableInput;

  const MyBigTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.lines,
    this.initialValue,
    this.disableInput = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: null,
      minLines: lines,
      enabled: !disableInput!,
      autocorrect: true,
      onChanged: (value) {
        controller.text = value;
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class MyPhoneField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final String label;
  final bool? disableInput;

  const MyPhoneField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.keyboardAction,
    this.disableInput = false,
  });

  @override
  State<MyPhoneField> createState() => _MyPhoneFieldState();
}

class _MyPhoneFieldState extends State<MyPhoneField> {
  Country selectedCountry = Country(
    phoneCode: "+91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextField(
      keyboardType: widget.keyboardType,
      textInputAction: widget.keyboardAction,
      maxLines: 1,
      enabled: !widget.disableInput!,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = "${selectedCountry.phoneCode}$value";
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                countryListTheme: const CountryListThemeData(
                  bottomSheetHeight: 550,
                ),
                onSelect: (value) {
                  selectedCountry = value;
                },
              );
            },
            child: Text(
              "${selectedCountry.flagEmoji} ${selectedCountry.phoneCode}",
              style: TextStyle(
                fontSize: 18,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PinCodeField extends StatelessWidget {
  final TextEditingController otpController;
  const PinCodeField({
    super.key,
    required this.otpController,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Pinput(
      length: 6,
      showCursor: true,
      defaultPinTheme: PinTheme(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.colorScheme.onSurface,
          ),
        ),
        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onSurface,
            ),
      ),
      controller: otpController,
    );
  }
}