var express = require('express');
var fs = require('fs');
var router = express.Router();

var rawdata = fs.readFileSync('../schema.json');
var biz = JSON.parse(rawdata);
console.log (biz)


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', biz);
});

module.exports = router;
