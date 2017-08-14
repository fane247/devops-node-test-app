var express = require('express');
var app = express();
var mongoose = require('mongoose');

mongoose.createConnection(process.env.DB_HOST || 'mongodb://localhost/test');

app.set('view engine' , 'ejs');

app.get("/" , function(req, res) {
  res.render("index");
});

app.get("/database" , function(req, res){
  var Test = mongoose.model('Test', { name: String });

  // find all test data for testing
  Test.find({}, function(err, data){
    res.json(data);
  });
});

app.listen(3000 , function(){
  console.log('app is listening on port 3000');
});

module.exports = app;