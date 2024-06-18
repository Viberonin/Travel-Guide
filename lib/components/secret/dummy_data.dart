import '../../../models/destination_review_model.dart';
import '../../constants/image_strings.dart';

class TDummyData {
  static final List<ProductReviewModel> productReviews = [
    ProductReviewModel(
      id: '01',
      userId: '001',
      userName: 'John Doe',
      rating: 4.5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: TImages.userProfileImage2,
      comment: 'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
      companyComment:
          'Thank you for your kind words, John! We are delighted to hear about your smooth experience with the app. We always strive to offer an intuitive interface for our users. Stay tuned for more updates!',
    ),
    ProductReviewModel(
      id: '02',
      userId: '002',
      userName: 'Sophia Wilson',
      rating: 3.5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: TImages.userProfileImage1,
      comment:
          'I am genuinely impressed with the app design and the variety of products available. The filter and sort features have made shopping so much easier for me!',
      companyComment:
          'Thank you so much, Sophia! We are thrilled to hear you are enjoying the app and finding the features useful. Our goal is to make your shopping experience as efficient and pleasant as possible. Keep exploring, and happy shopping!',
    ),
    ProductReviewModel(
      id: '03',
      userId: '003',
      userName: 'Alex Brown',
      rating: 5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: TImages.userProfileImage3,
      comment: 'The app is pretty fast, and the product recommendations are on point! I would love to see more features in the future.',
      companyComment:
          'Thanks for the feedback, Alex! We are thrilled to hear you enjoyed the speed and recommendations. We are constantly working on introducing new features, so keep an eye out for the next update!',
    ),
  ];
}