import 'package:flutter/material.dart';
import 'admin_app_colors.dart';

/// Section label above a form field.
Widget buildFormLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'Afacad',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    ),
  );
}

/// Styled text field with the warm-tangerine border used throughout admin forms.
///
/// [controller] is required for editable forms (edit sheet).
/// For the add-new screen the plain hint-only variant is fine — pass
/// [controller] as null and the field is uncontrolled.
Widget buildFormTextField(
  String hint, {
  TextEditingController? controller,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontFamily: 'Afacad', fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Afacad',
          color: kWarmTangerine.withOpacity(0.5),
          fontStyle: FontStyle.italic,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kWarmTangerine),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kWarmTangerine, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

/// Two text fields separated by a "–" dash (used for price & hours ranges).
Widget buildRangeFields({
  required String leftHint,
  required String rightHint,
  TextEditingController? leftController,
  TextEditingController? rightController,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Row(
    children: [
      Expanded(
        child: buildFormTextField(
          leftHint,
          controller: leftController,
          keyboardType: keyboardType,
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Text(
          '–',
          style: TextStyle(
            fontFamily: 'Afacad',
            fontSize: 18,
            color: kWarmTangerine,
          ),
        ),
      ),
      Expanded(
        child: buildFormTextField(
          rightHint,
          controller: rightController,
          keyboardType: keyboardType,
        ),
      ),
    ],
  );
}

/// Photo placeholder + "Click to add/change" button used in both add & edit.
Widget buildPhotoSection({String buttonLabel = 'Click to Add Photo'}) {
  return Column(
    children: [
      Center(
        child: TextButton(
          onPressed: () {},
          child: Text(
            buttonLabel,
            style: const TextStyle(
              fontFamily: 'Afacad',
              color: kWarmTangerine,
              fontSize: 16,
            ),
          ),
        ),
      ),
      Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: kWarmTangerine.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.image_outlined,
            size: 50, color: Colors.black38),
      ),
    ],
  );
}