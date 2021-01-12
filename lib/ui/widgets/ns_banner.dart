import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class NSBanner extends StatefulWidget {
  @override
  _NSBannerState createState() => _NSBannerState();
}

class _NSBannerState extends State<NSBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        height: MediaQuery.of(context).size.height / 3,
        autoPlay: true,
        // autoPlayInterval: Duration(milliseconds: 50),
        // autoPlayAnimationDuration: Duration(milliseconds: 1),
        pauseAutoPlayOnTouch: Duration(seconds: 2),
        items: List().map((bannerModel) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.amber
                ),
                child: Stack(
                    children: <Widget>[ 
                      Center(child: CircularProgressIndicator()),
                      Center(
                    child: FadeInImage.memoryNetwork(
                      image: bannerModel.link,
                      placeholder: kTransparentImage,
                      //width: 100,
                      //height: 100,
                      //fit: BoxFit.contain,
                    ),
                  ),
                    ]),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
