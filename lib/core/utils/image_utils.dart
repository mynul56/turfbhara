import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';

class ImageUtils {
  static final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  static Future<File?> pickImageFromGallery({
    int? imageQuality,
    double? maxWidth,
    double? maxHeight,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality ?? AppConstants.defaultImageQuality,
        maxWidth: maxWidth ?? AppConstants.maxImageWidth,
        maxHeight: maxHeight ?? AppConstants.maxImageHeight,
      );
      return image != null ? File(image.path) : null;
    } catch (_) {
      return null;
    }
  }

  // Pick image from camera
  static Future<File?> pickImageFromCamera({
    int? imageQuality,
    double? maxWidth,
    double? maxHeight,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality ?? AppConstants.defaultImageQuality,
        maxWidth: maxWidth ?? AppConstants.maxImageWidth,
        maxHeight: maxHeight ?? AppConstants.maxImageHeight,
      );
      return image != null ? File(image.path) : null;
    } catch (_) {
      return null;
    }
  }

  // Pick multiple images
  static Future<List<File>> pickMultipleImages({
    int? imageQuality,
    double? maxWidth,
    double? maxHeight,
    int? maxImages,
  }) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: imageQuality ?? AppConstants.defaultImageQuality,
        maxWidth: maxWidth ?? AppConstants.maxImageWidth,
        maxHeight: maxHeight ?? AppConstants.maxImageHeight,
      );
      final limitedImages = maxImages != null && images.length > maxImages
          ? images.take(maxImages).toList()
          : images;
      return limitedImages.map((image) => File(image.path)).toList();
    } catch (_) {
      return [];
    }
  }

  // Show image source selection dialog
  static Future<File?> showImageSourceDialog(
    BuildContext context, {
    int? imageQuality,
    double? maxWidth,
    double? maxHeight,
  }) async {
    File? result;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  result = await pickImageFromGallery(
                    imageQuality: imageQuality,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  result = await pickImageFromCamera(
                    imageQuality: imageQuality,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
    return result;
  }

  // Image validation
  static bool isValidImageFile(File file) {
    final extension = path.extension(file.path).toLowerCase();
    return AppConstants.allowedImageExtensions.contains(extension);
  }

  static bool isValidImageSize(File file) {
    final sizeInBytes = file.lengthSync();
    return sizeInBytes <= AppConstants.maxImageSizeBytes;
  }

  static Future<bool> isValidImageDimensions(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = await decodeImageFromList(bytes);
      return image.width <= AppConstants.maxImageWidth &&
          image.height <= AppConstants.maxImageHeight;
    } catch (_) {
      return false;
    }
  }

  static Future<String?> validateImage(File file) async {
    if (!isValidImageFile(file)) {
      return 'Invalid image format. Allowed formats: ${AppConstants.allowedImageExtensions.join(', ')}';
    }
    if (!isValidImageSize(file)) {
      final maxSizeMB = AppConstants.maxImageSizeBytes / (1024 * 1024);
      return 'Image size too large. Maximum size: ${maxSizeMB.toStringAsFixed(1)}MB';
    }
    if (!await isValidImageDimensions(file)) {
      return 'Image dimensions too large. Maximum: ${AppConstants.maxImageWidth.toInt()}x${AppConstants.maxImageHeight.toInt()}';
    }
    return null;
  }

  // Image information
  static Future<Map<String, dynamic>> getImageInfo(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final sizeInBytes = file.lengthSync();
      return {
        'width': image.width,
        'height': image.height,
        'sizeInBytes': sizeInBytes,
        'sizeInMB': sizeInBytes / (1024 * 1024),
        'extension': path.extension(file.path),
        'fileName': path.basename(file.path),
        'aspectRatio': image.width / image.height,
      };
    } catch (_) {
      return {};
    }
  }

  // Image processing (compression, resizing, cropping)
  static Future<File?> compressImage(
    File file, {
    int quality = 85,
    double? maxWidth,
    double? maxHeight,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      final image = await decodeImageFromList(bytes);

      double newWidth = image.width.toDouble();
      double newHeight = image.height.toDouble();

      if (maxWidth != null && newWidth > maxWidth) {
        final ratio = maxWidth / newWidth;
        newWidth = maxWidth;
        newHeight = newHeight * ratio;
      }
      if (maxHeight != null && newHeight > maxHeight) {
        final ratio = maxHeight / newHeight;
        newHeight = maxHeight;
        newWidth = newWidth * ratio;
      }

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, newWidth, newHeight),
        Paint(),
      );

      final picture = recorder.endRecording();
      final compressedImage =
          await picture.toImage(newWidth.toInt(), newHeight.toInt());
      final compressedBytes =
          await compressedImage.toByteData(format: ui.ImageByteFormat.png);

      if (compressedBytes == null) return null;

      final tempDir = await getTemporaryDirectory();
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_compressed.png';
      final compressedFile = File(path.join(tempDir.path, fileName));
      await compressedFile.writeAsBytes(compressedBytes.buffer.asUint8List());
      return compressedFile;
    } catch (_) {
      return null;
    }
  }

  static Future<File?> resizeImage(
    File file, {
    required double width,
    required double height,
    bool maintainAspectRatio = true,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      final image = await decodeImageFromList(bytes);

      double newWidth = width;
      double newHeight = height;

      if (maintainAspectRatio) {
        final aspectRatio = image.width / image.height;
        if (width / height > aspectRatio) {
          newWidth = height * aspectRatio;
        } else {
          newHeight = width / aspectRatio;
        }
      }

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, newWidth, newHeight),
        Paint(),
      );

      final picture = recorder.endRecording();
      final resizedImage =
          await picture.toImage(newWidth.toInt(), newHeight.toInt());
      final resizedBytes =
          await resizedImage.toByteData(format: ui.ImageByteFormat.png);

      if (resizedBytes == null) return null;

      final tempDir = await getTemporaryDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_resized.png';
      final resizedFile = File(path.join(tempDir.path, fileName));
      await resizedFile.writeAsBytes(resizedBytes.buffer.asUint8List());
      return resizedFile;
    } catch (_) {
      return null;
    }
  }

  static Future<File?> cropImageToSquare(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final size = image.width < image.height ? image.width : image.height;
      final offsetX = (image.width - size) / 2;
      final offsetY = (image.height - size) / 2;

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      canvas.drawImageRect(
        image,
        Rect.fromLTWH(offsetX, offsetY, size.toDouble(), size.toDouble()),
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        Paint(),
      );

      final picture = recorder.endRecording();
      final croppedImage = await picture.toImage(size, size);
      final croppedBytes =
          await croppedImage.toByteData(format: ui.ImageByteFormat.png);

      if (croppedBytes == null) return null;

      final tempDir = await getTemporaryDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_cropped.png';
      final croppedFile = File(path.join(tempDir.path, fileName));
      await croppedFile.writeAsBytes(croppedBytes.buffer.asUint8List());
      return croppedFile;
    } catch (_) {
      return null;
    }
  }

  // Image caching
  static Future<String> getCacheDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(path.join(appDir.path, 'image_cache'));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir.path;
  }

  static Future<File?> getCachedImage(String url) async {
    try {
      final cacheDir = await getCacheDirectory();
      final fileName = url.hashCode.toString();
      final cachedFile = File(path.join(cacheDir, fileName));
      if (await cachedFile.exists()) {
        return cachedFile;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<File?> cacheImage(String url, Uint8List bytes) async {
    try {
      final cacheDir = await getCacheDirectory();
      final fileName = url.hashCode.toString();
      final cachedFile = File(path.join(cacheDir, fileName));
      await cachedFile.writeAsBytes(bytes);
      return cachedFile;
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearImageCache() async {
    try {
      final cacheDir = await getCacheDirectory();
      final directory = Directory(cacheDir);
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    } catch (_) {}
  }

  static Future<int> getCacheSizeInBytes() async {
    try {
      final cacheDir = await getCacheDirectory();
      final directory = Directory(cacheDir);
      if (!await directory.exists()) {
        return 0;
      }
      int totalSize = 0;
      await for (final entity in directory.list(recursive: true)) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }
      return totalSize;
    } catch (_) {
      return 0;
    }
  }

  // Image utilities
  static String generateImageFileName(
      {String? prefix, String extension = '.jpg'}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefixPart = prefix != null ? '${prefix}_' : '';
    return '$prefixPart$timestamp$extension';
  }

  static Future<File?> saveImageToGallery(File imageFile) async {
    // This would require a plugin like gallery_saver. For now, just return the file.
    return imageFile;
  }

  static Future<Uint8List?> imageToBytes(File imageFile) async {
    try {
      return await imageFile.readAsBytes();
    } catch (_) {
      return null;
    }
  }

  static Future<File?> bytesToImage(Uint8List bytes, String fileName) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File(path.join(tempDir.path, fileName));
      await file.writeAsBytes(bytes);
      return file;
    } catch (_) {
      return null;
    }
  }

  // Image format conversion (PNG/JPEG)
  static Future<File?> convertToJpeg(File imageFile, {int quality = 85}) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      canvas.drawImage(image, Offset.zero, Paint());

      final picture = recorder.endRecording();
      final convertedImage = await picture.toImage(image.width, image.height);
      final convertedBytes =
          await convertedImage.toByteData(format: ui.ImageByteFormat.png);

      if (convertedBytes == null) return null;

      final tempDir = await getTemporaryDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final convertedFile = File(path.join(tempDir.path, fileName));
      await convertedFile.writeAsBytes(convertedBytes.buffer.asUint8List());
      return convertedFile;
    } catch (_) {
      return null;
    }
  }

  static Future<File?> convertToPng(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      canvas.drawImage(image, Offset.zero, Paint());

      final picture = recorder.endRecording();
      final convertedImage = await picture.toImage(image.width, image.height);
      final convertedBytes =
          await convertedImage.toByteData(format: ui.ImageByteFormat.png);

      if (convertedBytes == null) return null;

      final tempDir = await getTemporaryDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final convertedFile = File(path.join(tempDir.path, fileName));
      await convertedFile.writeAsBytes(convertedBytes.buffer.asUint8List());
      return convertedFile;
    } catch (_) {
      return null;
    }
  }

  // Image effects
  static Future<File?> applyGrayscaleFilter(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      final paint = Paint()
        ..colorFilter = const ColorFilter.matrix([
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]);

      canvas.drawImage(image, Offset.zero, paint);

      final picture = recorder.endRecording();
      final filteredImage = await picture.toImage(image.width, image.height);
      final filteredBytes =
          await filteredImage.toByteData(format: ui.ImageByteFormat.png);

      if (filteredBytes == null) return null;

      final tempDir = await getTemporaryDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_grayscale.png';
      final filteredFile = File(path.join(tempDir.path, fileName));
      await filteredFile.writeAsBytes(filteredBytes.buffer.asUint8List());
      return filteredFile;
    } catch (_) {
      return null;
    }
  }

  // Image placeholder
  static Widget buildImagePlaceholder({
    double? width,
    double? height,
    IconData icon = Icons.image,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: iconColor ?? Colors.grey[400],
        size: (width != null && height != null)
            ? (width < height ? width : height) * 0.3
            : 48,
      ),
    );
  }

  static Widget buildImageError({
    double? width,
    double? height,
    String? errorMessage,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[400],
            size: 32,
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
