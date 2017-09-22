FROM jess/slack

RUN useradd user

RUN wget https://github.com/meyskens/x-www-browser-forward/releases/download/0.0.1/client && \
	mv client /usr/bin/x-www-browser && \
	chmod +x  /usr/bin/x-www-browser

USER user

ENTRYPOINT ["/usr/bin/slack"]

