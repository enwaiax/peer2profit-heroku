FROM frolvlad/alpine-glibc
RUN apk update && apk add --no-cache --update python3 py3-pip
WORKDIR /root/webapp
ADD ./webapp /root/webapp/
RUN pip3 install --no-cache-dir -q -r /root/webapp/requirements.txt

VOLUME ["/root/.config/"]
ENV EMAIL=chasing66@live.com
# Expose is NOT supported by Heroku
# EXPOSE 5000
# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
ENTRYPOINT ["sh", "-c", "/root/webapp/entrypoint.sh"]
