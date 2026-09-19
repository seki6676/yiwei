import 'package:flutter/material.dart';
import 'liuyao_result_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('历史记录'),
        backgroundColor: const Color(0xFF8B261D),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text('乾为天 变 泽天夬 (${index == 0 ? "六爻" : "梅花"})'),
              subtitle: const Text('2026-09-19 12:30 | 占求财'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LiuYaoResultPage(title: '历史排盘记录',
                    querySubject: '测近来财运',
                    benGuaName: '雷天大壮',
                    bianGuaName: '泽天夬',
                    lines: [
                      LiuYaoLineData(positionName: '上爻', isYang: true, liuQin: '父母', ganZhi: '戌土', beast: '玄武', isDongYao: true, bianIsYang: false, bianLiuQin: '妻财', bianGanZhi: '未土'),
                      LiuYaoLineData(positionName: '五爻', isYang: true, liuQin: '兄弟', ganZhi: '申金', beast: '青龙', isShiYao: true, bianIsYang: false, bianLiuQin: '', bianGanZhi: ''),
                      LiuYaoLineData(positionName: '四爻', isYang: true, liuQin: '官鬼', ganZhi: '午火', beast: '朱雀', bianIsYang: true, bianLiuQin: '', bianGanZhi: ''),
                      LiuYaoLineData(positionName: '三爻', isYang: true, liuQin: '兄弟', ganZhi: '辰土', beast: '勾陈', bianIsYang: true, bianLiuQin: '', bianGanZhi: ''),
                      LiuYaoLineData(positionName: '二爻', isYang: true, liuQin: '官鬼', ganZhi: '寅木', beast: '螣蛇', isYingYao: true, bianIsYang: false, bianLiuQin: '', bianGanZhi: ''),
                      LiuYaoLineData(positionName: '初爻', isYang: true, liuQin: '妻财', ganZhi: '子水', beast: '白虎', bianIsYang: true, bianLiuQin: '', bianGanZhi: ''),
                    ], benGuaGong: '',)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}