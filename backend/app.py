import flask
from flask import request
from werkzeug.utils import secure_filename
import os
import tmxlib

import asyncio

from arcadeRender import set_tmx, main_arcade
from parse_maps import measure_buildings

loop = asyncio.get_event_loop()
app = flask.Flask(__name__)

app.config['UPLOAD_FOLDER'] = './'

def construct_from_image(image):
    parsed_buildings = measure_buildings(image)
    return parsed_buildings

@app.route('/scan', methods=['POST'])
def scan_image():
    image = request.files['img']
    filename = secure_filename(image.filename)
    new_filepath = os.path.join(app.config['UPLOAD_FOLDER'],filename)
    image.save(new_filepath)

    result = construct_from_image(new_filepath)

    #set_tmx(new_filepath)
    #main_arcade()

    return result

@app.route('/test')
def test():
    return 'hhh'

if __name__ == '__main__':
    app.run(host='0.0.0.0')

