# 最新のDebianベースのOpenJDK 21イメージを使用
FROM eclipse-temurin:21-jdk

# 必要なツールをインストール
RUN apt update && apt install -y \
    sudo \
    git \
    maven \
    curl \
    wget \
    bash-completion \
    && apt clean

# 非rootユーザー（user）を作成して切り替え
# TODO: userはパスワードなしのためデプロイ時は注意が必要
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
