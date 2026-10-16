FROM ubuntu:25.04@sha256:3fa335765c57a9ef67f62ef33b4411266c576f4dbdd9d5255f5da2ac306e021f

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xdvik-ja \ 
    evince \
    texlive-lang-cjk \
    latexmk \
    language-pack-ja \
    wget \
    cron \
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
