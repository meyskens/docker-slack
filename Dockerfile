FROM meyskens/desktop-base

# Inspired from https://github.com/jessfraz/dockerfiles/blob/master/slack/Dockerfile

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	locales \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

# Add the slack debian repo
RUN curl -sSL https://packagecloud.io/slacktechnologies/slack/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" > /etc/apt/sources.list.d/slacktechnologies_slack.list

RUN apt-get update && apt-get -y install \
	libasound2 \
	libgtk-3-0 \
	libx11-xcb1 \
	libxkbfile1 \
	slack-desktop \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/meyskens/x-www-browser-forward/releases/download/0.0.1/client && \
	mv client /usr/bin/x-www-browser && \
	chmod +x  /usr/bin/x-www-browser

RUN apt-get update && apt-get install -y hicolor-icon-theme

USER user

ENTRYPOINT ["/usr/bin/slack"]

