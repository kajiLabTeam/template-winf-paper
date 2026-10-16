FROM ubuntu:26.04@sha256:f144425ff09be612d6d9ad965196e9cdc23dae1f42110a8a11a3e9a8198759f7

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xdvik-ja \ 
    evince \
    texlive-lang-cjk \
    latexmk \
    language-pack-ja \
    wget \
    xzdec \
    texlive-latex-extra \
    git \
    cpanminus \
    texlive-extra-utils \
    make \
    npm \
    gh

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN kanji-config-updmap-sys ipaex

WORKDIR /workdir
VOLUME ["/workdir"]

RUN npm i -g \
    textlint \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-preset-jtf-style \
    textlint-rule-prh \
    textlint-plugin-latex2e \
    textlint-rule-preset-ja-engineering-paper

CMD ["bash"]

RUN cpanm Log::Log4perl Log::Dispatch::File YAML::Tiny File::HomeDir Unicode::GCString
