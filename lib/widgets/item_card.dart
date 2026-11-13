import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(14),
      elevation: 3.0,
      shadowColor: item.color.withValues(alpha: 0.35),
      clipBehavior: Clip.antiAlias,
      child: InkWell (onTap: () {
        ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(item.icon, color: Colors.white, size: 20.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    "Kamu telah menekan tombol ${item.name}!",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            backgroundColor: item.color,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape:BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: Colors.white,
                size: 26.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              item.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.5,
              ),
            ),
            if (item.subtitle.isNotEmpty) ...[
              const SizedBox(height: 2.0),
              Text(
                item.subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 10.5,
                ),
              ),
            ],
          ],
        ),
        ),
      ),
    );
  }
}