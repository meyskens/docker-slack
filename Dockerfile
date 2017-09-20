FROM debian:jessie
LABEL maintainer "Jessie Frazelle <jess@linux.com>"

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	locales \
	wget \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

# Add the slack debian repo
RUN curl -sSL https://packagecloud.io/slacktechnologies/slack/gpgkey | apt-key add -

RUN apt-get update && apt-get -y install \
	libasound2 \
	libx11-xcb1 \
	--no-install-recommends 

RUN wget wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.7.1-amd64.deb &&\
	dpkg -i slack-desktop-2.7.1-amd64.deb || apt-get -f -y install &&\
	rm -f slack-desktop-2.7.1-amd64.deb

RUN apt-get update && apt-get install -y wget

RUN useradd user

RUN wget https://github.com/meyskens/x-www-browser-forward/releases/download/0.0.1/client && \
	mv client /usr/bin/x-www-browser && \
	chmod +x  /usr/bin/x-www-browser

USER user

ENTRYPOINT ["/usr/bin/slack"]

