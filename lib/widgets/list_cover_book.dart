import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';

class ListCoverBook extends StatefulWidget {
  final List<String> lstCoverBookUrl;
  final Function fn;
  
  const ListCoverBook({super.key, required this.lstCoverBookUrl, required this.fn});

  @override
  State<ListCoverBook> createState() => _ListCoverBookState();
}

class _ListCoverBookState extends State<ListCoverBook> {
  int currentIndex = 0;
  late Gallery3DController controller;

  @override
  void initState() {
    controller = Gallery3DController(
      itemCount: widget.lstCoverBookUrl.length,
      autoLoop: false,
      // ellipseHeight: 0,
      // minScale: 0.8
      ellipseHeight: 0,
      minScale: 0.5
    );
    super.initState();
  }

  Widget buildGallery3D() {
    return Gallery3D(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      itemConfig: GalleryItemConfig(
        width: MediaQuery.of(context).size.width * 90 / 100,
        height: MediaQuery.of(context).size.height * 70 / 100,
        radius: 5,
        isShowTransformMask: true,
        shadows: [
          const BoxShadow(
              color: Color(0x90000000), offset: Offset(2, 0), blurRadius: 5)
        ]
      ),
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.height * 72 / 100),
      isClip: false,

      // currentIndex: currentIndex,
      onItemChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      onClickItem: (index) => {
        //debugPrint("--------------------->${widget.lstCoverBookUrl[index]}"),
        widget.fn(widget.lstCoverBookUrl[index])
        // Navigator.pop(context, widget.lstCoverBookUrl[index])
      },
      itemBuilder: (context, index) {
        return Image.network(
          widget.lstCoverBookUrl[index],
          fit: BoxFit.fill,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 80 / 100,
      child: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                BackgrounBlurView(
                  imageUrl: widget.lstCoverBookUrl[currentIndex],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: buildGallery3D(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // if (currentIndex >= 1) {
                      controller.jumpTo(--currentIndex);
                    // } 
                    // else {
                    //   currentIndex = widget.lstCoverBookUrl.length;
                    //   controller.jumpTo(currentIndex - 1);
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(0, 0, 0, 0).withOpacity(0),
                    foregroundColor: Colors.greenAccent
                  ),
                  child: const Icon(Icons.arrow_back_ios),
                ),
                ElevatedButton(
                  onPressed: () {
                    // if (currentIndex <= widget.lstCoverBookUrl.length) {
                      controller.animateTo(++currentIndex);
                    // }
                    // controller.animateTo(currentIndex <= widget.lstCoverBookUrl.length ? ++currentIndex : widget.lstCoverBookUrl.length);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.greenAccent
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.greenAccent
                  ),
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}

class BackgrounBlurView extends StatelessWidget {
  final String imageUrl;
  const BackgrounBlurView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ))
    ]);
  }
}