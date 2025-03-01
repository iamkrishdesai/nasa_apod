import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nasa_apod/controller/apodcontroller.dart';
import 'dart:ui';

class Apodview extends StatefulWidget {
  @override
  State<Apodview> createState() => _ApodviewState();
}

class _ApodviewState extends State<Apodview> {
  final apodcontroller = Get.put(Apodcontroller());
  late ScrollController _scrollController;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollProgress = (_scrollController.offset / 200).clamp(0.0, 1.0);
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NASA APOD'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: GetX<Apodcontroller>(
        builder: (controller) {
          if (controller.apodfact.value == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          return Stack(
            children: [
              // Background Image with Blur
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 15 * _scrollProgress,
                    sigmaY: 15 * _scrollProgress,
                  ),
                  child: Image.network(
                    controller.apodfact.value!.url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3 + (0.4 * _scrollProgress)),
                        Colors.black.withOpacity(0.7 + (0.3 * _scrollProgress)),
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              CustomScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                slivers: [
                  // App Bar
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.6,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                      title: Text(
                        controller.apodfact.value!.title,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      background: Hero(
                        tag: 'apod_image',
                        child: Transform.scale(
                          scale: 1 + (_scrollProgress * 0.1),
                          child: Image.network(
                            controller.apodfact.value!.url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Content
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Interactive Buttons
                          _buildInteractionBar(),
                          SizedBox(height: 20),
                          // Date
                          Text(
                            DateFormat('MMMM d, y').format(DateTime.parse(
                                controller.apodfact.value!.date.toString())),
                            style: GoogleFonts.ptSans(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 16),
                          // Explanation
                          Text(
                            controller.apodfact.value!.explanation ?? "",
                            style: GoogleFonts.ptSans(
                              color: Colors.white,
                              fontSize: 18,
                              height: 1.6,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInteractionBar() {
    return Row(
      children: [
        _buildInteractiveButton(
          icon: Icons.favorite,
          text: isSaved ? 'Saved' : 'Save',
          isActive: isSaved, // Change color based on saved state
          onTap: () {
            setState(() {
              isSaved = isSaved == false ? true : false; // Toggle save state
            });
            Get.snackbar(
              'Success',
              isSaved
                  ? 'Image saved successfully!'
                  : 'Image removed from saved!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white.withOpacity(0.1),
              colorText: Colors.white,
            );
          },
        ),
        SizedBox(width: 16),
        _buildInteractiveButton(
          isActive: false,
          icon: Icons.share,
          text: 'Share',
          onTap: () {
            Get.snackbar(
              'Feature Coming Soon',
              'Share feature will be available in the next update!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white.withOpacity(0.1),
              colorText: Colors.white,
            );
          },
        ),
      ],
    );
  }

  Widget _buildInteractiveButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool isActive, // New parameter to manage button state
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.green.withOpacity(0.8)
              : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
