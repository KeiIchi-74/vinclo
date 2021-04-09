# Vicnlo
[vinclo](http://35.72.117.142/)

# 概要
vincloとは

vinclo（ビンクロ)は、「自分の知らない古着屋に出会える」を目的とした、古着屋情報のシェアサービスです。

# vincloの開発環境
# 使用技術
* フレームワーク : Rails 6.0.3.4
* フロント　: HTML、　Sass、　JavaScript(jQuery)
* サーバーサイド言語　: Ruby2.6.6
* データベース　: MySQL
* テストフレームワーク : RSpec
* コードチェック　: RuboCop
* サーバー : puma nginx
* バージョン管理 : GitHub
* 本番環境 : AWS(EC2 /S3)
* ユーザー認証機能　：devise
* 画像投稿　：Active_Storage
* 使用マシン　: Mac Big Sur(11.2.3)

# このアプリケーションを作った背景
大学時代、古着屋巡りが趣味で、自分の知らない古着屋の情報、そして自分だけが知っている古着屋の情報を共有できるサイトがあればいいなと感じていました。vincloは、そんな人が訪れた古着屋のレビュー、そこで購入した服、お店の感想を共有できるシェアサービスです。

# メイン機能
登録したユーザーは、自分が登録したい店舗の情報と、そのお店のレビューを行うことができます。

## 店舗登録機能
[![Image from Gyazo](https://i.gyazo.com/fb7727b2b45622260f63d1502fcc888c.gif)](https://gyazo.com/fb7727b2b45622260f63d1502fcc888c)

## 店舗へのレビュー機能
[![Image from Gyazo](https://i.gyazo.com/01776e1966b67873052317b10e66589b.gif)](https://gyazo.com/01776e1966b67873052317b10e66589b)

## 店舗で購入した衣服の複数画像添付とそのプレビュー機能
[![Image from Gyazo](https://i.gyazo.com/6e93905df6431a05ce8b7c5534dac3c9.gif)](https://gyazo.com/6e93905df6431a05ce8b7c5534dac3c9)

## ER図
[![Image from Gyazo](https://i.gyazo.com/b3a5c56f168b7f3cdc714f3eafda7937.png)](https://gyazo.com/b3a5c56f168b7f3cdc714f3eafda7937)


# サブ機能
* メール送信を用いた、ユーザー情報登録機能
* ゲストログイン機能
* 各都道府県ごとの、店舗一覧機能
* ページネーション機能
* 複数画像登録と、そのプレビュー機能
* 店舗登録の際の、住所自動入力機能
* google map apiを用いた、位置情報検索とその情報登録
* capistranoを用いた自動デプロイ

# このアプリで一番、注力した点
このアプリで、一番ユーザーにしてもらいたいのは、店舗レビューです。その作業が苦にならないような、UIを実現するために、非同期でのレビュー投稿実装を行い。その中でも、画像の複数投稿機能や、情報入力欄を増減できるように工夫したところです。


