const express = require('express');
const app = express();

let data = require('./data');

// Purposefully make all requests take 500 to 2500 ms
app.use(function(req, res, next) {
  setTimeout(
    next,
    Math.floor((Math.random() * 2000) + 500)
    /*
    NOTE: can comment this line above and instead leave a 0
    (essentially no delay) for initial development - but make
    sure to add the delay back eventually
    */
  );
});

// Static files from docs folder
app.use('/api/documents', express.static(__dirname + '/docs'));

// API request to get JSON in data.json
app.get('/api/documents', function(req, res, next) {
  res.status(200).json(data);
});

app.listen(3000, function () {
  console.log('Server listening on port 3000!');
});