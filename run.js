var util = require('util');
var parser = require('./vbs4').parser;
var compile = require('./compiler').compile;
var source = require('fs').readFileSync(process.argv[2], 'utf8');

var prg = compile(source, parser);
prg = "(function () {\n" + prg + "\n})();"; /* wrap everything in an anonymous function */
//var prg = new Node(ast.body[1]).compile();
console.log(prg);

console.log(eval(prg));
