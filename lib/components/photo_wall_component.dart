import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PhotoWallComponent extends StatelessWidget {
  const PhotoWallComponent({
    super.key,
    required this.photos,  
  });

  final List<String> photos;

  @override
  Widget build(BuildContext context) {
    // We center the grid and constrain it so it doesn't use the entire screen width
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1600.0),
        padding: const EdgeInsets.all(16.0),
        child: StaggeredGrid.count( // Using to create a non-scrollable staggered grid
          crossAxisCount: 4, // The grid is divided into X columns
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: List.generate(photos.length, (index) {
            int crossAxisCellCount = (index % 4 == 0) ? 2 : 1;
            int mainAxisCellCount = (index % 3 == 0) ? 2 : 1; 

            return StaggeredGridTile.count(
              crossAxisCellCount: crossAxisCellCount,
              mainAxisCellCount: mainAxisCellCount,
              child: PhotoGridItem(
                imageUrl: photos[index], 
                heroTag: 'photo-$index' // Unique tag by index
              ),
            );
          }),
        )
      ),
    );
  }
}

class PhotoGridItem extends StatelessWidget {
  const PhotoGridItem({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });
  
  final String imageUrl;
  final String heroTag;  

  void _openEnlargedImage(BuildContext context) {
    // Show a dialog overlay with the enlarged image
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7), // Color overlay background
      builder: (context) {
        return GestureDetector(
          // Tap anywhere to close the enlarged view
          onTap: () => Navigator.of(context).pop(),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Hero(
                tag: heroTag, // Matches the tag for animated transition
                child: InteractiveViewer(
                  scaleEnabled: false, // Doesn't allow for zooming and panning of the enlarged image
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use MouseRegion to change the cursor on desktop and GestureDetector for tap actions.
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openEnlargedImage(context), // Triggers the opening of the enlarged image on click/tap
        child: Hero(
          tag: heroTag,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

// // WITHOUT DYNAMIC LIST
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import '../utils/global_others.dart';

// class PhotoWallComponent extends StatelessWidget {
//   PhotoWallComponent({super.key});

//   // Liste list of image URLs (or asset paths)
//   final List<String> imageUrls = [
//     GlobalImages.backgroundLanding,
//     GlobalImages.backgroundLanding,
//     GlobalImages.backgroundLanding,
//     GlobalImages.backgroundLanding,
//     GlobalImages.backgroundLanding,
//     GlobalImages.backgroundLanding,
//     GlobalImages.backgroundLanding,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     // We center the grid and constrain it so it doesn't use the entire screen width.
//     return Center(
//       child: Container(
//         constraints: const BoxConstraints(maxWidth: 1400.0),
//         padding: const EdgeInsets.all(8.0),
//         // Using to create a non-scrollable staggered grid
//         child: StaggeredGrid.count(
//           crossAxisCount: 4, // The grid is divided into X columns
//           mainAxisSpacing: 4,
//           crossAxisSpacing: 4,
//           children: [
//              // Each tile defines how many columns and rows it occupies. 
//              // You can customize these values to vary the size of the images.
//             StaggeredGridTile.count(
//               crossAxisCellCount: 2,
//               mainAxisCellCount: 2,
//               child: PhotoGridItem(imageUrl: imageUrls[0]),
//             ),
//             StaggeredGridTile.count(
//               crossAxisCellCount: 2,
//               mainAxisCellCount: 1,
//               child: PhotoGridItem(imageUrl: imageUrls[1]),
//             ),
//             StaggeredGridTile.count(
//               crossAxisCellCount: 1,
//               mainAxisCellCount: 1,
//               child: PhotoGridItem(imageUrl: imageUrls[2]),
//             ),
//             StaggeredGridTile.count(
//               crossAxisCellCount: 1,
//               mainAxisCellCount: 1,
//               child: PhotoGridItem(imageUrl: imageUrls[3]),
//             ),
//             StaggeredGridTile.count(
//               crossAxisCellCount: 4,
//               mainAxisCellCount: 2,
//               child: PhotoGridItem(imageUrl: imageUrls[4]),
//             ),
//             StaggeredGridTile.count(
//               crossAxisCellCount: 2,
//               mainAxisCellCount: 2,
//               child: PhotoGridItem(imageUrl: imageUrls[5]),
//             ),
//             if (imageUrls.length > 6)
//               StaggeredGridTile.count(
//                 crossAxisCellCount: 2,
//                 mainAxisCellCount: 3,
//                 child: PhotoGridItem(imageUrl: imageUrls[6]),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PhotoGridItem extends StatelessWidget {
//   final String imageUrl;

//   const PhotoGridItem({super.key, required this.imageUrl});

//   void _openEnlargedImage(BuildContext context) {
//     // Show a dialog overlay with the enlarged image
//     showDialog(
//       context: context,
//       barrierColor: Colors.black, // Color overlay background
//       builder: (context) {
//         return GestureDetector(
//           // Tap anywhere to close the enlarged view
//           onTap: () => Navigator.of(context).pop(),
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: Colors.black,
//             child: Center(
//               child: Hero(
//                 tag: imageUrl, // Matches the tag for animated transition
//                 child: InteractiveViewer(
//                   // Doesn't allow for zooming and panning of the enlarged image
//                   scaleEnabled: false,
//                   child: Image.network(
//                     imageUrl,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Use MouseRegion to change the cursor on desktop and GestureDetector for tap actions.
//     return MouseRegion(
//       cursor: SystemMouseCursors.click, 
//       child: GestureDetector(
//         onTap: () => _openEnlargedImage(context), // Triggers the opening of the enlarged image on click/tap
//         child: Hero(
//           tag: imageUrl,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }












