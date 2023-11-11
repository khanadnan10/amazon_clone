
import 'package:amazon_clone/feature/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              onTap: () {},
              text: 'Your Orders',
            ),
            AccountButton(
              onTap: () {},
              text: 'Turn Seller',
            ),
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        Row(
          children: [
            AccountButton(
              onTap: () {},
              text: 'Log out',
            ),
            AccountButton(
              onTap: () {},
              text: 'Your Wishlist',
            ),
          ],
        ),
      ],
    );
  }
}