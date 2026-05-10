import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kaon_sa_kuan/backend/controllers/restaurant_controller.dart';
import 'package:kaon_sa_kuan/backend/services/cloudinary_service.dart';

import 'package:kaon_sa_kuan/config/restaurant_tags.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_app_colors.dart';

class AddNewResto extends StatefulWidget {
  const AddNewResto({super.key});

  @override
  State<AddNewResto> createState() => _AddNewRestoState();
}

class _AddNewRestoState extends State<AddNewResto> {
  static const Color warmTangerine = Color(0xFFF47B42);

  final RestaurantController _restaurantController = RestaurantController();

  final CloudinaryService _cloudinaryService = CloudinaryService();

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _priceRangeController = TextEditingController();

  final TextEditingController _openingHoursController = TextEditingController();

  final TextEditingController _facebookPageController = TextEditingController();

  bool _showTags = false;

  bool _isLoading = false;

  File? _selectedImage;

  final List<String> _tagList = RestaurantTags.tags;

  final Set<String> _selectedTags = {};

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _priceRangeController.dispose();
    _openingHoursController.dispose();
    _facebookPageController.dispose();

    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _submitRestaurant() async {
    try {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please select an image.',
            ),
          ),
        );

        return;
      }

      setState(() {
        _isLoading = true;
      });

      final imageUrl = await _cloudinaryService.uploadImage(
        _selectedImage!,
      );

      if (imageUrl == null) {
        throw Exception(
          'Image upload failed.',
        );
      }

      await _restaurantController.addRestaurant(
        name: _nameController.text,
        description: _descriptionController.text,
        location: _locationController.text,
        priceRange: _priceRangeController.text,
        openingHours: _openingHoursController.text,
        facebookPage: _facebookPageController.text,
        imageUrl: imageUrl,
        tags: _selectedTags.toList(),
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Restaurant added successfully!',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kWarmTangerine,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
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
            border: Border.all(
              color: kWarmTangerine,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                'Type restaurant name...',
                controller: _nameController,
              ),

              _buildTextField(
                'Type Description...',
                controller: _descriptionController,
                maxLines: 5,
              ),

              _buildTextField(
                'Type Location...',
                controller: _locationController,
              ),

              _buildTextField(
                'Type Price Range...',
                controller: _priceRangeController,
              ),

              _buildTextField(
                'Type Opening Hours...',
                controller: _openingHoursController,
              ),

              _buildTextField(
                'Type Facebook Page / Account',
                controller: _facebookPageController,
              ),

              // Tags Header
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showTags = !_showTags;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: warmTangerine,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tags',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          color: warmTangerine,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        _showTags
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ),

              // Tags
              if (_showTags)
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Wrap(
                    spacing: 8,
                    children: _tagList.map((tag) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          children: [
                            Checkbox(
                              value: _selectedTags.contains(
                                tag,
                              ),
                              activeColor: warmTangerine,
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    _selectedTags.add(tag);
                                  } else {
                                    _selectedTags.remove(tag);
                                  }
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                tag,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

              // Add Photo
              Center(
                child: TextButton(
                  onPressed: _pickImage,
                  child: const Text(
                    'Click to Add Photo',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      color: warmTangerine,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Image Preview
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: warmTangerine.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: Colors.black,
                      ),
              ),

              const SizedBox(height: 25),

              // Submit Button
              Center(
                child: SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitRestaurant,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: warmTangerine,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Submit Restaurant',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              color: Colors.white,
                              fontSize: 16,
                            ),
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

  Widget _buildTextField(
    String hint, {
    int maxLines = 1,
    required TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Afacad',
            color: warmTangerine.withOpacity(0.5),
            fontStyle: FontStyle.italic,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: warmTangerine,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: warmTangerine,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
