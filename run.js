var util = require('util');
var parser = require('./vbs4').parser;
var source = require('fs').readFileSync('./test.vbs', 'utf8');
//console.log(source);
console.log(util.inspect(parser.parse(source), false, null));
