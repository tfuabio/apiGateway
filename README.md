# jerseyApp

## 概要
- Jerseyアプリケーションの実行・開発環境を構築する方法を記載。

## 前提
- 開発PCに以下をインストールしていること。
  - Docker
  - VSCode
- VSCodeに以下の拡張機能をインストールしていること。
  - Remote Development

## 手順（記載中）
1. 本リポジトリをcloneし、VSCodeで開く。
2. コマンドパレット（WindowsではCtrl + P、MacではCommand + Shift + P）を開く。
3. Dockerfile

## 備考
Mavenでのプロジェクト作成時コマンド

```
mvn archetype:generate \
  -DgroupId=com.example \
  -DartifactId=backend-server \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false
```