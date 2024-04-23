import 'package:appointment_management/src/views/auth/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';

class CompletedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              child: Image.asset('assets/images/men.png'),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(
                                backgroundColor: AppColors.buttonColor,
                                radius: 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textWidget2(
                                      text: 'Feb',
                                      fSize: 7,
                                      color: Colors.white,
                                      fWeight: FontWeight.w800,
                                    ),
                                    textWidget2(
                                      text: '24',
                                      fSize: 7,
                                      fWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                              text: 'Ameen',
                              fSize: 15,
                              fWeight: FontWeight.w800,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            textWidget(
                              text: 'Consultant:',
                              fSize: 8,
                              fWeight: FontWeight.w600,
                            ),
                            textWidget(
                              text: 'Dr.Michael Pole',
                              fSize: 10,
                              fWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {},
                            child: textWidget(
                              text: "Reschedule",
                              fSize: 10,
                              fWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        textWidget(
                          text: 'Cancel',
                          fSize: 10.0,
                          fWeight: FontWeight.w800,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.buttonColor,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          textWidget(
                              text: "3:00 PM ",
                              fSize: 8.0,
                              fWeight: FontWeight.w800,
                              color: AppColors.buttonColor)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
