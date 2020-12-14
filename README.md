# テーブル設計

## users テーブル

| Column   | Type      | Options     |
| -------- | --------- | ----------- |
| nickname | string    | null: false |
| email    | string    | null: false |
| password | string    | null: false |

### Association

- has_one  :profiles
- has_many :items
- has_many :transactions
- has_many :shipping_addresses

## profiles テーブル

| Column          | Type      | Options     |
| --------------- | --------- | ------------------------------ |
| last_name       | string    | null: false                    |
| first_name      | string    | null: false                    |
| last_kana_name  | string    | null: false                    |
| first_kana_name | string    | null: false                    |
| birth_year      | integer   | null: false                    |
| birth_month     | integer   | null: false                    |
| birth_day       | integer   | null: false                    |
| user_id         | reference | null: false, foreign_key: true |


### Association

- belongs_to :users

## items テーブル

| Column              | Type      | Options                        |
| ------------------- | --------- | ------------------------------ |
| name                | string    | null: false                    |
| image               | string    | null: false                    |
| price               | integer   | null: false                    |
| explanation         | text      | null: false                    |
| category            | string    | null: false                    |
| status              | string    | null: false                    |
| delivery_charge     | string    | null: false                    |
| shipment_prefecture | string    | null: false                    |
| shipment_schedule   | string    | null: false                    |
| user_id             | reference | null: false, foreign_key: true |

### Association

- belongs_to :users
- has_one :transactions
- has_one :shipping_adresses

## transactions テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| card_number      | integer    | null: false                    |
| expiration_year  | integer    | null: false                    |
| expiration_month | integer    | null: false                    |
| security_code    | integer    | null: false                    |
| user_id          | reference  | null: false, foreign_key: true |
| item_id          | reference  | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- has_one :shipping_adresses

## shipping_addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | integer    | null: false                    |
| prefecture       | string     | null: false                    |
| city             | string     | null: false                    |
| block            | string     | null: false                    |
| building         | string     |                                |
| telephone_number | integer    | null: false                    |
| user_id          | reference  | null: false, foreign_key: true |
| item_id          | reference  | null: false, foreign_key: true |
| transaction_id   | reference  | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- belongs_to :transactions
