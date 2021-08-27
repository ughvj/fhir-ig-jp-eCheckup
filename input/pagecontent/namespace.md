このページは、令和2年度厚生労働科学特別研究事業「診療情報提供書, 電子処方箋等の電子化医療文書の相互運用性確保のための標準規格の開発研究」において研究班が策定した<a href="https://std.jpfhir.jp/wp-content/uploads/2021/05/eCheckup_betaRel.zip">健康診断結果報告書FHIR®記述仕様書案</a>をもとに引用・再構成して作成しています。  
以下で ***本文書*** は、研究班が策定した<a href="https://std.jpfhir.jp/wp-content/uploads/2021/05/eCheckup_betaRel.zip">健康診断結果報告書FHIR®記述仕様書案</a>を示します。  

### 識別子名前空間一覧

本文書で定義された、識別子の名前空間の一覧を示す。

表27　識別子名前空間一覧

|No|項目|Path|system値（URI）|
|---|---|---|---|
|1|健康診断結果報告書ID|Composition.identifier|http://hl7.jp/fhir/eCheckup/documentIdentifier|
|2|受診者ID|Patient.identifier|urn:oid: 1.2.392.200119.6.102.1[保険医療機関コード(10 桁)]|
|3|保険医療機関ID|Organization.identifier|urn:oid:1.2.392.100495.20.3.61|

