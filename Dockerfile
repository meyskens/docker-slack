FROM jess/slack 

RUN apt-get update && apt-get install wget

RUN wget https://github.com/meyskens/x-www-browser-forward/releases/download/0.0.1/client && \
	mv client /usr/bin/x-www-browser && \
	chmod +x  /usr/bin/x-www-browser