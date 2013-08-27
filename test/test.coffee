assert = require "assert"
request = require "request"
store_address = "localhost:12012"
store_endpoint = "store"

describe "the obvious", ->
    it "should be that 1+1 equals 2", ->
        assert.equal 1+1,2


describe "store and retrieve", ->
    obj_key = "asdasd"
    test_obj = 
        messaggio: "message in a bottle..."
    it "shoul be responding", (done) ->
        request.get "http://#{store_address}/", (err, res, body) ->
           assert.equal res.statusCode, 200 
           done()
    it "should accept post of objects", (done) ->
        request.put "http://#{store_address}/#{store_endpoint}/#{obj_key}", {
            json: test_obj 
        }, (err, res, body) ->
            assert.equal res.statusCode, 200
            done()
    it "should retrieve the same object I sent", (done) ->
        request.get "http://#{store_address}/#{store_endpoint}/#{obj_key}", {
            json: true}, (err, res, body) ->
                assert.deepEqual test_obj, body
                done()
    it "/generateId should respond with something like an ID", (done) ->
        request.get "http://#{store_address}/generateId", (err, res, body) ->
            assert.ok(body.length > 0)
            done()
    

    #it "should be that if I store an obj, and then retrieve it, 
       #it should be the same", (done) -> 
            #obj_key = "asdasdads"
            #requests.put {
                #url: "http:#{store_address}/#{obj_key}"
                #body: {message: "message in a bottle"}
            #}, (error, response, body) ->
                #if error?
                    #console.error error
                #else
                    #request.

