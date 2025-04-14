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


## 環境構築手順（記載中）
1. 本リポジトリを任意の場所でcloneし、VSCodeで開く。
```
$ git clone git@github.com:tfuabio/apiGateway.git
$ code apiGateway
```
2. VSCodeのコマンドパレット（WindowsではCtrl + Shift + P、MacではCommand + Shift + P）を開く。
3. `reopen container`と検索し、「開発コンテナー:コンテナーで再度開く」（Dev Containers: Reopen in Container）を選択する。
![Image](https://github.com/user-attachments/assets/a24ee3b8-6855-47e4-93a9-dd4663d5f927)
4. 「ワークスペースに構成を追加する」を選択する。
![Image](https://github.com/user-attachments/assets/ad8e261a-d715-4246-bfcc-9d38422a7108)
5. 「'Dockerfile'から」を選択する。
![Image](https://github.com/user-attachments/assets/f75634d0-d36b-445e-8081-6b42091872c9)
6. 何もチェックせずに「OK」をクリックする。
![Image](https://github.com/user-attachments/assets/4871988e-1409-4164-97e3-a6e365c42601)
7. 何もチェックせずに「OK」をクリックする。
![Image](https://github.com/user-attachments/assets/79925cbc-ccb1-4201-90e4-30f9d7e982bd)

▼補足
コンテナのビルドが開始され、自動的にコンテナでVSCodeが再度開く。
Ctrl/Command + Jでターミナルを開き、
```
$ cat /etc/os-release
```
を実行して以下のように表示されればOK。
```
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```

▼コンテナの閉じ方と次回からの開き方
（記載中）

### Git設定
1. コンテナ内で新規キーペアを生成する。
```
$ ssh-keygen -t ed25519
```

2. 生成された公開鍵を開いてコピーする。
```
$ code ~/.ssh/id_ed25519.pub
```

3. GitHubのSettings＞SSH and GPG keysを開き、コピーしておいた公開鍵を追加する。

## 実行（サーバー起動）方法
```
$ mvn exec:java
```
上記コマンドでサーバーが起動する。
http://localhost:8080/

補足：
サーバー起動時にsrc/main/java/com/example/resources配下のリソースクラスを読み込んでいる。SampleResourceクラスのgetSampleMessage()の場合、以下コマンドでリクエストすることができる。
```
$ curl -i http://localhost:8080/sample
```

## テストケースの一括実行
```
$ mvn test
```

特定のテストクラスを実行
```
$ mvn test -Dtest=SampleResourceTest
```

## ビルド方法
```
$ mvn clean package
```
ビルドを行うとtargetディレクトリにjarファイルが生成される。

## ビルド成果物の実行方法
```
$ java -jar target/apiGateway-1.0-SNAPSHOT.jar
```

## 備考
Mavenでのプロジェクト作成時コマンド

```
mvn archetype:generate \
  -DgroupId=com.example \
  -DartifactId=backend-server \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false
```