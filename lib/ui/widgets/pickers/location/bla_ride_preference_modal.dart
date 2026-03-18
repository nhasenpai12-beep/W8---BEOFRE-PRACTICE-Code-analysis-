import 'package:flutter/material.dart';

import '../../../../main_common.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../buttons/bla_icon_button.dart';
import '../ride_preference/bla_ride_preference_picker.dart';

//
// Wrap the ride preference picker within a modal
//
class RidePreferenceModal extends StatefulWidget {
  const RidePreferenceModal({
    super.key,
    required this.initialPreference,
    required this.maxSeat,
    required this.serviceLocator,
  });

  final RidePreference? initialPreference;
  final int maxSeat;
  final ServiceLocator serviceLocator;

  @override
  State<RidePreferenceModal> createState() => _RidePreferenceModalState();
}

class _RidePreferenceModalState extends State<RidePreferenceModal> {
  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onRidePreferenceSelected(RidePreference newPreference) {
    Navigator.of(context).pop<RidePreference>(newPreference);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back icon
            BlaIconButton(onPressed: onBackSelected, icon: Icons.close),
            SizedBox(height: BlaSpacings.m),

            // Title
            Text(
              "Edit your search",
              style: BlaTextStyles.title.copyWith(color: BlaColors.textNormal),
            ),

            // Form
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BlaRidePreferencePicker(
                  initRidePreference: widget.initialPreference,
                  maxSeat: widget.maxSeat,
                  serviceLocator: widget.serviceLocator,
                  onRidePreferenceSelected: onRidePreferenceSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
