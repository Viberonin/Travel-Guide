import '../../models/destination_model.dart';
import 'package:flutter/material.dart';

import '../../controllers/destination/destination_controller.dart';
import '../../constants/enums.dart';
import '../../constants/sizes.dart';
import 'texts/destination_price_text.dart';

class PricingWidget extends StatelessWidget {
  const PricingWidget({super.key, required this.destination});

  final DestinationModel destination;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Actual Price if sale price not null
          if (destination.destinationType == DestinationType.single.toString() && destination.salePrice > 0)
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Text(
                destination.price.toString(),
                style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
              ),
            ),

          /// Price, Show sale price as main price if sale exist.
          Padding(
            padding: const EdgeInsets.only(left: TSizes.sm),
            child: TProductPriceText(price: DestinationController.instance.getDestinationPrice(destination)),
          ),
        ],
      ),
    );
  }
}
