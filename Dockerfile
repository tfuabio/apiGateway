# ベースのコンテナイメージ
FROM eclipse-temurin:21-jdk

# 必要なツールをインストール
RUN apt update && apt install -y \
    maven \
    sudo \
    git \
    curl \
    wget \
    bash-completion \
    && apt clean

# 非rootユーザー（ubuntu）に切り替え（パスワードなしのsudo権限を付与）
ARG USERNAME=ubuntu
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${USERNAME}

# コンテナ起動時にbashを実行
CMD ["/bin/bash"]
