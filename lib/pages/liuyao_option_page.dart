import 'package:flutter/material.dart';
import 'manual_liuyao_page.dart';
import 'liuyao_result_page.dart';

class LiuYaoOptionPage extends StatelessWidget {
  const LiuYaoOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('六爻起卦'),
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
              leading: const Icon(Icons.vibration, color: Color(0xFF8B261D)),
              title: const Text('铜钱摇卦（模拟掷币）'),
              subtitle: const Text('通过摇晃手机或点击摇出六爻'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LiuYaoResultPage(title: '六爻排盘 - 摇卦',
                    querySubject: '求财测运',
                    benGuaName: '雷天大壮',
                    benGuaGong: '坤宫',
                    bianGuaName: '泽天夬',
                    lines: [
                      LiuYaoLineData(positionName: '上爻', isYang: true, liuQin: '父母', ganZhi: '戌土', beast: '玄武', isDongYao: true, bianIsYang: false, bianLiuQin: '妻财', bianGanZhi: '未土'),
                      LiuYaoLineData(positionName: '五爻', isYang: true, liuQin: '兄弟', ganZhi: '申金', beast: '青龙', isShiYao: true, bianIsYang: true, bianLiuQin: '', bianGanZhi: ''),
                      LiuYaoLineData(positionName: '四爻', isYang: true, liuQin: '官鬼', ganZhi: '午火', beast: '朱雀', bianIsYang: true, bianLiuQin: '', bianGanZhi: ''),
                      LiuYaoLineData(positionName: '三爻', isYang: true, liuQin: '兄弟', ganZhi: '辰土', beast: '勾陈', bianIsYang: true, bianLiuQin: '', bianGanZhi: ''),
                      LiuYaoLineData(positionName: '二爻', isYang: true, liuQin: '官鬼', ganZhi: '寅木', beast: '螣蛇', isYingYao: false, bianIsYang: false, bianLiuQin: '', bianGanZhi: ''),
                      LiuYaoLineData(positionName: '初爻', isYang: true, liuQin: '妻财', ganZhi: '子水', beast: '白虎', bianIsYang: true, bianLiuQin: '', bianGanZhi: ''),
                    ],)),
                );
              },
            ),
            const SizedBox(height: 12),
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.white,
              leading: const Icon(Icons.edit_note, color: Color(0xFF8B261D)),
              title: const Text('手动指定六爻'),
              subtitle: const Text('直接指定初爻至上爻的阴阳动静'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManualLiuYaoPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}