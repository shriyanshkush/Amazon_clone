import 'dart:io';

import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';

class AdminServices{
  void sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
}) async{
    try {

      final cloudinary = Cloudinary.unsignedConfig(
        cloudName: "dxx2cuoew",
      );
      List<String> imageUrls = [];

      for (var file in images) {
        final response = await cloudinary.unsignedUpload(
          file: file.path,
          uploadPreset: "rkz9gk91",
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: name,
          fileName: '${name}-${DateTime.now().millisecondsSinceEpoch}', // Use unique names if needed
          progressCallback: (count, total) {
            print('Uploading ${file.path} with progress: $count/$total');
          },
        );

        if (response.isSuccessful) {
          imageUrls.add(response.secureUrl!);
          print('Uploaded ${file.path} to ${response.secureUrl}');
        } else {
          print('Failed to upload ${file.path}');
        }
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }
}