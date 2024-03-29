# Tasty Network 
<img src="https://img.shields.io/badge/-Ruby-CC342D.svg?logo=Ruby" > <img src="https://img.shields.io/badge/-Ruby on Rails-D30001.svg?logo=Ruby on Rails" > <img src="https://img.shields.io/badge/-Heroku-430098.svg?logo=Heroku" > <img src="https://img.shields.io/badge/-PostgreSQL-4169E1.svg?logo=postgreSQL" > <img src="https://img.shields.io/badge/-aws-232F3E.svg?logo=Amazon AWS" > <img src="https://img.shields.io/badge/-Amazon S3-569A31.svg?logo=Amazon S3" >

## 【URL】
https://sleepy-meadow-94987-d8fdb78e861e.herokuapp.com/products

※画面中部のゲストログインボタンから、メールアドレスとパスワードを入力せずにログインできます。

## 【何ができるアプリか】
### 食品開発チームのための情報共有アプリです。
#### ユーザーが商品情報を登録し、チームメイトとシェアすることで商品開発業務を効率化します。

🔍登録された商品情報は商品名や製造メーカー名から検索が可能です。

📊商品詳細画面ではレーダーチャートとスターの数で視覚的に商品評価を確認することができます。

🧺関連商品リンクから楽天市場に移動して商品購入が可能です。

⭐️投稿した商品情報の「★イイね」が増えるとユーザーランクがUPし、価値のある投稿を楽しむことができます。

## 【アプリ作成の背景】
　食品の商品開発において、各メンバーが自身の担当領域を深く理解することは不可欠ですが、それだけではなく市場全体の商品に関する幅広い知識を持つことが、革新的なアイディアやブレイクスルーをもたらす場合があります。そのため、チーム全体で情報を共有し、競合他社の分析や新商品開発に向けたディスカッションを円滑に行うことが、商品開発業務を効率化する手段になると考え、本アプリを開発しました。

## 【インフラ構成図】
![スクリーンショット 2024-03-23 16 16 13](https://github.com/yusukenasu/food_market/assets/124420750/48417e33-2d62-4e55-aa5d-1130dd48e05c)

## 【ER図】
![スクリーンショット 2024-03-23 21 41 35](https://github.com/yusukenasu/food_market/assets/124420750/431bc0e1-c798-4021-9480-4b62a099a4aa)

## 【使用技術】
フロントエンド

・HTML

・CSS

・JavaScript

・JQuery

・Bootstrap

バックエンド

・Ruby 3.2.1

・Rails 7.0.8.1

・PostgreSQL 14.10

・devise 4.9.3

・RSpec 3.13

・Rubocop 1.62.1

インフラ

・Heroku

・AWS Amazon S3

その他

・Git/GitHub
## 【機能一覧】
・ユーザー登録、ログイン機能、ユーザー情報編集機能（devise）

・商品情報の登録、編集機能

・商品検索機能

・イイね機能(Ajax)

・関連商品表示機能(RakutenAPI)

## 【テスト】
・Rspec　モデルスペック、リクエストスペック、システムスペック

・Rubocop

## 【アプリ使用イメージ】
### ・ログイン
画面中央の「新規登録」あるいは「ログイン」から設定したメールアドレスとパスワードを入力してログインします。

※赤枠の「ゲストログイン」からメールアドレス、パスワードの入力不要でログインできます。
<img width="587" alt="スクリーンショット 2024-03-26 1 26 46" src="https://github.com/yusukenasu/food_market/assets/124420750/00835026-f94c-4160-9e0d-43a031123bb8">



### ・商品情報の登録
ログイン完了後、画面中央の「商品情報を登録」から商品登録画面へ遷移します。
<img width="588" alt="スクリーンショット 2024-03-26 1 26 28" src="https://github.com/yusukenasu/food_market/assets/124420750/1486f7ba-9078-41d9-9d12-bacaa911aad3">

商品情報と評価を入力し「登録」を押します。※は必須項目です。
![スクリーンショット 2024-03-26 1 27 57](https://github.com/yusukenasu/food_market/assets/124420750/fa0051b7-f27b-48a4-a339-da6d5b6de926)

### ・商品詳細画面
商品登録が完了すると商品詳細ページへ遷移します。

商品評価をレーダーチャートやスターの数で視覚的に確認することができます。

ページ下部の関連商品リンクから楽天市場へ移動し商品の購入が可能です。
![スクリーンショット 2024-03-26 1 28 31](https://github.com/yusukenasu/food_market/assets/124420750/6d672539-e9ca-48ee-8ea2-213d5b3db01b)

### ・商品検索
トップページ下部またはヘッダーのフォームから商品検索が可能です。

商品名あるいはメーカー名を入力すると登録商品がヒットします。

空白のまま検索すると登録済の全商品を確認することができます。
![スクリーンショット 2024-03-26 1 38 36](https://github.com/yusukenasu/food_market/assets/124420750/ef07603d-ec5c-472e-9726-177fa02fb182)

![スクリーンショット 2024-03-26 1 29 28](https://github.com/yusukenasu/food_market/assets/124420750/c13dfd74-b2f2-4b7f-90b4-69a114865e34)

### ・イイね機能
商品詳細画面からチームメンバーが登録した商品に「イイね」することができます。

価値のある投稿だと感じた場合「イイね」をしましょう。

「イイね」されたユーザーはユーザーランクがUPします。メンバーで楽しく価値のある投稿をしましょう。
![スクリーンショット 2024-03-26 1 29 54](https://github.com/yusukenasu/food_market/assets/124420750/1641fd0e-3345-407c-a9ce-958b2ffc01f9)
