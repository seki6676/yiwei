import 'package:flutter/material.dart';
import 'manual_meihua_page.dart';
import 'meihua_result_page.dart';

class MeiHuaOptionPage extends StatelessWidget {
  const MeiHuaOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('梅花易数起卦'),
        backgroundColor: const Color(0xFF8B261D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.white,
              leading: const Icon(Icons.access_time, color: Color(0xFF8B261D)),
              title: const Text('时间起卦'),
              subtitle: const Text('按当前年月日时自动起卦'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeiHuaResultPage(
                      title: '梅花易数 - 时间起卦',
                      querySubject: '测近来运势',
                      benGuaName: '天风姤',
                      huGuaName: '乾为天',
                      bianGuaName: '巽为风',
                      dongYao: 1,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.white,
              leading: const Icon(Icons.touch_app_outlined, color: Color(0xFF8B261D)),
              title: const Text('手动指定画爻起卦'),
              subtitle: const Text('指定初爻至上爻的阴阳，并指定唯一点爻为动爻'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MeiHuaManualPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}