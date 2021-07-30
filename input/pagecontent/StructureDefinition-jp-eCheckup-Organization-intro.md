提供先は、診療情報提供書規格HL7J-CDA-005の紹介先に準じる。ただし、病院を事業所等必要により読み替える。FHIR では、拡張「informationRecipient」で表現し、提供先となるOrganizationリソースへの参照として記述する。

Organizationリソースは、健診結果報告書のファイルを作成した機関を表すため、健診実施機関として取り扱ってはならない。健診実施機関に関する情報は、健診実施情報に記録する。

本規格で文書管理責任組織は「ファイル作成管理責任機関情報」とする。本記述は、提供側の責任者が、個人提供用健診結果報告書作成時に提供された先での責任者が明確な場合に記述する。