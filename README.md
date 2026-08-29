# チームスキル・コックピット

チームごとのスキル構成、育成機会、属人化リスクを可視化する Rails アプリケーションです。チームやスキルカテゴリによる絞り込み、スキル名による検索ができます。

## 技術スタック

- Ruby 3.3.11
- Ruby on Rails 8.1
- SQLite 3
- Hotwire（Turbo / Stimulus）
- Tailwind CSS

JavaScript は Importmap、Tailwind CSS は Ruby gem 経由で利用するため、通常の開発では Node.js や Yarn は不要です。

## 必要な環境

- Git
- Ruby 3.3.11（`.ruby-version` を参照）
- Bundler 4.0.16（`Gemfile.lock` を参照）
- SQLite 3

Ruby のバージョン管理には mise、rbenv、asdf などを利用できます。Bundler が未インストールの場合は次のコマンドで追加してください。

```bash
gem install bundler -v 4.0.16
```

## セットアップ

リポジトリを取得して、プロジェクトディレクトリへ移動します。

```bash
git clone https://github.com/itogakuto/hotwire.git
cd hotwire
```

依存 gem のインストールとデータベースの準備を行います。

```bash
bin/setup --skip-server
```

`bin/setup` は `bundle install`、`db:prepare`、古いログ・一時ファイルの削除をまとめて実行します。画面確認用のサンプルデータを確実に投入する場合は、続けて次を実行してください。seed は再実行しても同じデータが重複しないように作られています。

```bash
bin/rails db:seed
```

## 起動方法

Rails サーバーと Tailwind CSS の監視プロセスを起動します。

```bash
bin/dev
```

ブラウザで [http://localhost:3000](http://localhost:3000) を開いてください。終了するにはターミナルで `Ctrl+C` を押します。

別のポートを使用する場合は、次のように指定できます。

```bash
PORT=3001 bin/dev
```

なお、初回セットアップ後にそのままサーバーを起動したい場合は、`--skip-server` を付けずに `bin/setup` を実行できます。

## データベース操作

開発環境では `storage/development.sqlite3`、テスト環境では `storage/test.sqlite3` を使用します。これらのファイルは Git の管理対象外です。

```bash
# 未適用のマイグレーションを実行
bin/rails db:migrate

# サンプルデータを投入・更新
bin/rails db:seed

# データベースを作り直して seed を再投入
bin/rails db:reset
```

`db:reset` は既存の開発データを削除するため、必要なデータがないことを確認してから実行してください。同じ処理は `bin/setup --reset --skip-server` でも行えます。

## テストとコード品質チェック

```bash
# テスト
bin/rails test

# Ruby のコードスタイル
bin/rubocop

# セキュリティチェック
bin/brakeman
bin/bundler-audit

# セットアップ、静的解析、セキュリティチェック、テストを一括実行
bin/ci
```

## よく使うコマンド

```bash
# Rails コンソール
bin/rails console

# ルーティング一覧
bin/rails routes

# Tailwind CSS を含むアセットをビルド
bin/rails assets:precompile
```

## 主な画面

- `/`：チームスキル・コックピット
- `/cockpit`：コックピット画面（`/` と同じ内容）
