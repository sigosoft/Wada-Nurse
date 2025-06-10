import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waaada_nurseapp/View/Map/ChooseLocation.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key, required this.shiftType}) : super(key: key);
  final String shiftType;
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;
  int _currentCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _currentCameraIndex = _cameras.indexWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    if (_currentCameraIndex == -1) {
      _currentCameraIndex = 0; // Default to the first camera if no front camera is found
    }
    _controller = CameraController(
      _cameras[_currentCameraIndex],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  void _flipCamera() async {
    if (_cameras.length > 1) {
      await _controller.dispose(); // Dispose the current controller
      _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length; // Switch camera index
      _controller = CameraController(
        _cameras[_currentCameraIndex],
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize(); // Reinitialize the controller
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon:  SvgPicture.asset('lib/Assets/Images/flip_camera.svg', color: Colors.white, ),
                    onPressed: _flipCamera,
                  ),
                  IconButton(
                    icon:  SvgPicture.asset('lib/Assets/Images/shutter.svg', color: Colors.white, ),
                    onPressed: () async {
                      try {
                        await _initializeControllerFuture;
                        final image = await _controller.takePicture();
                        if (!mounted) return;
                        Get.to(DisplayPictureScreen(imagePath: image.path, shiftType: widget.shiftType));
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.flash_on, color: Colors.white, size: 30),
                    onPressed: () {
                      setState(() {
                        _controller.setFlashMode(FlashMode.torch);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String shiftType;

  const DisplayPictureScreen({Key? key, required this.imagePath,required this.shiftType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.file(File(imagePath)),
          const SizedBox(height: 20),
          IconButton(
            icon: const Icon(Icons.camera, color: Colors.white, size: 50),
            onPressed: () {
             Get.to(ChooseLocation(shiftType: shiftType));
            },
          ),

        ],
      ),
    );
  }
}