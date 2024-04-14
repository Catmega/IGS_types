 basic tutorial (on SolrCloud), standalone solr is similar:
 https://solr.apache.org/guide/solr/latest/getting-started/tutorial-films.html
 ## create docker container of solr, and directly create a core
 ### initilize core when creating container
 https://solr.apache.org/guide/solr/latest/deployment-guide/solr-in-docker.html  

 docker run -d  -p 8085:8983 --name igs_solr solr solr-precreate IGS{{CORE_NAME}}
 (cannot mount, mount leads to error)

### http API
Core API:
https://solr.apache.org/guide/8_6/coreadmin-api.html#coreadmin-create
use predefined config set:
https://solr.apache.org/guide/8_5/config-sets.html#config-sets

http://192.168.221.163:8085/solr/admin/cores?action=CREATE&name=test&instanceDir=data&configSet=/opt/solr-9.5.0/server/solr/configsets/_default

(use absolute file path to point to the configset)

 ## add fields in the schema
 curl --request POST \
  --url http://localhost:8086/solr/IGS/schema \
  --header 'Content-Type: application/json' \
  --data '{
  "add-field": [
    {"name": "recordName", "type": "text_general", "multiValued": false},
    {"name": "cat", "type": "string", "multiValued": true},
    {"name": "manu", "type": "string"},
    {"name": "features", "type": "text_general", "multiValued": true},
    {"name": "weight", "type": "pfloat"},
    {"name": "price", "type": "pfloat"},
    {"name": "popularity", "type": "pint"},
    {"name": "inStock", "type": "boolean", "stored": true},
    {"name": "store", "type": "location"}
  ]
}'

## update doc
curl --request POST \
--url 'http://localhost:8085/solr/IGS/update' \
  --header 'Content-Type: application/json' \
  --data '  {
    "id" : "978-0641723445",
    "cat" : ["book","hardcover"],
    "name" : "The Lightning Thief",
    "author" : "Rick Riordan",
    "series_t" : "Percy Jackson and the Olympians",
    "sequence_i" : 1,
    "genre_s" : "fantasy",
    "inStock" : true,
    "price" : 12.50,
    "pages_i" : 384
  }'

## index a doc
https://solr.apache.org/guide/6_6/uploading-data-with-index-handlers.html

https://solr.apache.org/guide/solr/latest/indexing-guide/indexing-with-update-handlers.html

curl -X POST -H 'Content-Type: application/json' 'http://localhost:8085/solr/IGS/update/json/docs' --data-binary '
{
    "id" : "978-0641723445",
    "cat" : ["book","hardcover"],
    "name" : "The Lightning Thief",
    "author" : "Rick Riordan",
    "series_t" : "Percy Jackson and the Olympians",
    "sequence_i" : 1,
    "genre_s" : "fantasy",
    "inStock" : true,
    "price" : 12.50,
    "pages_i" : 384
}'

[{
    "id" : "001-232401",
    "title" : "Review on Cloud Applications",
    "author" : "Nancy",
    "description" : "This paper talks about the current researches on Cloud Applications. Excellent review."
  }]

curl --request POST \
  --url 'http://localhost:8085/solr/IGS/update' \
  --header 'Content-Type: application/json' \
  --data '  [{
    "id" : "001-232401",
    "title" : "Information Governance System running on a Cloud",
    "author" : "Nancy",
    "description" : "This paper talks about how a Information Governance System runs on a Cloud"
  }]'

curl --request POST \
  --url 'http://localhost:8085/solr/IGS/update' \
  --header 'Content-Type: application/json' \
  --data '  [
  {
    "id" : "978-0641723445",
    "cat" : ["book","hardcover"],
    "name" : "The Lightning Thief",
    "author" : "Rick Riordan",
    "series_t" : "Percy Jackson and the Olympians",
    "sequence_i" : 1,
    "genre_s" : "fantasy",
    "inStock" : true,
    "price" : 12.50,
    "pages_i" : 384
  }
,
  {
    "id" : "978-1423103349",
    "cat" : ["book","paperback"],
    "name" : "The Sea of Monsters",
    "author" : "Rick Riordan",
    "series_t" : "Percy Jackson and the Olympians",
    "sequence_i" : 2,
    "genre_s" : "fantasy",
    "inStock" : true,
    "price" : 6.49,
    "pages_i" : 304
  }
]'
## query

curl 'http://localhost:8085/solr/IGS/select?q=author%3ANancy' 
curl 'http://localhost:8084/solr/gettingstarted/select?q=name%3Alightning'
(%3A is the encoding for ":")
## upload local file
https://solr.apache.org/guide/solr/latest/indexing-guide/indexing-with-tika.html

!!!FAILED!!!!
curl 'http://localhost:8084/solr/gettingstarted/update/extract?literal.id=00001&commit=true' -F "myfile=@/example/films/films.json"

## cloud mode list configs
http://192.168.221.163:8084/solr/admin/configs?action=LIST&omitHeader=true

curl -X POST -H 'Content-type:application/json' -d '{
  "add-requesthandler": {
    "name": "/update/extract",
    "class": "solr.extraction.ExtractingRequestHandler",
    "defaults":{ "lowernames": "true", "captureAttr":"true"}
  }
}' 'http://localhost:8084/solr/gettingstarted/config'