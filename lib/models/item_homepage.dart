import 'package:flutter/material.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final String subtitle;

  const ItemHomepage(
    this.name,
    this.icon,
    this.color, {
      this.subtitle = '',
    });
}