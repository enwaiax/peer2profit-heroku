FROM enwaiax/peer2profit
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /root/webapp
ADD ./webapp /root/webapp/
RUN pip3 install --no-cache-dir -q -r /root/webapp/requirements.txt
VOLUME ["/root/.config/"]
ENV EMAIL=chasing66@live.com
ENTRYPOINT ["sh", "-c", "/root/webapp/entrypoint.sh"]
