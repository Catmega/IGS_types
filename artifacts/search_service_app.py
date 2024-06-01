from flask import Flask, request, jsonify, redirect
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)  # This will enable CORS for all domains on all routes
solr_url = 'http://solr:8983/solr/IGS/'
# solr = pysolr.Solr(solr_url, always_commit=True)

@app.route('/search')
def search():

    author = request.args.get('author')

    response = requests.get(f"{solr_url}select?q=author%3A{author}")
    response_json = response.json()

    # Extract the 'docs' from Solr's response
    docs = response_json.get('response', {}).get('docs', [])
    # titles = [doc.get('title') for doc in docs if 'title' in doc]
    # print(titles[0])
    return jsonify(docs)

if __name__ == '__main__':

    app.run(host='0.0.0.0', port=8080)
