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
- has_many :transactions

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| image               | string     | null: false                    |
| price               | integer    | null: false                    |
| explanation         | text       | null: false                    |
| category            | string     | null: false                    |
| status              | string     | null: false                    |
| delivery_charge     | string     | null: false                    |
| shipment_prefecture | string     | null: false                    |
| shipment_schedule   | string     | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :transaction

## transactions テーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| card_number      | integer     | null: false                    |
| expiration_year  | integer     | null: false                    |
| expiration_month | integer     | null: false                    |
| security_code    | integer     | null: false                    |
| user             | references  | null: false, foreign_key: true |
| item             | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| postal_code      | integer     | null: false                    |
| prefecture       | string      | null: false                    |
| city             | string      | null: false                    |
| block            | string      | null: false                    |
| building         | string      |                                |
| telephone_number | string      | null: false                    |
| transaction      | references  | null: false, foreign_key: true |

### Association

- belongs_to :transaction