import os
import socket

from flask import Flask

from requests import get

app = Flask(__name__)

@app.route('/')
def hello():
    ip = get('https://api.ipify.org').text
    with open(os.path.join(os.path.dirname(os.path.abspath(__file__)),"test.log")) as f:
        message = f.readlines()[-5:]
    return f"Hello from {ip}!"  + '<br>' + '<br>'.join(message)

if __name__ == '__main__':
    app.run(host='0.0.0.0')


