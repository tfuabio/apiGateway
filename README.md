# jerseyApp

## 概要
- Jerseyアプリケーションの実行・開発環境を構築する方法を記載。

## 前提
- 開発PCに以下をインストールしていること。
  - Docker
  - VSCode
- VSCodeに以下の拡張機能をインストールしていること。
  - Remote Development
- Gitの改行コード設定を`input`にしていること。
  ```
  git config --global core.autocrlf input
  ```

  ▼補足
  `input`の場合、チェックアウト時に変換は行わず、コミット時にはCRLFからLFに変換される。


## 手順（記載中）
1. 本リポジトリをcloneし、VSCodeで開く。
2. コマンドパレット（WindowsではCtrl + P、MacではCommand + Shift + P）を開く。
3. 「開発コンテナー:コンテナーで再度開く」（Dev Containers: Reopen in Container）を選択する。
![Image](https://github.com/user-attachments/assets/a24ee3b8-6855-47e4-93a9-dd4663d5f927)
4. 「ワークスペースに構成を追加する」を選択する。
![Image](https://github.com/user-attachments/assets/ad8e261a-d715-4246-bfcc-9d38422a7108)
5. 「'Dockerfile'から」を選択する。
![Image](https://github.com/user-attachments/assets/f75634d0-d36b-445e-8081-6b42091872c9)
6. 何もチェックせずに「OK」をクリックする。
![Image](https://github.com/user-attachments/assets/4871988e-1409-4164-97e3-a6e365c42601)
7. 何もチェックせずに「OK」をクリックする。
![Image](https://github.com/user-attachments/assets/79925cbc-ccb1-4201-90e4-30f9d7e982bd)

## 備考
Mavenでのプロジェクト作成時コマンド

```
mvn archetype:generate \
  -DgroupId=com.example \
  -DartifactId=backend-server \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false
```