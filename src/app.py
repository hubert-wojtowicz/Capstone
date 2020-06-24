from flask import Flask
from flask.logging import create_logger
import logging
import requests 

app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)

JOKE_API_URL = 'https://official-joke-api.appspot.com/random_joke'

@app.route("/joke")
def home():
    r = requests.get(url = JOKE_API_URL) 
    data = r.json() 
    return data

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, debug=True)
