FROM ubuntu

ENV LC_ALL C

COPY ./supervisor/supervisord.conf /etc/supervisor/conf.d/
COPY ./scripts/start.sh /usr/local/bin/

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get install -y unzip && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y mosquitto && \
    apt-get install -y npm && \
    apt-get install -y supervisor && \
    npm install -g node-red && \
    echo 'listener 9001' | tee /etc/mosquitto/conf.d/websocket.conf && \
    echo 'protocol websockets' | tee --append /etc/mosquitto/conf.d/websocket.conf && \
    echo 'listener 1883' | tee /etc/mosquitto/conf.d/mqtt.conf && \
    echo 'protocol mqtt'| tee --append /etc/mosquitto/conf.d/mqtt.conf && \
    apt-get install -y python3-pip && \
    pip3 install bcg && \
    WEB_ZIP_URL=$(curl -s https://api.github.com/repos/bigclownlabs/bch-hub-web/releases/latest | grep browser_download_url | grep zip | head -n 1 | cut -d '"' -f 4) && \
    wget "$WEB_ZIP_URL" -O /tmp/web.zip && \
    unzip /tmp/web.zip -d /var/www/html && \
    chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8