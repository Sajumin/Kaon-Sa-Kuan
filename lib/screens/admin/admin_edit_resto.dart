import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:kaon_sa_kuan/backend/services/cloudinary_service.dart';
import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_app_colors.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_form_fields.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_tag_selector.dart';

/// Opens the edit bottom sheet.
///
/// ```dart
/// showEditRestoModal(context, data: susansResto, onSave: (updated) { ... });
/// ```
void showEditRestoModal(
  BuildContext context, {
  required Map<String, dynamic> data,
  required void Function(Map<String, dynamic> updated) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _EditRestoSheet(data: data, onSave: onSave),
  );
}

// ─────────────────────────────────────────────────────────────────────────────

class _EditRestoSheet extends StatefulWidget {
  final Map<String, dynamic> data;
  final void Function(Map<String, dynamic> updated) onSave;

  const _EditRestoSheet({required this.data, required this.onSave});

  @override
  State<_EditRestoSheet> createState() => _EditRestoSheetState();
}

class _EditRestoSheetState extends State<_EditRestoSheet> {
  final CloudinaryService _cloudinaryService = CloudinaryService();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _minPriceCtrl;
  late final TextEditingController _maxPriceCtrl;
  late final TextEditingController _openCtrl;
  late final TextEditingController _closeCtrl;
  late final TextEditingController _fbCtrl;
  late Set<String> _selectedTags;

  File? _selectedImage;
  String? _imageUrl;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final d = widget.data;
    _nameCtrl = TextEditingController(text: d['name'] ?? '');
    _descCtrl = TextEditingController(text: d['description'] ?? '');
    _locationCtrl = TextEditingController(text: d['location'] ?? '');
    _minPriceCtrl = TextEditingController(text: '${d['averageCostMin'] ?? ''}');
    _maxPriceCtrl = TextEditingController(text: '${d['averageCostMax'] ?? ''}');
    _openCtrl = TextEditingController(text: d['openTime'] ?? '');
    _closeCtrl = TextEditingController(text: d['closeTime'] ?? '');
    _fbCtrl = TextEditingController(text: d['facebookPage'] ?? '');
    _imageUrl = d['imageUrl'];

    // Seed tags from mealTags + foodType
    final existing = <String>{};
    if (d['mealTags'] is List) {
      for (final t in d['mealTags']) existing.add(t.toString());
    }
    if (d['foodType'] is List) {
      for (final t in d['foodType']) existing.add(t.toString());
    }
    _selectedTags = existing;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _locationCtrl.dispose();
    _minPriceCtrl.dispose();
    _maxPriceCtrl.dispose();
    _openCtrl.dispose();
    _closeCtrl.dispose();
    _fbCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile == null) return;

    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }

  Future<void> _handleSave() async {
    try {
      setState(() {
        _isUploading = true;
      });

      String finalImageUrl = _imageUrl ?? '';

      // upload new image if user selected one
      if (_selectedImage != null) {
        finalImageUrl =
            (await _cloudinaryService.uploadImage(_selectedImage!)) ?? '';
      }

      final updated = Map<String, dynamic>.from(widget.data)
        ..['name'] = _nameCtrl.text.trim()
        ..['description'] = _descCtrl.text.trim()
        ..['location'] = _locationCtrl.text.trim()
        ..['averageCostMin'] = int.tryParse(_minPriceCtrl.text.trim()) ??
            widget.data['averageCostMin']
        ..['averageCostMax'] = int.tryParse(_maxPriceCtrl.text.trim()) ??
            widget.data['averageCostMax']
        ..['openTime'] = _openCtrl.text.trim()
        ..['closeTime'] = _closeCtrl.text.trim()
        ..['facebookPage'] = _fbCtrl.text.trim()
        ..['mealTags'] = _selectedTags.toList()
        ..['imageUrl'] = finalImageUrl;

      if (!mounted) return;

      Navigator.pop(context);
      widget.onSave(updated);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const _SheetHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 4, 20, bottomInset + 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: kWarmTangerine, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildFormLabel('Restaurant Name'),
                    buildFormTextField('Type restaurant name...',
                        controller: _nameCtrl),

                    buildFormLabel('Description'),
                    buildFormTextField('Type description...',
                        controller: _descCtrl, maxLines: 5),

                    buildFormLabel('Location'),
                    buildFormTextField('Type location...',
                        controller: _locationCtrl),

                    buildFormLabel('Price Range'),
                    buildRangeFields(
                      leftHint: 'Min (e.g. 35)',
                      rightHint: 'Max (e.g. 150)',
                      leftController: _minPriceCtrl,
                      rightController: _maxPriceCtrl,
                      keyboardType: TextInputType.number,
                    ),

                    buildFormLabel('Opening Hours'),
                    buildRangeFields(
                      leftHint: 'Open (e.g. 06:00)',
                      rightHint: 'Close (e.g. 20:00)',
                      leftController: _openCtrl,
                      rightController: _closeCtrl,
                    ),

                    buildFormLabel('Facebook Page / Account'),
                    buildFormTextField('Type Facebook page or account...',
                        controller: _fbCtrl),

                    AdminTagSelector(
                      selectedTags: _selectedTags,
                      onChanged: (updated) =>
                          setState(() => _selectedTags = updated),
                    ),

                    const SizedBox(height: 20),

                    buildFormLabel('Restaurant Photo'),

                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: kWarmTangerine),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _selectedImage != null
                              ? Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                )
                              : (_imageUrl != null && _imageUrl!.isNotEmpty)
                                  ? Image.network(
                                      _imageUrl!,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: Colors.grey.shade100,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo_outlined,
                                            size: 45,
                                            color: kWarmTangerine,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Tap to change photo',
                                            style: TextStyle(
                                              fontFamily: 'Afacad',
                                              color: kWarmTangerine,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.1),
                                    width: 1.5),
                              ),
                              child: const Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontFamily: 'Afacad',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: _handleSave,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              decoration: BoxDecoration(
                                color: kWarmTangerine,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: kWarmTangerine.withOpacity(0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Save Changes',
                                  style: TextStyle(
                                    fontFamily: 'Afacad',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SheetHeader extends StatelessWidget {
  const _SheetHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: kWarmTangerine.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: kWarmTangerine.withOpacity(0.25), width: 1),
                ),
                child: const Icon(Icons.edit_outlined,
                    color: kWarmTangerine, size: 20),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Restaurant',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Update the details below and save.',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 13,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(height: 1, color: kGoldenBorder),
        const SizedBox(height: 12),
      ],
    );
  }
}
