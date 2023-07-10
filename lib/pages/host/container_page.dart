import 'package:flutter/material.dart';
import 'package:shoes_app/widgets/container_tile.dart';

import '../../theme/const.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: bg1Color,
        centerTitle: true,
        title: Text(
          'Container',
          style: primaryTextStyle,
        ),
        elevation: 0,
      );
    }

    Widget emptyContainer() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: bg3Color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/container icon.png',
                width: 74,
              ),
              const SizedBox(
                height: 23,
              ),
              Text(
                'Belum ada Container',
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
            Navigator.pushNamed(context, '/detail-container');
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            children: const [
              ContainerTile(),
              ContainerTile(),
              ContainerTile(),
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
