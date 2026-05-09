import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_app_colors.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_form_fields.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_tag_selector.dart';

class AddNewResto extends StatefulWidget {
  const AddNewResto({super.key});

  @override
  State<AddNewResto> createState() => _AddNewRestoState();
}

class _AddNewRestoState extends State<AddNewResto> {
  Set<String> _selectedTags = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kWarmTangerine,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add New Restaurant',
          style: TextStyle(
            fontFamily: 'Afacad',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: kWarmTangerine, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormTextField('Type restaurant name...'),
              buildFormTextField('Type Description ...', maxLines: 5),
              buildFormTextField('Type Location...'),
              buildFormTextField('Type Price Range...'),
              buildFormTextField('Type Opening Hours...'),
              buildFormTextField('Type Facebook Page / Account'),

              AdminTagSelector(
                selectedTags: _selectedTags,
                onChanged: (updated) =>
                    setState(() => _selectedTags = updated),
              ),

              buildPhotoSection(),

              const SizedBox(height: 25),

              // Submit button
              Center(
                child: Container(
                  width: 200,
                  height: 45,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kWarmTangerine,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Submit Restaurant',
                      style: TextStyle(
                          fontFamily: 'Afacad',
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}