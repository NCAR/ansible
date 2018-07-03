FROM alpine:3.6
ENV NAME=ansible \
    REPO_USER=ncar \
    VERSION=2.5.2.0
LABEL name="${NAME}"
LABEL repouser="${REPO_USER}"
LABEL version="${VERSION}"
RUN apk add --update \
    ca-certificates \
    bash \
    git \
    openssh-client \
    openssl \
    python \
    py-pip \
    rsync \
    sshpass \
    tini && \
    apk --update add --virtual build-dependencies \
                     python-dev libffi-dev openssl-dev build-base && \
    pip install --upgrade pip cffi && \
    pip install "ansible==${VERSION}" && \
    pip install --upgrade pywinrm && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

ENV HOME /tmp/home
WORKDIR ${HOME}

RUN chmod 4755 /usr/bin/ssh-add && \
    adduser -h /tmp/home -s /bin/bash -G users -u 999 -D ansible && \
    mkdir -p /etc/ansible  && \
    echo 'localhost' > /etc/ansible/hosts
USER ansible

CMD [ "/bin/bash" ]
