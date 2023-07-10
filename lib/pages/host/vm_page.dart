import 'package:flutter/material.dart';
import 'package:shoes_app/theme/const.dart';
import 'package:shoes_app/widgets/vm_tile.dart';

class VMPage extends StatelessWidget {
  const VMPage({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: bg1Color,
        centerTitle: true,
        title: Text(
          'Virtual Machine',
          style: primaryTextStyle,
        ),
        elevation: 0,
      );
    }

    Widget emptyVM() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: bg3Color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/vm icon.png',
                width: 74,
              ),
              const SizedBox(
                height: 23,
              ),
              Text(
                'Belum ada Virtual Machine',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Silahkan untuk membuatnya terlebih\ndahulu pada proxmox',
                style: secondaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        color: bg3Color,
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail-vm');
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            children: [
              VMTile(),
              VMTile(),
              VMTile(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
