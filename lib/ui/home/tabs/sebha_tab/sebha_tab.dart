import 'package:flutter/material.dart';
import 'package:islami_c18_dokki/theme/text_styles.dart';
import 'package:islami_c18_dokki/ui/home/tabs/sebha_tab/models/sebha.dart';
import 'package:islami_c18_dokki/ui/home/widgets/base_tab.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  int zakrIndex = 0;
  double turns = 0.0;
  final PageController sebhaController = PageController();


 @override
  void dispose() {
    sebhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BaseTab(
      image: "assets/images/sebha_background.png",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset("assets/images/img_header.png",width: width * 0.6,)],
            ),
          ),

          Text(
            "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
            style: TextStyles.titleLargeStyle(),
          ),

          InkWell(
            onTap: () {
              setState(() {
                counter++;
                turns += 1 / 30;
                if (counter == 30) {
                  _changeZakr(null);
                  sebhaController.animateToPage(
                    zakrIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(30),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentGeometry.center,
                children: [
                  Positioned(
                    top: -75,
                    right: 115,
                    child: Image.asset(
                      "assets/images/sebha_head.png",
                      width: 70,
                    ),
                  ),
                  AnimatedRotation(
                    turns: turns,
                    duration: Duration(milliseconds: 200),
                    child: Image.asset("assets/images/sebha_body.png"),
                  ),
                  Column(

                    children: [
                      Container(
                        height: 100,
                        width: 250,
                        alignment: Alignment.bottomCenter,
                        child: PageView.builder(
                          controller: sebhaController,
                          scrollDirection: Axis.horizontal,
                          itemCount: sebhaList.length,
                          onPageChanged: (index) {
                            setState(() {
                              _changeZakr(index);
                            });
                          },
                          itemBuilder: (context, index) => Container(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              sebhaList[index].text,
                              textAlign: TextAlign.center,
                              style: TextStyles.bodyLargeStyle(fontSize: 36),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        counter.toString(),
                        style: TextStyles.bodyLargeStyle(fontSize: 36),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 5),
        ],
      ),
    );
  }

  void _changeZakr(int? index) {
    counter = 0;
    zakrIndex = index ?? (zakrIndex + 1) % sebhaList.length;
  }
}
