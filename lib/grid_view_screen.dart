import 'package:flutter/material.dart';

class GridViewScreen extends StatelessWidget {
  const GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách label
    final items = List.generate(12, (i) => 'Item ${i + 1}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView Gallery'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section 1: GridView.count() ---
            const Text(
              'Fixed Column Grid',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 3,         // 3 cột
              mainAxisSpacing: 8,        // khoảng cách giữa các hàng
              crossAxisSpacing: 8,       // khoảng cách giữa các cột
              childAspectRatio: 1,       // vuông
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final label in items)
                  _GridItem(
                    icon: Icons.image,
                    label: label,
                  ),
              ],
            ),

            const SizedBox(height: 24),

            // --- Section 2: GridView.extent() ---
            const Text(
              'Responsive Grid',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.extent(
              maxCrossAxisExtent: 150,   // mỗi item tối đa 150 px
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final label in items)
                  _GridItem(
                    icon: Icons.photo,
                    label: label,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget 1 item
class _GridItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _GridItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Icon(
                icon,
                size: 40,
                color: Colors.teal.shade800,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}
