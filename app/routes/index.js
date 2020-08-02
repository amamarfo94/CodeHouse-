var express = require('express');
var fs = require('fs');
var router = express.Router();

var rawdata = fs.readFileSync('../businesses.json');
var businesses = JSON.parse(rawdata);
console.log(businesses)


/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', businesses[1]);
});

router.post('/results', function (req, res, next) {
  console.log(req.body);
  var category = req.body.category;
  var minorityGroup = req.body.minorityGroup;
  var myList = [];

  for (let i = 0; i < businesses.length; i++) {
    var biz = businesses[i]; 
    console.log(biz);
    if (category == biz.Category && minorityGroup == biz.MinorityGroup) {
      myList.push(biz)
    }
  }
  console.log(category);
  console.log(minorityGroup);
  console.log(myList);
  res.render('results', {myList: myList});
});


router.get('/bizinfo', function (req, res, next) {
  res.render('bizinfo', businesses[1]);
});

module.exports = router;
