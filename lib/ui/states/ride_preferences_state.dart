import 'package:flutter/foundation.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

/// Global state for ride preferences.
class RidePreferencesState extends ChangeNotifier {
	RidePreferencesState({required RidePreferenceRepository repository})
			: _repository = repository;

	final RidePreferenceRepository _repository;

	RidePreference? _selectedPreference;
	List<RidePreference> _preferenceHistory = [];

	RidePreference? get selectedPreference => _selectedPreference;
	List<RidePreference> get preferenceHistory =>
			List<RidePreference>.unmodifiable(_preferenceHistory);

	Future<void> load() async {
		_selectedPreference = await _repository.getSelectedPreference();
		_preferenceHistory = await _repository.getPreferenceHistory();
		notifyListeners();
	}

	Future<void> selectPreference(RidePreference preference) async {
		if (_selectedPreference == preference) {
			return;
		}

		_selectedPreference = preference;
		await _repository.savePreference(preference);
		_preferenceHistory = await _repository.getPreferenceHistory();
		notifyListeners();
	}
}
