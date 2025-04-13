# OpenJDKのランタイムを使用
FROM openjdk:11-jdk-slim

# 必要なツールをインストール
RUN apt update && apt install -y \
    sudo \
    git \
    maven \
    curl \
    wget \
    bash-completion \
    && apt clean

# 非rootユーザーを作成して切り替え
RUN useradd -m -s /bin/bash user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# ユーザーを切り替え
USER user

# Mavenのローカルリポジトリをキャッシュするためのディレクトリを作成
RUN mkdir -p /home/user/.m2 && \
    chown -R user:user /home/user/.m2

# コンテナ起動時にbashを実行
CMD ["/bin/bash"]

# エイリアスを設定
RUN echo "alias ll='ls -lha'" >> ~/.bash_aliases

# bashのプロンプトにGitの情報が表示されるようにカスタマイズ
# wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O /usr/share/bash-completion/completions/git-prompt.sh
