FROM ubuntu:18.04

ENV QXMLEDIT_VERSION=0.9.11

# Add files
ADD files/qxmledit /opt/QXmlEditBin/

# Install dev packages and tools
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    libqt4-dev \
    libqt4-xmlpatterns \
    ruby \
    ruby-dev \
    rubygems \
    curl \
  && rm -rf /var/lib/apt/lists/* \
  && gem install --no-ri --no-rdoc fpm

# Download source code and build
RUN mkdir -p /build /opt/QXmlEditBin \
  && curl -Lk https://github.com/lbellonda/qxmledit/archive/${QXMLEDIT_VERSION}.tar.gz \
    | tar -zxvf - -C /build \
  && cd /build/qxmledit-${QXMLEDIT_VERSION} \
  && qmake \
  && make \
  && make install

# Build package with fpm
RUN mkdir -p /dist/ \
  && fpm \
    -t deb \
    -v ${QXMLEDIT_VERSION} \
    -d libqt4-xmlpatterns \
    -d libsoqt4-20 \
    -d libqt4-svg \
    -p /dist/ \
    -n qxmledit \
    -s dir \
      /opt/qxmledit \
      /opt/QXmlEditBin/qxmledit=/usr/local/bin/qxmledit \
      /opt/qxmledit/QXmlEdit.desktop=/usr/local/share/applications/QXmlEdit.desktop
