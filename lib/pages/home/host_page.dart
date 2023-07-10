import 'package:flutter/material.dart';
import 'package:shoes_app/theme/const.dart';

class HostPage extends StatelessWidget {
  const HostPage({super.key});

  @override
  Widget build(BuildContext context) {
    // CartProvider cartProvider = Provider.of<CartProvider>(context);

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: bg1Color,
        centerTitle: true,
        title: Text(
          'Host',
          style: primaryTextStyle,
        ),
        elevation: 0,
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Host.png',
              width: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Belum ada Host',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Mari masukkkan host yang\ningin di pantau',
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: 154,
              height: 44,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/host-login');
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Login Host',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Widget content() {
    //   return ListView(
    //     padding: const EdgeInsets.symmetric(
    //       horizontal: defaultMargin,
    //     ),
    //     children: cartProvider.carts.map((cart) => CartCard(cart)).toList(),
    //   );
    // }

    // Widget customBottomNav() {
    //   return SizedBox(
    //     height: 180,
    //     child: Column(
    //       children: [
    //         Container(
    //           margin: const EdgeInsets.symmetric(
    //             horizontal: defaultMargin,
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 'Subtotal',
    //                 style: primaryTextStyle,
    //               ),
    //               Text(
    //                 '\$${cartProvider.totalPrice()}',
    //                 style: priceTextStyle.copyWith(
    //                   fontSize: 16,
    //                   fontWeight: semibold,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 30,
    //         ),
    //         const Divider(
    //           thickness: 0.3,
    //           color: subtitleColor,
    //         ),
    //         const SizedBox(
    //           height: 30,
    //         ),
    //         Container(
    //           height: 50,
    //           margin: const EdgeInsets.symmetric(
    //             horizontal: defaultMargin,
    //           ),
    //           child: TextButton(
    //             onPressed: () {
    //               Navigator.pushNamed(context, '/checkout');
    //             },
    //             style: TextButton.styleFrom(
    //                 backgroundColor: primaryColor,
    //                 padding: const EdgeInsets.symmetric(
    //                   horizontal: 20,
    //                 ),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(12),
    //                 )),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   'Continue to Checkout',
    //                   style: primaryTextStyle.copyWith(
    //                     fontSize: 16,
    //                     fontWeight: semibold,
    //                   ),
    //                 ),
    //                 const Icon(
    //                   Icons.arrow_forward,
    //                   color: primaryTextColor,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: bg3Color,
      appBar: header(),
      body: emptyCart(),
    );
  }
}
