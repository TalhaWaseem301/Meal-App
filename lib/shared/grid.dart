import 'package:flutter/material.dart';

class CuisineGridItem extends StatelessWidget {
  const CuisineGridItem({
    super.key,
    required this.cuisine,
    required this.onTap,
  });

  final String cuisine;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[cuisine.hashCode % Colors.primaries.length];

    return InkWell(
      onTap: onTap,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.55),
              color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            cuisine,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
