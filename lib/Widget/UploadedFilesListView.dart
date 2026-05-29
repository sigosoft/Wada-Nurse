import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Utils/utils.dart';

class UploadedFilesListView extends StatelessWidget {
  final List<XFile> uploadedFiles;
  final Function(int) onRemove;
  const UploadedFilesListView({
    super.key,
    required this.uploadedFiles,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: uploadedFiles.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child:
                      uploadedFiles[index].path.startsWith('http')
                          ? AuthenticatedImage(
                            url: uploadedFiles[index].path,
                            fit: BoxFit.cover,
                          )
                          : Image.file(
                            File(uploadedFiles[index].path),
                            fit: BoxFit.cover,
                          ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    onRemove(index);
                  },
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: blackTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 14),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AuthenticatedImage extends StatefulWidget {
  final String url;
  final BoxFit fit;
  const AuthenticatedImage({super.key, required this.url, required this.fit});

  @override
  State<AuthenticatedImage> createState() => _AuthenticatedImageState();
}

class _AuthenticatedImageState extends State<AuthenticatedImage> {
  Uint8List? _bytes;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(AuthenticatedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = false;
    });
    try {
      final token = getSavedObject("token");
      final dio = Dio();

      String relativePath = widget.url;
      if (relativePath.contains('storage/')) {
        relativePath = relativePath.substring(
          relativePath.indexOf('storage/') + 8,
        );
      }

      final urls = [
        widget.url,
        "https://thewada.com/wada-backend/storage/$relativePath",
        "https://thewada.com/wada-backend/$relativePath",
      ];

      Response<List<int>>? successfulResponse;

      for (var url in urls) {
        // 1. Try with token
        try {
          debugPrint("Trying image URL with token: $url");
          final response = await dio.get<List<int>>(
            url,
            options: Options(
              responseType: ResponseType.bytes,
              headers:
                  token != null ? {"Authorization": "Bearer $token"} : null,
            ),
          );
          if (response.statusCode == 200 && response.data != null) {
            successfulResponse = response;
            debugPrint("Successfully loaded image (with token) from: $url");
            break;
          }
        } catch (e) {
          debugPrint("Failed to load image (with token) from $url: $e");
        }

        // 2. Try without token (in case CDN/WAF blocks Authorization headers on static resources)
        try {
          debugPrint("Trying image URL without token: $url");
          final response = await dio.get<List<int>>(
            url,
            options: Options(responseType: ResponseType.bytes),
          );
          if (response.statusCode == 200 && response.data != null) {
            successfulResponse = response;
            debugPrint("Successfully loaded image (without token) from: $url");
            break;
          }
        } catch (e) {
          debugPrint("Failed to load image (without token) from $url: $e");
        }
      }

      if (successfulResponse != null && mounted) {
        setState(() {
          _bytes = Uint8List.fromList(successfulResponse!.data!);
          _loading = false;
        });
      } else {
        if (mounted) {
          setState(() {
            _error = true;
            _loading = false;
          });
        }
      }
    } catch (e) {
      debugPrint("Error in _loadImage loop: $e");
      if (mounted) {
        setState(() {
          _error = true;
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: colorPrimary),
        ),
      );
    }
    if (_error || _bytes == null) {
      return const Center(child: Icon(Icons.broken_image, color: Colors.grey));
    }
    return Image.memory(_bytes!, fit: widget.fit);
  }
}
