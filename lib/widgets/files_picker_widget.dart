// With Camera for mobile, limitation to 20MB and gridView to dislay images that automatically calculate the available space
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../utils/global_screen_sizes.dart';
import '../utils/global_colors.dart';

class FilesPickerWidget extends StatefulWidget {
  final Function(List<PickedFile>)? onFilesSelected;

  const FilesPickerWidget({
    super.key,
    this.onFilesSelected,
  });

  @override
  State<FilesPickerWidget> createState() => FilesPickerWidgetState();
}

class FilesPickerWidgetState extends State<FilesPickerWidget> {
  final List<PickedFile> _selectedFiles = [];
  final ImagePicker _picker = ImagePicker();
  final double _imageSize = 90.0;
  double _currentTotalBytes = 0.0;
  int _sizeInBytes = 0;
  bool _isHovered = false;

  @override  
  void initState() {
    super.initState();
    if (!kIsWeb) _retrieveLostData(); // Check if Android has terminated the activity
  }

  @override  
  void dispose() {
    super.dispose();
  }

  // Function for delete files in _selectedImage array by contactScreen
  void clearFiles() {
    setState(() {
      _selectedFiles.clear();
    });
    widget.onFilesSelected!(_selectedFiles);
  }
  
  //Function to select images for Web
  Future<void> _pickImagesWeb() async {
    final List<XFile> images = await _picker.pickMultiImage();
    
    if (images.isNotEmpty) {
      // Browse the new images
      for (var img in images) {
        _sizeInBytes = await img.length(); // Calculate the file size

        // Check if adding this file exceeds the limit
        if ((_currentTotalBytes + _sizeInBytes) <= 20 * (1024 * 1024)) {
          setState(() {
            _selectedFiles.add(PickedFile(img, _sizeInBytes));
            _currentTotalBytes += _sizeInBytes; // Update the total size
          });

          // Bridge between FilesPickerWidget and ContactScreen
          widget.onFilesSelected!(_selectedFiles);
        } else {
          if (!mounted) return;

          // Display a message if the limit is exceeded
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '⚠️ An error has occurred : the file ${img.name} exceeds the maximum size of 20 MB'
              ),
            )
          );
        }
      }
    }
  }

  //Function to select images for mobile
  Future<void> _pickImagesMobile(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    
    if (image == null) return;      
    
    final savedImage = await _savePermanently(image); // Save images permanently to prevent missing previews
    final savedSize = await savedImage.length(); // Calculate the file size

    // Check if adding this file exceeds the limit
    if ((_currentTotalBytes + savedSize) <= 20 * (1024 * 1024)) {
      setState(() {
        _selectedFiles.add(PickedFile(savedImage, savedSize));
        _currentTotalBytes += savedSize; // Update the total size
      });
      
      // Bridge between FilesPickerWidget and ContactScreen
      widget.onFilesSelected!(_selectedFiles);    
    } else {        
      if (!mounted) return;

      // Display a message if the limit is exceeded
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '⚠️ An error has occurred : the file ${image.name} exceeds the maximum size of 20 MB',
          )
        )
      );
    }
    
  }

  // Lost Data Management (Android), manage the destruction of MainActivity under high memory pressure
  Future<void> _retrieveLostData() async {
    if (kIsWeb) return; // Not necessary for the web 
    final LostDataResponse response = await _picker.retrieveLostData(); // Ask the ImagePicker for any lost data
    
    if (!response.isEmpty && response.files != null) { // If the response is not empty and contains files, restore them
      for (var img in response.files!) {
        // Save each recovered image permanently (move out of cache)
        final imageRestoredSaved = await _savePermanently(img); // XFile
        final sizeInBytes = await imageRestoredSaved.length(); // Calculate the size 
        setState(()=> _selectedFiles.add(PickedFile(imageRestoredSaved, sizeInBytes)));  
      }
    }
  }

  // Move to a permanent file, by default, images picked with ImagePicker are stored in the app's temporary cache
  Future<XFile> _savePermanently(XFile file) async {
    final directory = await getApplicationDocumentsDirectory(); // Get the application documents directory (a permanent storage location)
    final name = file.name;
    final newPath = '${directory.path}/$name';
    final newFile = await File(file.path).copy(newPath); // Build the new path inside the documents directory
    return XFile(newFile.path); // Return a new XFile pointing to the permanent file
  }

  void _showPikerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImagesMobile(ImageSource.gallery);
                  Navigator.of(context).pop();
                }
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _pickImagesMobile(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = GlobalScreenSizes.isMobileScreen(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion( 
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: SizedBox( // Button 
            child: ElevatedButton(
              onPressed: kIsWeb ? _pickImagesWeb : () => _showPikerOptions(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isHovered ? GlobalColors.thirdColor : GlobalColors.firstColor ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    kIsWeb ? Icons.photo_library : Icons.add_a_photo, 
                    color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor 
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Ajouter des photos',
                    style: TextStyle(
                      color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
        const SizedBox(height: 15.0),
        if (_selectedFiles.isNotEmpty) ...[
          LayoutBuilder( // Automatically calculates the number of columns based on the available width
            builder: (context, constraints) {
              double width = constraints.maxWidth; // Available width
              int crossAxisCount = (width / (_imageSize + 4)).floor();//.clamp(1,12); // "+ 4" AxisSpacing, Floor() Rounds the result down to the nearest integer, clamp() Limits the value between X and X

              return GridView.builder(
                shrinkWrap: true, // Avoid infinite scrolling
                physics: const NeverScrollableScrollPhysics(), // Leave the scroll to the parent
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: isMobile ? _imageSize / (_imageSize + 15) : _imageSize / (_imageSize + 35),
                  mainAxisSpacing: 8.0, // Vertical spacing
                ), 
                itemCount: _selectedFiles.length,
                itemBuilder: (context, index) {
                  final imagePicked = _selectedFiles[index];
                  bool isHovered = false;
  
                  return Center(
                    child: SizedBox(
                      width: _imageSize,
                      child: Column(
                        children: [
                          Stack (
                            children: [
                              kIsWeb ? Image.network(
                                imagePicked.file.path,
                                width: _imageSize,
                                height: _imageSize,
                                fit: BoxFit.cover,
                              )
                              : Image.file(
                                File(imagePicked.file.path),
                                width: _imageSize,
                                height: _imageSize,
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: StatefulBuilder( // Allows to create a local variable "isHovered" for each selected image
                                  builder: (context, setStateLocal) {                          
                                    return MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      onEnter: (_) {
                                        setStateLocal(() => isHovered = true);
                                      },
                                      onExit: (_) {
                                        setStateLocal(() => isHovered = false);
                                      },
                                      child: AnimatedScale(
                                        scale: isHovered ? 1.3 : 1.0,
                                        duration: const Duration(milliseconds: 200),
                                        child: GestureDetector(
                                          onTap: () => setState(() { 
                                            _selectedFiles.remove(imagePicked);
                                            _currentTotalBytes -= imagePicked.size; 
                                          }),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.red
                                          ),
                                        ),
                                      ), 
                                    );
                                  }
                                )  
                              )
                            ],
                          ), 
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    imagePicked.file.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '(${(imagePicked.size / (1024*1024)).toStringAsFixed(2)} Mo)',
                                    style: TextStyle(
                                      color: GlobalColors.fifthColor,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              )
                            )
                          )
                        ],
                      ),
                    ) 
                  ); 
                }
              );
            }
          ),
        ],
        if (_selectedFiles.isNotEmpty) ...[
        const SizedBox(height: 15.0),
        Text('La taille total maximum autorisée est 20 Mo : ${(_currentTotalBytes / (1024 * 1024)).toStringAsFixed(2)} Mo'),
        const SizedBox(height: 24.0),
        ]
      ],
    );
  }
}

class PickedFile{
  final XFile file;
  final int size;

  PickedFile(this.file, this.size);
}




// // With GridView to dislay images that automatically calculate the available space
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import '../utils/global_colors.dart';

// class FilesPickerWidget extends StatefulWidget {
//   const FilesPickerWidget({super.key});

//   @override
//   State<FilesPickerWidget> createState() => _FilesPickerWidget();
// }

// class _FilesPickerWidget extends State<FilesPickerWidget> {
//   final List<XFile> _selectedFiles = [];
//   final ImagePicker _picker = ImagePicker();
//   final double _imageSize = 90.0;
//   bool _isHovered = false;

//   @override  
//   void initState() {
//     super.initState();
//     _retrieveLostData(); // Check if Android has terminated the activity
//   }

//   @override  
//   void dispose() {
//     super.dispose();
//   }

//   Future<void> _pickImages() async {
//     final List<XFile> images = await _picker.pickMultiImage();
    
//     if (images.isNotEmpty) {
//       setState(() => _selectedFiles.addAll(images));
//     }
//   }

//   // Lost Data Management (Android), manage the destruction of MainActivity under high memory pressure
//   Future<void> _retrieveLostData() async {
//     final LostDataResponse response = await _picker.retrieveLostData(); // Ask the ImagePicker for any lost data
    
//     if (!response.isEmpty && response.files != null) { // If the response is not empty and contains files, restore them
//       for (var img in response.files!) {
//         final saved = await _savePermanently(img); // Save each recovered image permanently (move out of cache)
//         setState(()=> _selectedFiles.add(saved));
//       }
//     }
//   }

//   // Move to a permanent file, by default, images picked with ImagePicker are stored in the app's temporary cache
//   Future<XFile> _savePermanently(XFile file) async {
//     final directory = await getApplicationDocumentsDirectory(); // Get the application documents directory (a permanent storage location)
//     final name = file.name;
//     final newPath = '${directory.path}/$name';
//     final newFile = await File(file.path).copy(newPath); // Build the new path inside the documents directory
//     return XFile(newFile.path); // Return a new XFile pointing to the permanent file
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         MouseRegion( 
//           onEnter: (_) => setState(() => _isHovered = true),
//           onExit: (_) => setState(() => _isHovered = false),
//           child: SizedBox( // Button 
//             child: ElevatedButton(
//               onPressed: _pickImages,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _isHovered ? GlobalColors.thirdColor : GlobalColors.firstColor ,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.photo_library, color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'Ajouter des photos',
//                     style: TextStyle(
//                       color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ),
//         const SizedBox(height: 15.0),
//         if (_selectedFiles.isNotEmpty) ...[
//           LayoutBuilder( // Automatically calculates the number of columns based on the available width
//             builder: (context, constraints) {
//               double width = constraints.maxWidth; // Available width
//               int crossAxisCount = (width / (_imageSize + 4)).floor();//.clamp(1,12); // "+ 4" AxisSpacing, Floor() Rounds the result down to the nearest integer, clamp() Limits the value between X and X

//               return GridView.builder(
//                 shrinkWrap: true, // Avoid infinite scrolling
//                 physics: const NeverScrollableScrollPhysics(), // Leave the scroll to the parent
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: crossAxisCount,
//                   // crossAxisSpacing: 8.0,
//                   // mainAxisSpacing: 8.0,
//                 ), 
//                 itemCount: _selectedFiles.length,
//                 itemBuilder: (context, index) {
//                   final image = _selectedFiles[index];
//                   bool isHovered = false;
  
//                   return Center(
//                     child: SizedBox(
//                       width: _imageSize,
//                       height: _imageSize,
//                       child: Stack (
//                         children: [
//                           kIsWeb ? Image.network(
//                             image.path,
//                             width: _imageSize,
//                             height: _imageSize,
//                             fit: BoxFit.cover,
//                           )
//                           : Image.file(
//                             File(image.path),
//                             width: _imageSize,
//                             height: _imageSize,
//                             fit: BoxFit.cover,
//                           ),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: StatefulBuilder( // Allows to create a local variable "isHovered" for each selected image
//                               builder: (context, setStateLocal) {                          
//                                 return MouseRegion(
//                                   cursor: SystemMouseCursors.click,
//                                   onEnter: (_) {
//                                     setStateLocal(() => isHovered = true);
//                                   },
//                                   onExit: (_) {
//                                     setStateLocal(() => isHovered = false);
//                                   },
//                                   child: AnimatedScale(
//                                     scale: isHovered ? 1.3 : 1.0,
//                                     duration: const Duration(milliseconds: 200),
//                                     child: GestureDetector(
//                                       onTap: () => setState(() => _selectedFiles.remove(image)),
//                                       child: const Icon(
//                                         Icons.close,
//                                         color: Colors.red
//                                       ),
//                                     ),
//                                   ), 
//                                 );
//                               }
//                             )  
//                           )
//                         ],
//                       ) 
//                     )
//                   ); 
//                 }
//               );
//             }
//           ),
//           const SizedBox(height: 24.0),
//         ],
//       ],
//     );
//   }
// }

// // With Wrap to dislay images
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../utils/global_colors.dart';

// class FilesPickerWidget extends StatefulWidget {
//   const FilesPickerWidget({super.key});

//   @override
//   State<FilesPickerWidget> createState() => _FilesPickerWidget();
// }

// class _FilesPickerWidget extends State<FilesPickerWidget> {
//   final List<XFile> _selectedFiles = [];
//   final ImagePicker _picker = ImagePicker();
//   final double _imageSize = 90.0;
//   bool _isHovered = false;

//   @override  
//   void initState() {
//     super.initState();
//   }

//   @override  
//   void dispose() {
//     super.dispose();
//   }

//   Future<void> _pickImages() async {
//     final List<XFile> images = await _picker.pickMultiImage();
    
//     if (images.isNotEmpty) {
//       setState(() => _selectedFiles.addAll(images));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         MouseRegion( 
//           onEnter: (_) => setState(() => _isHovered = true),
//           onExit: (_) => setState(() => _isHovered = false),
//           child: SizedBox( // Button 
//             child: ElevatedButton(
//               onPressed: _pickImages,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _isHovered ? GlobalColors.thirdColor : GlobalColors.firstColor ,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.photo_library, color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'Ajouter des photos',
//                     style: TextStyle(
//                       color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ),
//         const SizedBox(height: 15.0),
//         if (_selectedFiles.isNotEmpty) ...[
//             Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: _selectedFiles.map((image) {
//               bool isHovered = false;
//               
//               return Stack (
//                 children: [
//                   kIsWeb ?
//                   Image.network(
//                     image.path,
//                     width: _imageSize,
//                     height: _imageSize,
//                     fit: BoxFit.cover,
//                   )
//                   :
//                   Image.file(
//                     File(image.path),
//                     width: _imageSize,
//                     height: _imageSize,
//                   ),
//                   Positioned(
//                     top: 0.0,
//                     right: 0.0,
//                     child: StatefulBuilder( // Allows to create a local variable "isHovered" for each selected image
//                       builder: (context, setStateLocal) {                                                 
//                         return MouseRegion(
//                           cursor: SystemMouseCursors.click,
//                           onEnter: (_) {
//                             setStateLocal(() => isHovered = true);
//                           },
//                           onExit: (_) {
//                             setStateLocal(() => isHovered = false);
//                           },
//                           child: AnimatedScale(
//                             scale: isHovered ? 1.3 : 1.0,
//                             duration: const Duration(milliseconds: 200),
//                             child: IconButton(
//                               padding: EdgeInsets.zero, // Removes default padding
//                               constraints: BoxConstraints(), // Removes minimum constraints
//                               hoverColor: Colors.transparent,
//                               splashColor: Colors.transparent,
//                               highlightColor: Colors.transparent,
//                               onPressed:  () {
//                                 setState(() {
//                                  _selectedFiles.remove(image);
//                                }); 
//                               },
//                               icon: Icon(
//                                 Icons.close,
//                                 color: Colors.red
//                               ),
//                             )
//                           ), 
//                         );
//                       }
//                     )  
//                   )
//                 ],
//               ); 
//             }).toList(),
//           ),
//           const SizedBox(height: 24.0),
//         ],
//       ],
//     );
//   }
// }