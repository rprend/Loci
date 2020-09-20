from flask import Flask
import os
import tmxlib

app = Flask(__name__)


@app.route('/')
def asset_default():
    return "Default asset"

@app.route('/<id>')
def asset_id(id):
    return id

if __name__ == '__main__':
    app.run()

