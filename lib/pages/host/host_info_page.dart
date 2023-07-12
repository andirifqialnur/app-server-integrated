import 'package:flutter/material.dart';
import 'package:shoes_app/theme/const.dart';

class HostInfoPage extends StatefulWidget {
  const HostInfoPage({super.key});

  static TextEditingController ipAddressController =
      TextEditingController(text: '');
  static TextEditingController usernameController =
      TextEditingController(text: '');
  static TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  State<HostInfoPage> createState() => _HostInfoPageState();
}

class _HostInfoPageState extends State<HostInfoPage> {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: bg1Color,
        centerTitle: true,
        title: Text(
          'Host',
          style: primaryTextStyle,
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: alertColor,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      );
    }

    Widget dataLogin() {
      return Container(
        margin: const EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Login',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              '27 Jun 2023',
              style: secondaryTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'IP Address',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              '127.0.0.1',
              style: secondaryTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Administrator',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'Aran',
              style: secondaryTextStyle,
            ),
          ],
        ),
      );
    }

    Widget buttons() {
      return Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vm');
              },
              style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Text(
                'Virtual Machine',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 40,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/container');
              },
              style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Text(
                'Container',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: bg3Color,
      appBar: header(),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dataLogin(),
            buttons(),
          ],
        ),
      ),
    );
  }
}
