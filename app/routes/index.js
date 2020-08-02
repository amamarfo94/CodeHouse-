var express = require('express');
var fs = require('fs');
var router = express.Router();

var rawdata = fs.readFileSync('../businesses.json');
var biz = JSON.parse(rawdata);
console.log (biz)


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', biz[1]);
});

router.get('/bizinfo', function(req, res, next) {
  res.render('bizinfo', biz[1]);
});

module.exports = router;
