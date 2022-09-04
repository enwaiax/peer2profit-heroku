import os
import socket

from flask import Flask
from requests import get

app = Flask(__name__)

CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))


@app.route('/')
def hello():
    '''Nothing but hello'''
    hostname = socket.gethostname()
    IP = get('https://api.ipify.org').text
    with open(os.path.join(CURRENT_DIR, "test.log"), encoding='utf_8') as f:
        message = f.readlines()[-20:]
    return f"""
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Hello wrold</title>
</head>

<body>
    <h2>Hello from: {IP} on: {hostname}</h2>
    <h3>
        <a href="https://p2pr.me/16297247056123a02153377" target="_blank">Want to give it a try??</a>
    </h3>
    <a href="https://p2pr.me/16297247056123a02153377" target="_blank"><img
            src="https://peer2profit.co/img/promo/en/p2p-banner-640x100.png" width="640" height="100" /></a>
    <p>{'<br />'.join(message)}</p>
</body>

</html>
    """


if __name__ == '__main__':
    app.run(host='0.0.0.0')
