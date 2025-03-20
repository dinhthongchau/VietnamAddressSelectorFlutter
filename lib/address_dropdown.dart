// lib/widgets/address_dropdown.dart
import 'package:flutter/material.dart';
import 'location_model.dart';
import 'location_service.dart';

class AddressDropdown extends StatefulWidget {
  const AddressDropdown({super.key});

  @override
  State<AddressDropdown> createState() => _AddressDropdownState();
}

class _AddressDropdownState extends State<AddressDropdown> {
  final LocationService _locationService = LocationService();
  List<Province> provinces = [];
  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  Future<void> _loadProvinces() async {
    try {
      provinces = await _locationService.fetchProvinces();
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading provinces: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const CircularProgressIndicator();

    return Column(
      children: [
        DropdownButtonFormField<Province>(
          decoration: const InputDecoration(labelText: 'Chọn tỉnh thành'),
          value: selectedProvince,
          items: provinces.map((province) {
            return DropdownMenuItem<Province>(
              value: province,
              child: Text(province.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedProvince = value;
              selectedDistrict = null;
              selectedWard = null;
            });
          },
        ),
        DropdownButtonFormField<District>(
          decoration: const InputDecoration(labelText: 'Chọn quận huyện'),
          value: selectedDistrict,
          items: selectedProvince?.districts.map((district) {
            return DropdownMenuItem<District>(
              value: district,
              child: Text(district.name),
            );
          }).toList() ?? [],
          onChanged: (value) {
            setState(() {
              selectedDistrict = value;
              selectedWard = null;
            });
          },
        ),
        DropdownButtonFormField<Ward>(
          decoration: const InputDecoration(labelText: 'Chọn phường xã'),
          value: selectedWard,
          items: selectedDistrict?.wards.map((ward) {
            return DropdownMenuItem<Ward>(
              value: ward,
              child: Text(ward.name),
            );
          }).toList() ?? [],
          onChanged: (value) {
            setState(() => selectedWard = value);
          },
        ),
      ],
    );
  }
}