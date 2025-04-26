# apiGateway

## 1. 概要
このリポジトリはDocker/VSCodeを用いてJersey/GrizzlyによるREST APIサーバーを構築することを想定している。
ここでは開発環境構築や開発中の動作確認方法について記載する。

▼補足
REST APIとは・・
- 簡単に言うと、Webアプリケーション同士が、REST（Representational State Transfer）というHTTPを使った共通のルールに基づいて、データをやり取りするためのインターフェース（API）
- RESTの原則に基づいて設計されたWebサービスを「RESTful Webサービス」という

Jerseyとは・・
- RESTful Webサービスを構築するためのJavaのフレームワーク
- JAX-RS (Java API for RESTful Web Services) のリファレンス実装であり、REST APIを簡単に構築する機能を提供
- 主に以下のような機能が提供できる
  - HTTPリクエスト/レスポンスの処理
  - JSONやXMLなどのデータフォーマットのシリアライズ/デシリアライズ
  - エラーハンドリングやフィルタリングのサポート

Grizzlyとは・・
- 軽量で高性能なHTTPサーバーを提供するJavaのライブラリ
- 非同期I/Oをサポートしており、スケーラブルなサーバーを構築するのに適している
- Grizzlyは単体でHTTPサーバーとして動作するが、Jerseyと組み合わせることでREST APIサーバーとして利用されることが多い

## 2. 開発環境構築方法

### 2.1. 前提
- 開発PCに以下をインストールしていること。
  - Docker
  - VSCode
- VSCodeに以下の拡張機能をインストールしていること。
  - Dev Container
- GitHubからクローンできること。
- Gitの改行コード設定を`input`にしていること。
  ```
  git config --global core.autocrlf input
  ```

  ▼補足
  `input`の場合、チェックアウト時に変換は行わず、コミット時にはCRLFからLFに変換される。

### 2.2. 手順
1. このリポジトリを任意の場所にクローンし、VSCodeで開く。
  ```
  $ git clone git@github.com:tfuabio/apiGateway.git
  $ code -r apiGateway
  ```
2. VSCodeのウィンドウ左下の「><」ボタンをクリックする。
3. 「コンテナーで再度開く」を選択する。
  ▼補足
  上記を行うと、Dockerfileとdevcontainer.jsonに基づいてコンテナのビルドが開始される。
  ビルドが完了すると自動的にコンテナ環境でVSCodeが開く。
4. 後述のGit設定を行う。

### 2.3. 開発環境（コンテナ）の閉じ方
1. 「><」ボタンをクリックする。
2. 「フォルダーをローカルで再度開く」を選択する。

### 2.4. Git設定
1. コンテナ内で新規キーペアを生成する。 
  下記を実行して、Enterを3回くらい叩けばOK
  ```
  $ ssh-keygen -t ed25519
  ```
2. 生成された公開鍵を開いてコピーする。
  ```
  $ code ~/.ssh/id_ed25519.pub
  ```
3. GitHub設定の「SSH and GPG keys」を開き、コピーしておいた公開鍵を追加する。

## 3. 開発中の動作確認
以下、記載のコマンドはコンテナを開いた上で、VSCodeのターミナル（`Ctrl＋J`）から実行すること。
- コンパイル
  ```
  mvn compile
  ```
- 実行（サーバー起動）
  ```
  mvn exec:java
  ```

  ▼補足
  コンパイルと実行を一緒に行うこともできる。
  ```
  mvn compile exec:java
  ```
  実行すると以下のルートエンドポイントが有効になる。
  http://localhost:8080/

  `Ctrl+C`でサーバー停止できる。
- `curl`コマンドでのAPIレスポンス確認
  サンプルAPI
  ```
  curl -i http://localhost:8080/sample
  ```

  下記レスポンスが返れば正常に動作しているはず。
  ```
  HTTP/1.1 200 OK
  Content-Type: text/plain
  Content-Length: 34

  Hello, this is a sample resource!
  ```

  ▼補足
  src/main/java/com/example/resources配下のリソースクラスを読み込む。
  上記サンプルAPIは`SampleResource`クラスに`getSampleMessage()`として実装されている。

- ユニットテスト（UT）の実行
  ```
  mvn test
  ```

  ▼補足
  `src/test/java/com/example`配下のテストクラスに実装されたテストケース(`@Test`がついたメソッド)が一括で実行される。

- ビルド方法
  ```
  $ mvn clean package
  ```
  上記を実行すると、targetディレクトリ配下にビルド成果物としてjarファイルが生成される。

- jarの実行方法
  ```
  $ java -jar target/apiGateway-1.0-SNAPSHOT.jar
  ```

## 4. デプロイ向けメモ（記載中

### 4.1. デプロイ用コンテナイメージのビルド
Dockerfile.prodを使用して「api-gateway-image」イメージ（デプロイ対象想定）をビルドできる。
```
docker build -f Dockerfile.prod -t api-gateway-image .
```

### 4.2. 各種動作チェックコマンド
- コンテナ作成
  「api-gateway-image」イメージを下に「api-gateway-container」を作成
  ```
  docker create -p 8080:8080 --name api-gateway-container api-gateway-image
  ```

- コンテナ起動
  ```
  docker start api-gateway-container
  ```

  ▼補足
  コンテナ起動中にAPIを叩けばレスポンスが返ってくるはず
  ```
  $ curl -i http://localhost:8080/sample
  HTTP/1.1 200 OK
  Content-Type: text/plain
  Content-Length: 34

  Hello, this is a sample resource!
  ```

- コンテナ停止
  ```
  docker stop api-gateway-container
  ```

- コンテナ削除
  ```
  docker rm api-gateway-container
  ```

- 起動中のコンテナを確認
  ```
  docker ps
  ```

- コンテナのシェルに入る
  ```
  docker exec -it api-gateway-container /bin/bash
  ```

- コンテナのシェルから抜ける
  ```
  exit
  ```

## 備考
- Mavenでのプロジェクト作成時コマンド
  ```
  mvn archetype:generate \
    -DgroupId=com.example \
    -DartifactId=backend-server \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false
  ```

## TODO
- サーバーのログをファイル出力させる
- docker-compose.ymlでコンテナビルドできるようにする
