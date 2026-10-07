# 情報学ワークショップ (WiNF) 論文テンプレートリポジトリ
情報学ワークショップ (WiNF) の研究論文（A4・2段組・4ページ以内）用 LaTeX テンプレートです．
GitHub の `Use this template` ボタンを押して複製して使用してください．


## フォルダ構成
- `main.tex`: タイトル・著者・所属・本文を書く
- `references.bib`: 参考文献リスト BibTeX
- [`templates/`](./templates/): 気にしなくて良い
    - `0-config.tex`: ドキュメントクラス・パッケージ読み込み・タイトル出力
    - `1-bibliography.tex`: 参考文献の出力
    - `winf-paper.sty`: WiNF 論文フォーマットのスタイルファイル
- `prh.yml`: textlint の表記ゆれルール


## 環境構築
VSCode で本リポジトリを開き，`⌘ + shift + P` を押して `Dev Containers: Reopen in Container (コンテナーで再度開く)` を実行する．
もしくは，VSCode の左下の緑色のアイコンをクリックして `Reopen in Container` を選択する．
もしくは，VSCode を開いた時に出る `Reopen in Container (コンテナーで再度開く)` のポップアップをクリックする．
TeX Live（日本語）・LaTeX Workshop・textlint などがセットアップされたコンテナが起動する．


## 使い方
### タイトル・著者の記述
[main.tex](./main.tex) の冒頭で指定する．

```tex
\title{論文タイトル}
\author{情報　太郎 \qquad 情報　花子}
\affiliation{情報大学情報学部}
```

所属が複数の場合は `\DAG{n}` で番号を付ける．
英語の著者名・所属は `\eauthor` / `\eaffiliation` で指定できる（[main.tex](./main.tex) のコメント参照）．


### 本文の記述
[main.tex](./main.tex) の `\begin{document}` 〜 `\input{templates/1-bibliography}` の間に書く．
タイトルの出力（`\maketitle`）は自動で行われる．


### 参考文献
BibTeX 形式で [references.bib](./references.bib) に書き，本文中で `\cite{key}` で引用する．


### ビルド
LaTeX Workshop のレシピ `uplatex -> upbibtex -> uplatex*2` でビルドする（保存時に自動ビルド）．
ターミナルからは以下でもビルドできる．

```sh
latexmk main.tex
```


### 文章校正
textlint が有効になっており，入力中にチェック・保存時に自動修正される．
ルールは [.textlintrc](./.textlintrc)，表記ゆれの辞書は [prh.yml](./prh.yml) で設定する．


### 自動保存（commit・push）
`⌘ + Shift + P` を押下 → `Tasks: Run Task` を実行

- 🟢 Cron開始（5分ごと自動commit＋push）
- 🟡 Cron開始（5分ごと自動commit、pushなし）
- 🛑 Cron停止
- ❓ Cron状態確認
- 📝 自動commitログを表示


## LICENSE
[MIT License](./LICENSE)
