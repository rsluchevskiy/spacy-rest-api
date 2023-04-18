from flask import Flask
from flask import jsonify
from flask import request
import spacy

english_nlp = spacy.load('en_core_web_trf')

app = Flask(__name__)

@app.route('/nlp', methods=['POST'])
def base_url():
    spacy_parser = english_nlp(request.data.decode("utf-8") )

    response = {}

    for entity in spacy_parser.ents:
        if entity.label_ in ['ORG', 'PERSON']:
            response[entity.text] = entity.label_

    return jsonify(response)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
