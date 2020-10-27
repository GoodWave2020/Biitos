# README
## 音楽マッチングアプリ Biitos
![Biitos-top](https://user-images.githubusercontent.com/65487142/97261141-94aa1180-1861-11eb-9318-a331c43133fb.png)
###リンク
https://biitos.com/
### 概要
Biitosはあなたの声に必要な曲、曲に必要な声を探せるアプリです。
投稿からお気に入りの音源を探してユーザーをフォロー。マッチ後曲を渡しあうことができます。
### コンセプト
気に入った作曲者、ボーカリスト、ラッパーなどと素早く音楽製作を始められる。
### バージョン
Ruby 2.6.5 Rails 5.2.4
### ログイン用ユーザー
DM(ダイレクトメール)機能を確認する際にお使いください。
ヘッダーのユーザー名からDM(ダイレクトメール)一覧に飛びます。
- email: number0@tuner.com pass: password
- email: number@voicer.com pass: password
### 機能一覧
- 音楽投稿機能
- 音楽再生
- 投稿一覧
- 投稿検索
- ログイン機能
- ページネーション(未実装)
- フォロー機能
- ユーザー詳細
- お気に入り機能(Ajax)
- 通知機能
- SNSログイン機能(未実装)
- DM機能
- 音楽ダウンロード機能
- コメント機能
- グループチャット
- タグ機能
  投稿にタグ付けが可能
- ジャンル機能
- ランキング機能(未実装)
- オススメユーザー機能(未実装)
- 好きなアーティストが似ているユーザーを表示(未実装)
### システム構成
![システム構成](https://user-images.githubusercontent.com/65487142/97112337-13e6fa80-1727-11eb-8490-6afd2d994770.jpg)
### カタログ設計
https://docs.google.com/spreadsheets/d/16wwKR8sxm-Q8o30x6buVFDllLR5vcxwePHugEuG_kWQ/edit?usp=sharing
### テーブル定義
https://docs.google.com/spreadsheets/d/1Dt5IyWLdRef8ePar9VVMylWH2-7twJJG2WjFJ9Gy780/edit?usp=sharing
### ER図
https://docs.google.com/spreadsheets/d/1kjWCu8uAHo0Ud9fxpyxO7CPkayP4vbM6m1mG8X4s8co/edit?usp=sharing
### 画面遷移図
https://docs.google.com/spreadsheets/d/10jI90SKZRfCtVRQqNBoIjIcfjp_pAgeD56lA4QoShzM/edit?usp=sharing
### ワイヤーフレーム
https://docs.google.com/spreadsheets/d/1gpwRvZRek0DiApa-pT1f58Lk7cLqKueKPlFY5robQmM/edit?usp=sharing
### 使用予定Gem
- carrierwave
- mini_magick
- devise
- ransack
- audiojs-rails
- carrierwave-audio
- slim-rails
- font-awesome-sass
### Dependency
- SoX
- Bash (for process substitution combiner strategy)
- Chromaprint (only to run tests)
#### Ubuntu / Debian
`apt-get install libsox-fmt-all sox libchromaprint-dev`
#### Mac
※macの場合パッケージ管理ツールであるportsが必要です。下記リンクからご自身の環境に合ったバージョンをインストールしてください。

https://github.com/macports/macports-base/releases/tag/v2.6.3
```
# One of the following
# Notes:
# * chromaprint is not available in MacPorts as of this writing
# * flac must be installed before sox so it will link during compilation
sudo port install flac sox && brew install chromaprint
brew install flac sox chromaprint
```
