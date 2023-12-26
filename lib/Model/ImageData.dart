// ignore_for_file: non_constant_identifier_names
import 'dart:typed_data';

/// A model class to represent image data, including the image path (as Uint8List)
/// and a description.
class ImageData {
  /// The image path, represented as Uint8List.
  Uint8List ImagePath;

  /// A description associated with the image.
  String Description;

  /// Constructor to initialize the ImageData instance.
  ///
  /// Parameters:
  /// - [ImagePath]: The image path as Uint8List.
  /// - [Description]: A description associated with the image.
  ImageData({required this.ImagePath, required this.Description});
}
