import 'package:flutter/material.dart';

import '../theme/const.dart';

class ContainerTile extends StatelessWidget {
  const ContainerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 33,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/Logo Shop Picture.png',
                width: 54,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kali Linux',
                      style: primaryTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '9998',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: light,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xff2B2939),
                    )
                  ],
                ),
              ),
              Text(
                'Stopped',
                style: secondaryTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
