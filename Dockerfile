FROM enwaiax/peer2profit
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /root/webapp
ADD webapp .
RUN pip3 install --no-cache-dir -q -r requirements.txt
VOLUME ["/root/.config/"]
ENTRYPOINT ["python3", "main.py"]
