import 'package:flutter/material.dart';

class Riyoukiyaku extends StatefulWidget {
  const Riyoukiyaku({super.key});

  @override
  State<Riyoukiyaku> createState() => _RiyoukiyakuState();
}

class _RiyoukiyakuState extends State<Riyoukiyaku> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  '利用規約',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            )),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                        child: Text(
                      'この利用規約（以下，「本規約」といいます。）は、授業ログ（以下，「本アプリ」といいます。）がこのウェブサイト上で提供するサービス（以下，「本サービス」といいます。）の利用条件を定めるものです。本アプリをご利用の皆さま（以下，「ユーザー」といいます。）には，本規約に従って，本サービスをご利用いただきます。',
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第1条（適用）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''本規約は，ユーザーと本アプリとの間の本サービスの利用に関わる一切の関係に適用されるものとします。
本アプリは本サービスに関し，本規約のほか，ご利用にあたってのルール等，各種の定め
（以下，「個別規定」といいます。）をすることがあります。
これら個別規定はその名称のいかんに関わらず，本規約の一部を構成するものとします。
本規約の規定が前条の個別規定の規定と矛盾する場合には，個別規定において特段の定めなき限り，
個別規定の規定が優先されるものとします。''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第2条（利用料金および支払方法）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        '本サービスは無料で利用できるため本社からユーザーに料金を請求することは一切ありません。',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第3条（禁止事項）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''ユーザーは，本サービスの利用にあたり，以下の行為をしてはなりません。
・法令または公序良俗に違反する行為 ・犯罪行為に関連する行為
・本アプリ，本サービスの他のユーザー，または第三者のサーバーまたはネットワークの機能を破壊したり，妨害したりする行為
・本アプリのサービスの運営を妨害するおそれのある行為
・他のユーザーに関する個人情報等を収集または蓄積する行為
・不正アクセスをし，またはこれを試みる行為
・他のユーザーに成りすます行為
・本アプリのサービスに関連して，反社会的勢力に対して直接または間接に利益を供与する行為
・本アプリ，本サービスの他のユーザーまたは第三者の知的財産権，肖像権，プライバシー，名誉その他の権利または利益を侵害する行為
・以下の表現を含み，または含むと本アプリが判断する内容を本サービス上に投稿し，または送信する行為
・過度に暴力的な表現 ・露骨な性的表現
・人種，国籍，信条，性別，社会的身分，門地等による差別につながる表現
・自殺，自傷行為，薬物乱用を誘引または助長する表現
・その他反社会的な内容を含み他人に不快感を与える表現
・以下を目的とし，または目的とすると本アプリが判断する行為
・営業，宣伝，広告，勧誘，その他営利を目的とする行為（本アプリの認めたものを除きます。）
・性行為やわいせつな行為を目的とする行為
・面識のない異性との出会いや交際を目的とする行為
・他のユーザーに対する嫌がらせや誹謗中傷を目的とする行為
・本アプリ，本サービスの他のユーザー，または第三者に不利益，損害または不快感を与えることを目的とする行為
・その他本サービスが予定している利用目的と異なる目的で本サービスを利用する行為
・宗教活動または宗教団体への勧誘行為
・その他，本アプリが不適切と判断する行為''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第4条（本サービスの提供の停止等）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''本アプリは，以下のいずれかの事由があると判断した場合，ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。
本サービスにかかるコンピュータシステムの保守点検または更新を行う場合
地震，落雷，火災，停電または天災などの不可抗力により，本サービスの提供が困難となった場合
コンピュータまたは通信回線等が事故により停止した場合
その他，本アプリが本サービスの提供が困難と判断した場合
本アプリは，本サービスの提供の停止または中断により，ユーザーまたは第三者が被ったいかなる不利益または損害についても，一切の責任を負わないものとします。''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第5条（著作権）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''ユーザーは，自ら著作権等の必要な知的財産権を有するか，または必要な権利者の許諾を得た文章，画像や映像等の情報に関してのみ，本サービスを利用し，投稿ないしアップロードすることができるものとします。
ユーザーが本サービスを利用して投稿ないしアップロードした文章，画像，映像等の著作権については，当該ユーザーその他既存の権利者に留保されるものとします。ただし，本アプリは，本サービスを利用して投稿ないしアップロードされた文章，画像，映像等について，本サービスの改良，品質の向上，または不備の是正等ならびに本サービスの周知宣伝等に必要な範囲で利用できるものとし，ユーザーは，この利用に関して，著作者人格権を行使しないものとします。
前項本文の定めるものを除き，本サービスおよび本サービスに関連する一切の情報についての著作権およびその他の知的財産権はすべて本アプリまたは本アプリにその利用を許諾した権利者に帰属し，ユーザーは無断で複製，譲渡，貸与，翻訳，改変，転載，公衆送信（送信可能化を含みます。），伝送，配布，出版，営業使用等をしてはならないものとします。
''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第6条（利用制限および登録抹消）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''本アプリは，ユーザーが以下のいずれかに該当する場合には，事前の通知なく，投稿データを削除し，ユーザーに対して本サービスの全部もしくは一部の利用を制限しまたはユーザーとしての登録を抹消することができるものとします。
本規約のいずれかの条項に違反した場合
登録事項に虚偽の事実があることが判明した場合
本アプリからの連絡に対し，一定期間返答がない場合
本サービスについて，最終の利用から一定期間利用がない場合
その他，本アプリが本サービスの利用を適当でないと判断した場合
前項各号のいずれかに該当した場合，ユーザーは，当然に本アプリに対する一切の債務について期限の利益を失い，その時点において負担する一切の債務を直ちに一括して弁済しなければなりません。
本アプリは，本条に基づき本アプリが行った行為によりユーザーに生じた損害について，一切の責任を負いません。
''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第7条（保証の否認および免責事項）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: [
                        const Text(
                          '''本アプリは，本サービスに事実上または法律上の瑕疵（安全性，信頼性，正確性，完全性，有効性，特定の目的への適合性，セキュリティなどに関する欠陥，エラーやバグ，権利侵害などを含みます。）がないことを明示的にも黙示的にも保証しておりません。
本アプリは，本サービスに起因してユーザーに生じたあらゆる損害について一切の責任を負いません。ただし，本サービスに関する本アプリとユーザーとの間の契約（本規約を含みます。）が消費者契約法に定める消費者契約となる場合，この免責規定は適用されません。
前項ただし書に定める場合であっても，本アプリは，本アプリの過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害のうち特別な事情から生じた損害（本アプリまたはユーザーが損害発生につき予見し，または予見し得た場合を含みます。）について一切の責任を負いません。また，本アプリの過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害の賠償は，ユーザーから当該損害が発生した月に受領した利用料の額を上限とします。
本アプリは，本サービスに関して，ユーザーと他のユーザーまたは第三者との間において生じた取引，連絡または紛争等について一切責任を負いません。
''',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Flexible(
                              child: Text(
                                '第8条（サービス内容の変更等）',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Column(
                          children: const [
                            Text(
                              '''本アプリは，ユーザーに通知することなく，本サービスの内容を変更しまたは本サービスの提供を中止することができるものとし，これによってユーザーに生じた損害について一切の責任を負いません。''',
                            ),
                          ],
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第9条（利用規約の変更）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''本アプリは，必要と判断した場合には，ユーザーに通知することなくいつでも本規約を変更することができるものとします。なお，本規約の変更後，本サービスの利用を開始した場合には，当該ユーザーは変更後の規約に同意したものとみなします。''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第10条（個人情報の取扱い）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''本アプリは，本サービスの利用によって取得する個人情報については，本アプリ「プライバシーポリシー」に従い適切に取り扱うものとします。''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第11条（通知または連絡）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''ユーザーと本アプリとの間の通知または連絡は，本アプリの定める方法によって行うものとします。本アプリは,ユーザーから,本アプリが別途定める方式に従った変更届け出がない限り,現在登録されている連絡先が有効なものとみなして当該連絡先へ通知または連絡を行い,これらは,発信時にユーザーへ到達したものとみなします。''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第12条（権利義務の譲渡の禁止）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''ユーザーは，本アプリの書面による事前の承諾なく，利用契約上の地位または本規約に基づく権利もしくは義務を第三者に譲渡し，または担保に供することはできません。''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Flexible(
                          child: Text(
                            '第13条（準拠法・裁判管轄）',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                      children: const [
                        Text(
                          '''本規約の解釈にあたっては，日本法を準拠法とします。
本サービスに関して紛争が生じた場合には，本アプリの本店所在地を管轄する裁判所を専属的合意管轄とします。''',
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 0,
                    ),
                  ],
                ))));
  }
}
