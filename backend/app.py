import flask
from flask import request
from werkzeug.utils import secure_filename
import os
import tmxlib

import asyncio

from arcadeRender import set_tmx, main_arcade

loop = asyncio.get_event_loop()
app = flask.Flask(__name__)

app.config['UPLOAD_FOLDER'] = './'

async def construct_from_image(image):
    await asyncio.sleep(2)
    return "Async return"

@app.route('/scan', methods=['POST'])
def scan_image():
    image = request.files['img']
    filename = secure_filename(image.filename)
    new_filepath = os.path.join(app.config['UPLOAD_FOLDER'],filename)
    image.save(new_filepath)

    print(image)
    result = loop.run_until_complete(construct_from_image(image))

    set_tmx(new_filepath)
    main_arcade()

    return result

if __name__ == '__main__':
    app.run()

