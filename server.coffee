express = require "express"
hat = require "hat"
app = express()
port = 12012

# Middleware
app.use express.logger()
app.use express.bodyParser()

mongo = require "mongoskin"
db = mongo.db "localhost:27017/my_object_store"
store = db.collection "store"


storeEndPoint = "store"

app.get "/", (req, res) ->
    res.send "alive and kicking"

app.get "/generateId", (req, res) ->
    res.send hat()


app.put "/#{storeEndPoint}/:key", (req, res) ->
    store.update 
        key: req.params.key
    ,
        key: req.params.key,
        obj: req.body
    ,
        upsert:true
    , (err, results) ->
            if err then res.send 500
            else
                res.send 200
    
app.get "/#{storeEndPoint}/:key", (req, res) ->
    store.findOne {key: req.params.key}, {}, (err, result) ->
        if result == null then res.send 404
        else if err then res.send 500
        else res.send result.obj
app.listen 12012
