import 'dart:io';

import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/utils/pick_image.dart';
import 'package:app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const new({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectedImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: () {
                        selectedImage();
                      },
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(
                            10,
                          ),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectedImage();
                      },
                      child: const DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color: AppPallete.borderColor,
                          dashPattern: [10, 4],
                          radius: Radius.circular(10),
                          strokeCap: StrokeCap.round,
                        ),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 40),
                              SizedBox(height: 15),
                              Text(
                                'Select your image',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      const [
                            'Technology',
                            'Business',
                            'Programming',
                            'Entertainment',
                          ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color: selectedTopics.contains(e)
                                      ? const WidgetStatePropertyAll(
                                          AppPallete.gradient1,
                                        )
                                      : null,
                                  side: const BorderSide(
                                    color: AppPallete.borderColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 10),
              BlogEditor(
                controller: titleController,
                hintText: 'Blog title',
              ),
              const SizedBox(height: 10),
              BlogEditor(
                controller: contentController,
                hintText: 'Blog Content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
