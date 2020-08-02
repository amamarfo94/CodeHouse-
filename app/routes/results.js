var express = require('express');
var fs = require('fs');
var router = express.Router();

var rawdata = fs.readFileSync('../businesses.json');
var biz = JSON.parse(rawdata);
console.log (biz)


/* GET home page. */
router.get('/results', function(req, res, next) {
  res.render('results', biz[1]);
});

module.exports = router;
