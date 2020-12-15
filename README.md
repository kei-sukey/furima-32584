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
| price               | integer    | null: false                    |
| explanation         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| delivery_charge_id  | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| shipping_days_id    | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

- belongs_to :category
- belongs_to :condition
- belongs_to :delivery_charge
- belongs_to :prefecture
- belongs_to :shipping_days

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