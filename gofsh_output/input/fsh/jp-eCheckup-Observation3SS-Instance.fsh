Instance: jp-eCheckup-Observation3SS
InstanceOf: Observation
Title: "Observationリソース　エントリ仕様パターン①－３"
Description: """検査結果セクションパターン①－３のObservationリソースのサンプルインスタンス。
測定値が入力最大値を超えた例。
• 検査項目：中性脂肪 項目コード＝"3F015000002327101"、測定値
=2000mg/dL
• 基準値＝下限50、上限150
• 測定方法＝可視吸光光度法（酵素比色法・グリセロール消去）検査法コード 3F01510000
• 結果解釈コード＝"HX""""
Usage: #example
* meta.versionId = "5"
* meta.lastUpdated = "2021-06-24T04:46:20.729+00:00"
* meta.source = "#aziWt9udSaIuyiZ1"
* status = #final
* category = $observation-category#laboratory
* code = $JLAC10#3F015000002327101 "中性脂肪"
* subject = Reference(jp-eCheckup-PatientSS)
* interpretation = $v3-ObservationInterpretation#HX
* method = urn:oid:1.2.392.200119.6.1007#3F01510000 "可視吸光光度法（酵素比色法・グリセロール消去）"
* specimen = Reference(jp-eCheckup-SpecimenSS)
* referenceRange.low = 50 'mg/dL' "mg/dl"
* referenceRange.high = 150 'mg/dL' "mg/dl"