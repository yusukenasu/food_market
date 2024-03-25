# Tasty Network 
<img src="https://img.shields.io/badge/-Ruby-CC342D.svg?logo=Ruby" > <img src="https://img.shields.io/badge/-Ruby on Rails-D30001.svg?logo=Ruby on Rails" > <img src="https://img.shields.io/badge/-Heroku-430098.svg?logo=Heroku" > <img src="https://img.shields.io/badge/-PostgreSQL-4169E1.svg?logo=postgreSQL" > <img src="https://img.shields.io/badge/-aws-232F3E.svg?logo=Amazon AWS" > <img src="https://img.shields.io/badge/-Amazon S3-569A31.svg?logo=Amazon S3" >

## URL
https://sleepy-meadow-94987-d8fdb78e861e.herokuapp.com/products

画面中部のゲストログインボタンから、メールアドレスとパスワードを入力せずにログインできます。

## 何ができるアプリか
### 食品開発チームのための情報共有アプリです。
#### ユーザーが商品情報を登録し、チームメイトとシェアすることで商品開発業務を効率化します。

🔍登録された商品情報は商品名や製造メーカー名から検索が可能です。

📊商品詳細画面ではレーダーチャートとスターの数で視覚的に商品評価を確認することができます。

🧺関連商品リンクから楽天市場に移動して商品購入が可能です。

⭐️投稿した商品情報の「★イイね」が増えるとユーザーランクがUPし、価値のある投稿を楽しむことができます。

## アプリ作成の背景
　食品の商品開発において、各メンバーが自身の担当領域を深く理解することは不可欠ですが、それだけではなく市場全体の商品に関する幅広い知識を持つことが、革新的なアイディアやブレイクスルーをもたらす場合があります。そのため、チーム全体で情報を共有し、競合他社の分析や新商品開発に向けたディスカッションを円滑に行うことが、商品開発業務を効率化する手段になると考え、本アプリを開発しました。

## インフラ構成図
![スクリーンショット 2024-03-23 16 16 13](https://github.com/yusukenasu/food_market/assets/124420750/48417e33-2d62-4e55-aa5d-1130dd48e05c)

## ER図
![スクリーンショット 2024-03-23 21 41 35](https://github.com/yusukenasu/food_market/assets/124420750/431bc0e1-c798-4021-9480-4b62a099a4aa)

## 機能一覧
・ユーザー登録、ログイン機能(devise)

・商品情報の投稿機能(Rails)

・画像投稿機能(Amazon S3)

・商品検索機能(Rails)

・イイね機能(Ajax)

・関連商品表示機能(RakutenAPI)

## テスト
・Rspec（単体テスト(model)、機能テスト(request)、統合テスト(system)）
・Rubocop（静的コードテスト）

## アプリ使用イメージ
#### ログイン
画面中央の「新規登録」あるいは「ログイン」から設定したメールアドレスとパスワードを入力してログインします。

※赤枠の「ゲストログイン」からメールアドレス、パスワードの入力不要でログインできます。
![スクリーンショット 2024-03-24 23 23 18](https://github.com/yusukenasu/food_market/assets/124420750/aa316efa-363e-4084-843b-1f22be471b2c)

#### 商品情報の登録
ログイン完了後、画面中央の「商品情報を登録」から商品登録画面へ遷移します。

※のついた必須項目を入力し「登録」を押します。
