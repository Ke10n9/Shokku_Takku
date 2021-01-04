# ダテさん -献立記録サービス-

## 概要

「ダテさん」は、日々の献立管理ができる「献立記録サービス」です。

このアプリは、

1. 自分の献立の登録

によって献立を記録できるだけでなく、

2. 他人の献立
3. 自分の「ご無沙汰献立」（最近食べていない献立）

を知ることができ、あなたの献立の管理と選択をサポートします。


## URL

https://datesan.herokuapp.com/

ホーム画面の「テストログイン」からテストユーザーとしてログインし、機能を閲覧することができます。


## 機能一覧

#### 【自分の献立】

* 献立（品目・画像）の登録・編集・削除
* 献立一覧の閲覧
* 品目名での献立の検索
* 「ご無沙汰献立」（最近食べていない献立）の算出

#### 【他ユーザーの献立】

* 全ユーザーの献立一覧の閲覧
* 特定ユーザーの献立一覧の閲覧
* フォローしているユーザー達の献立一覧の閲覧

#### 【ユーザー機能】

* ユーザーの登録・編集・削除
* プロフィール画像登録
* ログイン・ログアウト
* ユーザーの検索
* 他のユーザーのフォロー
* テストユーザーログイン


## このアプリで解決したい課題

毎日の献立を決めることの大変さを軽減したい。

#### 解決する手法

1. 登録された献立をカレンダー形式で表示することで、***献立を可視化***する

2. 「ご無沙汰献立」（最近食べていない献立）を算出することで、***献立の提案***をする

3. 他のユーザーの献立を閲覧できることで、***献立の幅を広げる***ことができる


## 主な利用シーン

* 献立を登録しよう

## 使用技術

#### フロントエンド
* HTML
* CSS
* Javascript
* JQuery
* Bootstrap

#### バックエンド
* Ruby 2.6.5
* Ruby on Rails 6.0.3.4

#### 開発環境
* Git
* Github
* MySQL

#### 本番環境
* Heroku
* Heroku Add-ons
  * ClearDB MySQL
  * Mailgun
* AWS
  * S3（ユーザー・献立画像用ストレージ）

#### テスト
* RSpec　計200以上

#### その他
* 非同期通信（フォローボタン、ユーザー・献立検索、タブ、献立画像のプレビュー、モーダルウインドウ）
* kaminari
  * ページネーション（ユーザー・献立検索結果、みんなの献立一覧）
* simple_calendar（献立カレンダーの日付選択用）
* Action Mailer（アカウント有効化・パスワードリセットのメール送信）
