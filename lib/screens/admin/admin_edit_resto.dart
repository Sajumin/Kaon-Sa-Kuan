import 'package:flutter/material.dart';

//   showEditRestoModal(context, data: susansResto, onSave: (updated) { ... });
//
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


class _EditRestoSheet extends StatefulWidget {
  final Map<String, dynamic> data;
  final void Function(Map<String, dynamic> updated) onSave;

  const _EditRestoSheet({required this.data, required this.onSave});

  @override
  State<_EditRestoSheet> createState() => _EditRestoSheetState();
}

class _EditRestoSheetState extends State<_EditRestoSheet> {
  static const Color warmTangerine = Color(0xFFF47B42);

  final List<String> _tagList = [
    'Breakfast', 'Streetfood', 'Coffee', 'Lunch', 'Drinks', 'Pastry',
    'Dinner', 'Sushi', 'Pasta', 'Merienda', 'Noodles', 'Pizza',
    'Chicken', 'BBQ / Grill', 'Veggies', 'Pork', 'Samgyup', 'Fish',
    'Silog', 'Soup', 'Seafood',
  ];

  bool _showTags = false;

  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _locationCtrl;
  late TextEditingController _minPriceCtrl;
  late TextEditingController _maxPriceCtrl;
  late TextEditingController _openCtrl;
  late TextEditingController _closeCtrl;
  late TextEditingController _fbCtrl;
  late Set<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    final d = widget.data;
    _nameCtrl     = TextEditingController(text: d['name'] ?? '');
    _descCtrl     = TextEditingController(text: d['description'] ?? '');
    _locationCtrl = TextEditingController(text: d['location'] ?? '');
    _minPriceCtrl = TextEditingController(text: '${d['averageCostMin'] ?? ''}');
    _maxPriceCtrl = TextEditingController(text: '${d['averageCostMax'] ?? ''}');
    _openCtrl     = TextEditingController(text: d['openTime'] ?? '');
    _closeCtrl    = TextEditingController(text: d['closeTime'] ?? '');
    _fbCtrl       = TextEditingController(text: d['facebookPage'] ?? '');

    // Seed selected tags from mealTags + foodType combined
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

  void _handleSave() {
    final updated = Map<String, dynamic>.from(widget.data);
    updated['name']           = _nameCtrl.text.trim();
    updated['description']    = _descCtrl.text.trim();
    updated['location']       = _locationCtrl.text.trim();
    updated['averageCostMin'] = int.tryParse(_minPriceCtrl.text.trim()) ?? updated['averageCostMin'];
    updated['averageCostMax'] = int.tryParse(_maxPriceCtrl.text.trim()) ?? updated['averageCostMax'];
    updated['openTime']       = _openCtrl.text.trim();
    updated['closeTime']      = _closeCtrl.text.trim();
    updated['facebookPage']   = _fbCtrl.text.trim();
    updated['mealTags']       = _selectedTags.toList();
    Navigator.pop(context);
    widget.onSave(updated);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      // Takes up most of the screen height
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          _SheetHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 4, 20, bottomInset + 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: warmTangerine, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Restaurant Name'),
                    _buildTextField(_nameCtrl, 'Type restaurant name...'),

                    _buildLabel('Description'),
                    _buildTextField(_descCtrl, 'Type description...', maxLines: 5),

                    _buildLabel('Location'),
                    _buildTextField(_locationCtrl, 'Type location...'),

                    _buildLabel('Price Range'),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(_minPriceCtrl, 'Min (e.g. 35)',
                              keyboardType: TextInputType.number),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Text(
                            '–',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 18,
                              color: warmTangerine,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _buildTextField(_maxPriceCtrl, 'Max (e.g. 150)',
                              keyboardType: TextInputType.number),
                        ),
                      ],
                    ),

                    _buildLabel('Opening Hours'),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(_openCtrl, 'Open (e.g. 06:00)'),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Text(
                            '–',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 18,
                              color: warmTangerine,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _buildTextField(_closeCtrl, 'Close (e.g. 20:00)'),
                        ),
                      ],
                    ),

                    _buildLabel('Facebook Page / Account'),
                    _buildTextField(_fbCtrl, 'Type Facebook page or account...'),
                    GestureDetector(
                      onTap: () => setState(() => _showTags = !_showTags),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: warmTangerine),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Tags',
                                  style: TextStyle(
                                    fontFamily: 'Afacad',
                                    color: warmTangerine,
                                    fontSize: 16,
                                  ),
                                ),
                                if (_selectedTags.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: warmTangerine.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${_selectedTags.length} selected',
                                      style: const TextStyle(
                                        fontFamily: 'Afacad',
                                        color: warmTangerine,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Icon(
                              _showTags
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (_showTags)
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 0,
                          children: _tagList.map((tag) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: _selectedTags.contains(tag),
                                    activeColor: warmTangerine,
                                    onChanged: (val) {
                                      setState(() {
                                        val!
                                            ? _selectedTags.add(tag)
                                            : _selectedTags.remove(tag);
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      tag,
                                      style: const TextStyle(
                                          fontFamily: 'Afacad', fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                    // ── Photo ──
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Click to Change Photo',
                          style: TextStyle(
                              fontFamily: 'Afacad',
                              color: warmTangerine,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: warmTangerine.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.image_outlined,
                          size: 50, color: Colors.black38),
                    ),

                    const SizedBox(height: 28),

                    // action buttons
                    Row(
                      children: [
                        // Cancel
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13),
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
                        // Save
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: _handleSave,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13),
                              decoration: BoxDecoration(
                                color: warmTangerine,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: warmTangerine.withOpacity(0.35),
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

  Widget _buildLabel(String text) {
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

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
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
            color: warmTangerine.withOpacity(0.5),
            fontStyle: FontStyle.italic,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: warmTangerine),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: warmTangerine, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader();

  static const Color warmTangerine = Color(0xFFF47B42);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Drag handle
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

        // Title row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: warmTangerine.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: warmTangerine.withOpacity(0.25), width: 1),
                ),
                child: const Icon(Icons.edit_outlined,
                    color: warmTangerine, size: 20),
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

        // Divider
        Container(height: 1, color: const Color(0xFFF9C06A)),
        const SizedBox(height: 12),
      ],
    );
  }
}