# ダテさん -献立記録サービス-

## 概要

「ダテさん」は、日々の献立管理ができる「献立記録サービス」です。

このアプリは、

* 自分の献立の登録

によって献立を記録できるだけでなく、

* 他人の献立
* 自分の「ご無沙汰献立」（最近食べていない献立）

を知ることができ、あなたの献立の管理と選択をサポートします。


## URL

https://www.datesan.xyz/

ホーム画面の「テストログイン」からテストユーザーとしてログインし、機能を閲覧することができます。


## 機能一覧

#### 【自分の献立】

* 献立（品目・画像）の登録・編集・削除
* 「献立カレンダー」（献立一覧）の閲覧
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

#### 毎日の献立を決めることの負担を軽減したい。

「献立を決める」ことは、家事の中でも地味に大変な部類なのではないでしょうか。<br>
食事は毎日摂りますし、家族がいる場合は適当にもなれません。また、共働きの夫婦などは平日にあまり時間が取れないので、休日中に献立を決め、材料の用意まで済ませておく必要があります。<br>
日常の自由な時間を削ってくる「献立を決める」作業ですが、その負担を少しでも減らせるようこのアプリを制作しました。

## 主な画面プレビュー

#### 献立カレンダー
<img width="559" alt="menu_calendar" src="https://user-images.githubusercontent.com/62887267/105683795-62c74a80-5f37-11eb-8852-48c2848c13ad.png">

#### みんなの献立
<img width="558" alt="everyone's_menus" src="https://user-images.githubusercontent.com/62887267/105684540-71fac800-5f38-11eb-8fac-a24b0e355584.png">

#### ご無沙汰献立
<img width="551" alt="recommend_menus" src="https://user-images.githubusercontent.com/62887267/105684705-a7071a80-5f38-11eb-98ea-5e0be291a0ba.png">

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
* AWS（VPC,EC2,RDS,S3,ALB,Route53）
* nginx
* unicorn

#### インフラ構成図
![Datesan](https://user-images.githubusercontent.com/62887267/107597493-221d4000-6c5e-11eb-838b-a6c36ddaf496.png)

#### テスト
* RSpec　計200以上

#### その他
* 非同期通信（フォローボタン、ユーザー・献立検索、タブ、献立画像のプレビュー、モーダルウインドウ）
* ページネーション（ユーザー・献立検索結果、みんなの献立一覧）
* simple_calendar（献立カレンダーの日付選択用）
* Action Mailer（アカウント有効化・パスワードリセットのメール送信）

## 工夫した点
* 「直感的にわかるデザインや操作性」を意識<br>
  インターネット上で不特定多数の人に使ってもらう為には、直感的にすぐ使えることが重要だと考えています。
* インフラにAWSを使用<br>
  開発開始時はherokuを使用していましたが、レスポンスが悪いのが課題でした。
  求人から、AWSが多くの企業で採用されているということがわかった為、レスポンスの改善と転職後のことを意識しAWSを使用しています。
  
## 苦労した点
* ___初回アクセス時にページが表示されるまで２〜３分かかる問題が発生___<br>
  herokuからAWSに移行し、試行錯誤しているときに上記の問題が発生しました。
  * __原因__<br>
  AWSのロードバランサー（ALB）のサブネットの設定に問題がありました。誤ってRDSの為のプライベートサブネットを設定してしまっていました。
  * __解決方法__<br>
  エラーを確認し切り分けをしていきました。具体的には、以下２点により原因を特定し解消することができました。
    * ページの描画自体に時間がかかっているわけではなかった<br>
    →nginxより前の段階での問題だと判断
    * 「ssl_certificate」が定義されていないというような内容のエラーがあった<br>
    →SSL化を解いてhttp接続してみると上記の問題は発生しなかった為、SSL化したときの設定に誤りがあると判断<br><br>
