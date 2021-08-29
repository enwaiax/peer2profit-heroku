FROM frolvlad/alpine-glibc
ENV email=chasing0806@gmail.com

# Add http server to serve the test.log
RUN apk add --no-cache --update python3 py3-pip bash
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt
# Add our code
ADD ./webapp /root/webapp/
WORKDIR /root/webapp
# Expose is NOT supported by Heroku
# EXPOSE 5000 

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
ENTRYPOINT ["sh", "-c", "/root/webapp/entrypoint.sh"]
