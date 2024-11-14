// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// class RatingWidget extends StatelessWidget {
//   final double rating;
//   final double size;
//   final Color activeColor;
//   final Color inactiveColor;
//   const RatingWidget({
//     super.key,
//     required this.rating,
//     this.size = 24,
//     this.activeColor = const Color(0xff508a7b),
//     this.inactiveColor = Colors.grey,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ...List.generate(
//           5,
//           (index) {
//             double remainingRating =
//                 rating - index; //3.5-0=3.5 //3.5-1 = 2.5 //

//             if (remainingRating >= 1) {
//               return Icon(
//                 Icons.star,
//                 color: activeColor,
//                 size: size,
//               );
//             } else if (remainingRating > 0) {
//               return Stack(
//                 children: [
//                   Icon(
//                     Icons.star,
//                     color: inactiveColor,
//                     size: size,
//                   ),
//                   ClipRect(
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       widthFactor: remainingRating,
//                       child: Icon(
//                         Icons.star,
//                         color: activeColor,
//                         size: size,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               return Icon(
//                 Icons.star,
//                 color: inactiveColor,
//                 size: size,
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:mevivu_task2/models/product.dart';
import 'package:mevivu_task2/styles/app_text_style.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool showDetail;
  final bool hideStarWidget;
  final List<Review>? reviews; // Thêm thuộc tính reviews

  const RatingWidget({
    super.key,
    required this.rating,
    this.size = 24,
    this.activeColor = const Color(0xff508a7b),
    this.inactiveColor = Colors.grey,
    this.showDetail = false,
    this.hideStarWidget = false,
    this.reviews,
  });

  // Hàm đếm số lượng rating cho mỗi sao
  Map<int, int> _countRatings() {
    Map<int, int> ratingCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    if (reviews != null) {
      for (var review in reviews!) {
        int rating = review.rating;
        ratingCount[rating] = (ratingCount[rating] ?? 0) + 1;
      }
    }
    return ratingCount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hiển thị rating stars
        if (hideStarWidget == false)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                5,
                (index) {
                  double remainingRating = rating - index;

                  if (remainingRating >= 1) {
                    return Icon(
                      Icons.star,
                      color: activeColor,
                      size: size,
                    );
                  } else if (remainingRating > 0) {
                    return Stack(
                      children: [
                        Icon(
                          Icons.star,
                          color: inactiveColor,
                          size: size,
                        ),
                        ClipRect(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            widthFactor: remainingRating,
                            child: Icon(
                              Icons.star,
                              color: activeColor,
                              size: size,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Icon(
                      Icons.star,
                      color: inactiveColor,
                      size: size,
                    );
                  }
                },
              ),
              SizedBox(width: 8),
            ],
          ),

        // Hiển thị chi tiết rating nếu showDetail = true
        if (showDetail && reviews != null) ...[
          SizedBox(height: 16),
          ...List.generate(5, (index) {
            int starCount = 5 - index;
            int numberOfRatings = _countRatings()[starCount] ?? 0;
            double percentage = reviews!.isEmpty
                ? 0
                : (numberOfRatings / reviews!.length) * 100;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    '$starCount',
                    style: TextStyle(
                      fontSize: size * 0.7,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.star,
                    color: activeColor,
                    size: size * 0.8,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: inactiveColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: percentage / 100,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: activeColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '$numberOfRatings',
                    style: TextStyle(
                      fontSize: size * 0.7,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 8),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${reviews!.length} ratings',
                style: AppTextStyle.description,
              ),
              Spacer(),
              Text(
                'WRITE A REVIEW',
                style: AppTextStyle.description,
              ),
              SizedBox(width: 5),
              Icon(
                Icons.edit,
                color: Colors.grey.shade600,
              ),
              // {
              //   "rating": 2,
              //   "comment": "Very unhappy with my purchase!",
              //   "date": "2024-05-23T08:56:21.618Z",
              //   "reviewerName": "John Doe",
              //   "reviewerEmail": "john.doe@x.dummyjson.com"
              // },
            ],
          ),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: ListView.separated(
              itemCount: reviews!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: Image.asset(
                              'images/beauty.png',
                              height: 25,
                              width: 25,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reviews![index].reviewerName),
                              RatingWidget(
                                rating: reviews![index].rating.toDouble(),
                                size: 16,
                              )
                            ],
                          ),
                          Spacer(),
                          Text(
                            '${reviews![index].date.year}-${reviews![index].date.month}-${reviews![index].date.day}',
                            style: AppTextStyle.description,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        reviews![index].comment,
                        style: AppTextStyle.description,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 15);
              },
            ),
          ),
        ],
      ],
    );
  }
}
