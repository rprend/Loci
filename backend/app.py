import flask
from flask import request
from werkzeug.utils import secure_filename
import os
import tmxlib

import asyncio

loop = asyncio.get_event_loop()
app = flask.Flask(__name__)

app.config['UPLOAD_FOLDER'] = './img/'

async def construct_from_image(image):
    await asyncio.sleep(2)
    return "Async return"

@app.route('/scan', methods=['POST'])
def scan_image():
    image = request.files['img']
    filename = secure_filename(image.filename)
    image.save(os.path.join(app.config['UPLOAD_FOLDER'],filename))

    print(image)
    result = loop.run_until_complete(construct_from_image(image))

    return result

if __name__ == '__main__':
    app.run()

