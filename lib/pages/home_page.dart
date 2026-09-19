import 'package:flutter/material.dart';
import 'liuyao_option_page.dart';
import 'meihua_option_page.dart';
import 'history_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('易卦排盘', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF8B261D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildMenuCard(
              context,
              title: '六爻排盘',
              subtitle: '周易纳甲装卦，支持铜钱摇卦与手动指定',
              icon: Icons.monetization_on_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LiuYaoOptionPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: '梅花易数',
              subtitle: '按时间、数字或手动指定卦象排盘',
              icon: Icons.auto_awesome,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MeiHuaOptionPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: '排盘历史',
              subtitle: '查看以往保存的六爻与梅花卦象记录',
              icon: Icons.history,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFF8B261D).withOpacity(0.1),
                child: Icon(icon, color: const Color(0xFF8B261D), size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}