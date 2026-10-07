# 卒論用テンプレートリポジトリ
GitHub の `Use this template` ボタンを押して複製して使用してください．


## フォルダ構成
### アブストラクト
- [`abstract/`](./abstract/)
    - `main.tex`: タイトル・著者・本文などを書く
    - `references.bib`: 参考文献リスト BibTex
    - [`templates/`](./abstract/templates/): 気にしなくて良い

### 本論
- [`main/`](./main/)
    - `main.tex`: タイトル・著者を書く，チャプターを追加したらここに追記する
    - `references.bib`: 参考文献リスト BibTex
    - [`chapters/`](./main/chapters/)
        - `*.tex`: 本文の各チャプターを書く
    - [`templates/`](./main/templates/): 気にしなくて良い


## 使い方
### 参考文献
BibTex形式で [abstract/references.bib](./abstract/references.bib) / [main/references.bib](./main/references.bib) に書く．


### アブストラクトの記述
タイトル・著者・本文は [abstract/main.tex](./abstract/main.tex) に書く．


## 本論の記述
タイトル・著者・本文は [main/main.tex](./main/main.tex) に書く．
本文は [main/chapters/*.tex](./main/chapters/) に書く．

チャプター追加時は，[main/chapters/*.tex](./main/chapters/) に Tex ファイルを追加し，[main/main.tex](./main/main.tex) に `\include{chapters/xxx.tex}` を追記する．


### 自動保存（commit・push）
`⌘ + Shift + P` を押下 → `Tasks: Run Task` を実行

- 🟢 Cron開始（5分ごと自動commit＋push）
- 🟡 Cron開始（5分ごと自動commit、pushなし）
- 🛑 Cron停止
- ❓ Cron状態確認
- 📝 自動commitログを表示

## LICENSE
[MIT License](./LICENSE)
