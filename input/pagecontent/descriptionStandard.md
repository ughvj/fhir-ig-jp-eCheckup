このページは、令和2年度厚生労働科学特別研究事業「診療情報提供書, 電子処方箋等の電子化医療文書の相互運用性確保のための標準規格の開発研究」において研究班が策定した<a href="https://std.jpfhir.jp/wp-content/uploads/2021/05/eCheckup_betaRel.zip">健康診断結果報告書FHIR®記述仕様書案</a>をもとに引用・再構成して作成しています。  

### 健診結果報告書FHIR記述仕様の全体構成

#### FHIR Documentの構成

FHIR Documentでは、entry要素内に resource要素を繰り返す基本構造をとり、最初のresourceは、Compositionリソースであることとなっている。Compositionリソースは、診療文書のヘッダ情報の位置付けとなり、この文書に含まれるリソース（情報単位）への参照を列挙し、いわば構成リソースの目次のような役割を果たす。

entryの値である各リソースは[アーティファクト](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/artifacts.html#%E3%82%A2%E3%83%BC%E3%83%86%E3%82%A3%E3%83%95%E3%82%A1%E3%82%AF%E3%83%88)で定義する。

#### その他情報
##### 認証者
FHIR規格では認証者（atterster）を記述できるが、本文書では添付書類も含めて全て署名することを推奨しているため、本規格では適用範囲外とする。

### ボディ部定義
個人提供用健診結果報告書に関する諸記述は、記述項目ごとにFHIRドキュメント CompositionリソースのComposition.secition要素に分けて記述する。

#### セクションの概要
ボディ部には、特定健診で定められた結果情報（検査結果および問診結果）、他の制度で定められた健診結果情報、任意に追加された健診項目結果情報あるいは人間ドック結果情報及び添付書類が含まれ、それぞれCompositionリソースのセクションとして表現される。

各セクションは、そのセクションの内容を人が解釈することを目的として構造化テキストとして記述するナラティブ（Composition.section.text）と、セクション内容を機械可読なデータとして記述するエントリ（Composition.section.entry）から構成される。

説明ブロックは、Composition.section要素内のtext要素にXHTMLタグを使って記述されるが、text要素にすべての健診項目の結果を記述するとそれだけでファイルサイズが非常に大きくなること、および必要ならエントリ中のデータからナラティブデータを機械的に生成可能であることの2つの理由により、本規格ではtext要素には限定された少数の項目だけを任意記述するものとし、その他の項目の記述は行わないこととする。

一方、エントリ記述ブロックはComposition.section.entry要素の繰り返しで記述する。section要素は、セクションの種別を示すセクションコードを表すcode要素を、子要素として含まなければならない。各セクションのセクションコードを<[セクション一覧](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem27.html)>に示す。

#### 検査・問診項目記述の為の基本要件

本項では、健診項目、及び、問診項目を記述するための基本要件を規定する。本項で規定された仕様は、健診項目セクションと問診項目セクションの両方に適用される。

##### セクション部仕様

検査や問診結果の情報は、それぞれ一つのセクションで表現され、人が解釈するためのナラティブと各検査項目に対応する機械可読表現である複数のentry要素を含む。セクションコードには前節の表に従い、健診結果セクションの場合には健診データCDAセクションコードのうち「01910」を指定する

以下、健診結果セクションを例に既定する。

健診結果セクションの仕様を表18に示す。その他のセクションの場合は、これに準じセクションコードおよびセクションタイトルを対応する値に変更して使用すること。

##### テキスト部（ナラティブ）仕様

健診結果セクションの内容を人が解釈するための情報を記述する説明ブロックには、ul要素およびli要素を使用して、検査項目とその結果値を表現する。各健診項目に対して、1つのli要素が対応する。li要素のテキスト内容の書式は、

「項目名 検査結果テキスト」（空白は半角スペース）

とし、検査結果テキストは、検査結果セクションパターン①およびパターン②によって、以下の値を指定する（パターンについての説明は、エントリ部仕様を参照のこと）。

*  パターン①「検査結果 表示用単位」（空白は半角スペース）
*  パターン②「検査結果コード表示名」

また未実施の項目の場合、検査結果テキストは「未実施」を設定し、測定不可能の場合は「測定不可能」を設定する。

さらに、測定値が入力許容範囲外（入力最小値以下または入力最大値以上）の場合には、パターン①の表記に加え「H」または「L」を出現させる。基準値に基づく判定結果は記述しない。

テキスト部の記述仕様は、＜[Compositionリソースの記述仕様](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/StructureDefinition-jp-eCheckup-Composition.html)＞に示す。

ファイルサイズをコンパクトにするため、説明ブロックに記述する項目は[説明ブロックの対象健診項目](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem28.html)に掲げた項目だけに限定するものとする。またこれらについても任意である。記述しない場合は、text要素を出現させないこと。

テキスト部のJSONインスタンス例を示す。

```
"text": {
	"status": "generated",
	"div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><ul><li>身長 176.6 cm</li><li>体重 77.5 kg</li><li>BMI 25.5 kg/m2</li><li>腹囲 85 cm</li><li>メタボリックシンドローム判定 予備群該当</li><li>保健指導レベル 積極的支援</li></ul></div>"
}
```

次に、上記テキスト部を含み、３つの健診項目（Observationリソースへの参照）を含む健診結果セクションのインスタンス例を示す。

```
"section": [
	{
		"title": "健診セクション",
		"code": {
			"coding": [
				{
					"system": "urn:oid:1.2.392.200119.6.1002",
					"code": "01910",
					"display": "健診セクション"
				}
			]
		},
		"text": {
			"status": "generated",
			"div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><ul><li>身長 176.6 cm</li><li>体重 77.5 kg</li><li>BMI 25.5 kg/m2</li><li>腹囲 85 cm</li><li>メタボリックシンドローム判定 予備群該当</li><li>保健指導レベル 積極的支援</li></ul></div>"
		},
		"entry": [
			{
				"reference": "urn:uuid:cbe31279-302b-f0c7-813b-d221c9171a08"
			},
			{
				"reference": "urn:uuid:7a0cd11d-6384-4145-1194-7bc82c962328"
			},
			{
				"reference": "urn:uuid:38f45298-ea42-9f15-7fb2-82ed899d3ec7"
			}
		]
	},
},
```

##### エントリ仕様

健診セクションに含まれる項目は、その結果値のとりうる値により、以下の２つのパターンに分類することができる。

*  パターン① 検査結果が定量値で表現される項目
*  パターン② 検査結果がコード値（定性結果、所見解釈コード）で表現される項目

Composition.entry 要素の仕様を、パターン別に示す。

(a) エントリ仕様パターン①の場合

健診結果が単一の物理量（実数値と単位の組）で表現される項目であり、「XML用特定健診項目情報」のXMLデータ型が「PQ」である項目が該当する。FHIRの対応するデータ型は Quantity型である。

このパターンに含まれる検査項目では、各項目で[検査結果項目パターン①②で指定するデータ](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem30.html)に示す(1)から(17)の値を設定する。項目によってそれぞれ設定する値が異なるものや、設定する必要のないものが存在する。それらの仕様を[Observationリソースの記述仕様](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/StructureDefinition-jp-eCheckup-Observation.html)に示す。なお、[検査結果項目パターン①②で指定するデータ](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem30.html)および[Observationリソースの記述仕様](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/StructureDefinition-jp-eCheckup-Observation.html)は、パターン①およびパターン②の両方に使用できるよう記述している。

(b) 一連検査グループの考え方

「一連検査グループ」は「貧血検査の複数項目の検査結果とその検査を実施した理由情報」、あるいは「胸部Ｘ線検査所見とそのフィルム番号」などのように、ある検査結果が、それに付帯する情報（付帯情報）とともに現れる場合に使用される。

一連検査グループとしてグループされない複数の検査結果は、Composition.entry要素の直下に、一連検査グループをくくるためのObservationリソースがひとつだけ出現し、その内部にObservationリソースのhasMember要素で、各検査結果および付帯情報が記述される。

つまり、Composition.entry.resource で表現されるObservationリソースが、グループをくくる単位となり、そのObservationリソースのhasMember要素で参照されるObservationリソースが、各検査項目を記述している。

各 hasMember 同士の関係は、健診結果報告書規格では 包含関係や他の項目への理由関係を行為間関係種別コードで識別できるようにしていたが、本仕様ではすべて hasMember で関連付けることとする。また、健診結果報告書規格では、グループヘッダに相当するObservation.code要素にはコードは指定しなかったが、本仕様では、以下に示すコードを付与する。コード体系を表す system要素には、「http://hl7.fhir.jp/eCheckup/CodeSystem/ObservationGroupCode」を指定する。

<[一連検査グループ仕様](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem29.html)>


パターン①、及び、パターン②のFHIR仕様を＜[Observationリソースの記述仕様](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/StructureDefinition-jp-eCheckup-Observation.html)＞に示す。

健診項目が検体検査項目の場合、検体情報をSpecimenリソースで表現する。検体情報のtype要素には、検査項目コードから材料コードを指定する。Specimenリソースの記述仕様を＜[Specimenリソースの記述仕様](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/StructureDefinition-jp-eCheckup-Specimen.html)＞に示す。

＜[Observationリソース エントリ仕様パターン①－１](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-ObservationSS.html)＞

＜[Observationリソース エントリ仕様パターン①－２](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-Observation2SS.html)＞

(c) 測定値が入力許容範囲外の場合の測定値の記述（特定健診情報の場合）

測定値が項目毎に指定された入力許容範囲外（入力最小値以下または入力最大値以上）の場合、測定値は実測値に加え、「H」（以上）または「L」（以下）を示すコード値も併せて出現させる。具体的にはvalue要素に結果値を表現した上で、interpretation要素に、「HX」（以上）または「LX」（以下）を示すコード値を並記する。Observationリソースでは、value要素は複数記述することはできないため、健診結果報告書規格とは異なる表現方法であることに注意すること。

なお、ここで記載されている入力最大値、入力最小値とは、厚労省標準的な健診・保健指導に関するプログラム（H30年度確定版）別紙7-3に記載されている「入力最大値」「入力最小値」のことである。また、入力許容範囲とは、「入力最小値＜入力許容範囲＜入力最大値」で表される値の範囲のことである。測定値が最大バイト長（＊1）の表現範囲を超えた場合は、表現範囲の最大値を記載する。

＊1）XML用特定健診項目情報（電子的な標準様式の仕様に関する資料 付属資料2）の「文字列換算（全角2バイト、半角1バイト）時の最大バイト長」、「数値型の場合の形式」を参照のこと。「数値型の場合の形式」が、”NNNNN”ならば、”99999”を記載する。

サンプルインスタンスを示す。

＜[Observationリソース エントリ仕様パターン①－３](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-Observation3SS.html)＞

(d) エントリ仕様パターン②の場合

検査結果が定性値もしくは半定量値で表現される項目であり、「XML用特定健診項目情報」のXMLデータ型が「CD」、「CO」、「ST」である項目が該当する。仕様は、[検査結果項目パターン①②で指定するデータ](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem30.html)および、[Observationリソースの記述仕様](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/StructureDefinition-jp-eCheckup-Observation.html)に記載する。

CO型の場合、CodeableConcept型に含まれるCoding型に対して、ordinalValue拡張を使用する必要があることに注意する。

また、所見有無と具体的な所見のように関連する健診項目は、異なるObservationとして表現するのではなく、1つのObservationリソース内に、component要素によって表現することも、健診結果報告書規格とは異なる点に注意する。このような健診項目の表現例を【サンプル②－２】に示す。

さらに、【サンプル②－３】で示す、「医師の診断」と「判断した医師の氏名」について、健診結果報告書規格ではObservation.author要素を使用していたが、本文書では、Observationリソースのperformer要素を使用し、Practitionerリソースで表現された医師への参照として表現する。

＜[Observationリソース エントリ仕様パターン②－１](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-Observation4SS.html)＞

＜[Observationリソース エントリ仕様パターン②－２](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-Observation5SS.html)＞

＜[Observationリソース エントリ仕様パターン②－３](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-Observation6SS.html)＞

(e) 未実施および測定不可項目の表現

(i) 未実施

未実施とは、検査予定であり検査しようとしたが検体を採取できない場合、あるいは検査予定であったが受診者の事情により検査を行うことが適切でないと検査時点で考えられた場合などである。

未実施は、Observation.dataAbsentReason要素に、バリューセットDataAbsentReasonから「not-performed」を指定することで表現し、Observation.status要素には「cancelled」を指定する。このとき、Observationリソースには、status要素、category要素、code要素、及び、dataAbsentReason要素のみを含む。最初から検査する予定がなかった場合には、Observationリソース自体を出力するべきではない。

＜[Observationリソース 検査未実施のサンプル](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-Observation7SS.html)＞

(ii) 測定不能

測定不能とは、健診実施機関としては検体を採取して検査室に検査をさせたが、検体のなんらかの理由（凝固、量が不足、適切な検体補助剤が入れられていないなど）、検査機器のトラブル、検体搬送時の事故等により検査ができなかった場合、あるいは検査装置の測定限界を超えた異常な値を呈したために検査ができなかった場合などが該当する。

測定不能は、Observation.dataAbsentReason要素に、バリューセットDataAbsentReasonから「error」を指定することで表現し、Observation.status要素には「cancelled」を指定する。未実施と同様に測定不能時にも、Observationリソースには、status要素、category要素、code要素、及び、dataAbsentReason要素のみを含む。

基準値や検査手法コードは、通常の項目と同様に指定できるが、結果解釈値は出現しない。基準値や検査手法コードは、任意要素であるから省略してもよい。

以下に測定不可能項目の2つの例を示す。

＜[Observationリソース 測定不能の記述例①](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-Observation8SS.html)＞

＜[Observationリソース 測定不能の記述例②](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Observation-jp-eCheckup-Observation9SS.html)＞

#### 検査・問診項目記述の為の拡張要件

各種制度に基づく健診の記述構造は、本仕様で述べた健診セクションと問診セクションを利用して、対応する報告区分とともに同様の記述仕様で記載する。但し、人間ドック等の結果報告として個人に結果報告を送ることを主とする場合は、Observation.code、およびComposition.section.codeのdisplay要素（表示名）が記述されることが望ましい。

(i) 検査区分ごとに判定を記述したい場合

特に従来から紙で健康診断結果の報告を受ける場合は、GOT等の各検査項目の判定ばかりでなく、肝機能（GOT、GPT、γ-GT、ZTT、ALP・・・・）、腎機能（BUN、CRE・・・）等の様に幾つかの検査をまとめて判定している。これを可能にするために、判定を記述するObservationリソースのhasMemberプロパティで、対象となる検査項目のObservationリソースをグループ化する記述することを可能にする。

検査区分セクション名は関連学会で定めるのが望ましいが、本規格では例として、複数施設の表現を調査し、「4.2.2.5.1 人間ドック」にコード化した。判定結果も各施設で異なっているので、それぞれをコード化して使えるようにした。

(ii) 検査項目ごとにシェーマや画像を直接リンクさせ報告する場合

X線の画像等をまとめて健康診断結果報告書に添付させる場合は添付書類セクションを用いるが、各検査項目にリンクして、特に超音波検査等でシェーマを添付させたい場合がある。この場合は、対象の健診項目を表すObservationリソースのderivedFrom要素で参照されるMediaリソースに、外部添付ファイルと同様にGIF画像、JPEG画像やPNG画像等の形式でデジタル化された画像を添付することができる。

＜[Mediaリソース 記述例](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Media-jp-eCheckup-MediaSS.html)＞

#### 画像等を添付書類セクションを利用して一括提供する場合

健診結果に加えてまとめて画像等の関連書類を提供する場合に、添付書類セクションを用いる。添付書類は、DocumentReferenceリソースのattachment要素に、URI参照で関連付ける。外部文書の参照に際しては、真正性を担保する為にハッシュコードを用いる。

添付書類ごとにDocumentReferenceリソースを繰り返す。

＜[DocumentReferenceリソース 記述例](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/DocumentReference-jp-eCheckup-DocumentReferenceSS.html)＞

添付書類として、検査結果レポートを表現する、DiagnosticReportリソースを直接添付することも可能とする。

＜[DiagnosticReportリソース 記述例](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/DiagnosticReport-jp-eCheckup-DiagnosticReportSS.html)＞

#### 人間ドックおよび労安法等に基づく健康診断結果の記述
人間ドックおよび労働安全衛生法等に基づく健康診断結果を記述する為に、特定健診の健診項目に追加されるコードを定義しその記述方法を規定する。

コード表のOIDは"2.16.840.1.113883.2.2.1.6" をルートとする。

##### 人間ドック

項目コードのOIDは、2.16.840.1.113883.2.2.1.6.5005とし、その値となる結果コード表は2.16.840.1.113883.2.2.1.6.5005.1.*とする。ただし、検査区分別判定コードは以下に従う。

ａ）人間ドック学会・協会けんぽ等の公開された判定基準（指導区分）の記述

<[公開された判定基準](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem31.html)>

この値は、検査区分ごとの判定のみならず、各検査項目ごとの判定にも用いることが出来る。

b) その他の判定区分例

<[その他の判定区分](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem32.html)>

上記に含まれない検査判定コード体系の場合は、「2.16.840.1.113883.2.2.1.6.1205.枝番号.6.5020」を用いて施設ごとに定義しても良い。また、OIDを所有する団体は、その付番規定に沿って定義しても良い。

##### 労働安全衛生法等に基づく健康診断
###### 受診者追加情報
労働安全衛生法健診では、受診者について以下の情報が必要である。

*  雇入年月日
*  勤務先名
*  勤務先所属
*  役職
*  連絡先

受診者の勤務先の情報は、受診者を表すPatientリソースに対してcontact要素で関連するOrganizationリソースで表現する。勤務先を表すOrganizationは、勤務先の所属を表すOrganizationと partOf 要素で関連する。受診者の役職は、PatientリソースとOrganizationリソースの関係性を表す情報であり、Patient.contact要素の拡張として定義する。

＜[Patientリソース 受診者追加情報記述例](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/Patient-jp-eCheckup-Patient2SS.html)＞

###### 雇入時健康診断

項目コードおよび結果コードは、特定健診項目コード表 1.2.392.200119.6.1005に関連する項目が記載されているのでそれを利用すること。但し、現在の特定健診の電子化の仕様ではGOT、GPT、γ-GTの単位は「U/L」で、様式5号では「IU/L」（国際単位）となっいるので、労働安全衛生法に基づく場合は単位を「IU/L」（国際単位）とし、以下のように項目コードは1.2.392.200119.6.1005と同じにして項目コードOIDは2.16.840.1.113883.2.2.1.6.5005を用いる。

<[国際単位の項目コード](https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/jp-eCheckup/CodeSystem-CodeSystem32.html)>

###### 定期健康診断

個人票では、雇入時健康診断と比較して「他の法定特殊健康診断の名称」の欄が付加されている。これも特定健診項目コード表 1.2.392.200119.6.1005に関連する項目が記載されているので、それを利用することができる。
