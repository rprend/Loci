import flask
from flask import request
import os
import tmxlib

import asyncio

loop = asyncio.get_event_loop()
app = flask.Flask(__name__)

async def construct_from_image(image):
    await asyncio.sleep(2)
    return "hell yeah bitch we goooood!"

@app.route('/scan', methods=['POST'])
def scan_image():
    image = request.json['img']
    print(image)
    result = loop.run_until_complete(construct_from_image(image))

    return result

if __name__ == '__main__':
    app.run()

