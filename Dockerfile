# ベースのコンテナイメージ
FROM eclipse-temurin:21-jdk-jammy

# 必要なツールをインストール
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends \
    maven \
    sudo \
    git \
    patch \
    less \
    ssh-client \
    curl \
    bash-completion \
    && apt-get clean

# 非rootユーザー（ubuntu）を追加して切り替え（パスワードなしのsudo権限を付与）
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ${USERNAME}

# コンテナ起動時にbashを実行
CMD ["/bin/bash"]
