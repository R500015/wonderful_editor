# README

## タイトル
### Wonderful Editor
『Qiita風記事作成アプリ』
<img width="1638" alt="スクリーンショット 2022-04-20 15 52 11" src="https://user-images.githubusercontent.com/91635588/164216123-d43b26c9-6493-48ac-8f48-c6f19c4dc8af.png">


## 概要
記事を記録、共有するためのアプリ

## URL・テストアカウント
- ポートフォリオURL　: https://wonderful-editor-master.herokuapp.com/
- アカウント : gest
- email : gest@example.com
password : gest1234

## 制作意図
**「実務を見据えたスキルを学習」**を意識して制作しました。
 転職前に、**「試行錯誤する力」「わからないことを調べる力」「適切な質問ができる力」**という自走力を磨くために注力してきました。
 具体的には「学習段階では知らない概念や言葉が含まれているような指示をもとに、アプリを作る経験」がそれにあたります。
 基礎的な学習に取り組む中、実務で壁にぶつかった際にどうやって問題解決できるか、このポートフォリオ作成を通してその練習をしました。
 なので、このポートフォリオは私が実際に作って世に出したいというようなアプリではありません。
 そう言ったアプリは実務を通してスキルアップを図りながら作った方がより深い学習にもなると考えているからです。
 ここまでやってきたのはあくまでも「**実務を見据えた学習**」であり、今回のポートフォリオもその一環です。

## 使用技術
- Ruby 2.7.4
- Ruby on Rails 6.0.4.4
- Postgres
- Docker/Docker-compose
- Rspec

## 機能一覧
- 記事一覧機能(トップページ)
- マイページ（自分が書いた記事の一覧）
![ホーム画面](https://media.giphy.com/media/wVICyqnBUfFLuu9qx5/giphy.gif)
- ユーザー登録・サインイン/サインアウト
![ログイン](https://media.giphy.com/media/Z8gKPAAm3d31rgEEYE/giphy.gif)
- 記事CRUD (一覧以外)
- 記事の下書き機能
![投稿](https://media.giphy.com/media/2FOhMW6CD0XMBBXYVO/giphy.gif)

## テスト
- Rspce
  - 単体テスト（Model）
  - 結合テスト（Request）

## ER図
[erd.pdf](https://github.com/ryota-okonogi/wonderful_editor/files/8521275/erd.pdf)
