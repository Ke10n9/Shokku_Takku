# ダテさん -献立記録サービス-

## 概要

「ダテさん」は、日々の献立管理ができる「献立記録サービス」です。

このサービスでは、

* 自分の献立の「記録」
* 他人の献立の「閲覧」
* 最近食べていない献立の表示
 
によって、献立の管理と決定をサポートします。


## URL

https://datesan.herokuapp.com/

ホーム画面の「テストログイン」からテストユーザーとしてログインし、機能を閲覧することができます。

## 機能一覧

#### ユーザー機能

* ユーザーの登録・編集・削除
* プロフィール画像登録
* ログイン・ログアウト
* ユーザーの検索
* 他のユーザーのフォロー
* テストユーザーログイン

#### 献立機能

* 自分の献立（品目・画像）の登録・編集・削除
* 献立カレンダー（自分の献立一覧）の閲覧
* 自分の献立の検索
* 最近食べていない献立の表示
* 全ユーザーの献立一覧の閲覧
* 特定ユーザーの献立一覧の閲覧
* フォローしているユーザー達の献立一覧の閲覧

## 制作背景

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
* AWS
  * S3（ユーザー・献立画像用ストレージ）
* MySQL

#### テスト
* RSpec　計200以上

#### その他
* 非同期通信（フォローボタン、ユーザー・献立検索、タブ、献立画像のプレビュー、モーダルウインドウ）
* kaminari
  * ページネーション（ユーザー・献立検索結果、みんなの献立一覧）
* simple_calendar（献立カレンダーの日付選択用）
