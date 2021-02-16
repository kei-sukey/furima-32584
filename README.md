# 概要
テックキャンプの最終課題にて作成したアプリケーションです。<br>
## アプリケーション情報
### アプリケーション概要
フリーマーケットのアプリケーションを作成しました。ユーザーを登録すると商品を出品できるようになります。自身が出品した商品は、編集と削除をすることができます。他のユーザーが出品した商品は、クレジットカードを用いて購入することができます。<br>

- 接続先情報<br>
  - https://furima-32584.herokuapp.com/
  - ID/Pass
    - ID: admin
    - Pass: 1357
  - テスト用アカウント等
    - 購入者用
      - メールアドレス: sample@abcde.com
      - パスワード: 123abc
    - 購入用カード情報
      - 番号：4242424242424242
      - 期限：12/25
      - セキュリティコード：123
    - 出品者用
      - メールアドレス名: abcde@sample.com
      - パスワード: abc123

### 開発状況
- 開発環境
  - Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code
- 開発期間と平均作業時間
  - 開発期間：12/15~12/26(11日間)
  - 1日あたりの平均作業時間：8時間
  - 合計：90時間程度
### 動作確認方法
- WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。
  - ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続してください。
- 接続先およびログイン情報については、上記の通りです。
- 同時に複数の方がログインしている場合に、ログインできない可能性があります。
- テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品
- テストアカウントでログイン→トップページから商品選択→カード情報・発送先情報入力→商品購入
- 確認後、ログアウト処理をお願いします。
### 追加実装
テックキャンプで定められた要件以外に、以下の点についてアプリケーションの改善を行いました。<br>

#### アプリケーションの課題と解決策
今回、Herokuの提供するサーバーを利用してアプリケーションをデプロイしていますが、Heroku上では投稿された画像ファイルは、アプリがデプロイされるか、もしくはアプリが再起動（24時間に1回自動で行われる）される度に消えてしまいます。その為、投稿された画像の長期保存の為に、外部のデータ保管サービスの利用が必要でした。<br>
#### 実装内容
Amazon Web Services(AWS)が提供しているSimple Storage Service(S3)を導入し、投稿された画像の長期保存を実現致しました。<br>
<br>

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_kana_name     | string | null: false               |
| first_kana_name    | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| price               | integer    | null: false                    |
| explanation         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| delivery_charge_id  | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| shipping_day_id     | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

- belongs_to :category
- belongs_to :condition
- belongs_to :delivery_charge
- belongs_to :prefecture
- belongs_to :shipping_day

## orders テーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| user             | references  | null: false, foreign_key: true |
| item             | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| city             | string     | null: false                    |
| block            | string     | null: false                    |
| building         | string     |                                |
| telephone_number | string     | null: false                    |
| order            | references | null: false, foreign_key: true |

### Association

- belongs_to :order

- belongs_to :prefecture