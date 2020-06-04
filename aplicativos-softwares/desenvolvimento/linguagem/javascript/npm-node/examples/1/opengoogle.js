const https = require('https');

const url = "https://google.com";

// https://nodejs.org/api/https.html
var googlesite = https.get(url);

console.dir(googlesite);

const options = new URL(url);

console.log(url);

const fs = require('fs');

