# OpenJDKのランタイムを使用
FROM openjdk:11-jdk-slim

# 必要なツールをインストール
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    maven \
    && apt-get clean

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