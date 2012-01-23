/* Jison generated parser */
var dism = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"pgm":3,"instlist":4,"label":5,"COLON":6,"inst":7,"ADD":8,"intt":9,"SUB":10,"MUL":11,"MOV":12,"LOD":13,"STR":14,"JMP":15,"BEQ":16,"BLT":17,"RDN":18,"PTN":19,"HLT":20,"LABEL":21,"INT":22,"$accept":0,"$end":1},
terminals_: {2:"error",6:"COLON",8:"ADD",10:"SUB",11:"MUL",12:"MOV",13:"LOD",14:"STR",15:"JMP",16:"BEQ",17:"BLT",18:"RDN",19:"PTN",20:"HLT",21:"LABEL",22:"INT"},
productions_: [0,[3,1],[4,4],[4,2],[4,0],[7,4],[7,4],[7,4],[7,3],[7,4],[7,4],[7,4],[7,4],[7,4],[7,2],[7,2],[7,2],[5,1],[9,1],[9,1]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
}
},
table: [{1:[2,4],3:1,4:2,5:3,7:4,8:[1,6],10:[1,7],11:[1,8],12:[1,9],13:[1,10],14:[1,11],15:[1,12],16:[1,13],17:[1,14],18:[1,15],19:[1,16],20:[1,17],21:[1,5]},{1:[3]},{1:[2,1]},{6:[1,18]},{1:[2,4],4:19,5:3,7:4,8:[1,6],10:[1,7],11:[1,8],12:[1,9],13:[1,10],14:[1,11],15:[1,12],16:[1,13],17:[1,14],18:[1,15],19:[1,16],20:[1,17],21:[1,5]},{1:[2,17],6:[2,17],8:[2,17],10:[2,17],11:[2,17],12:[2,17],13:[2,17],14:[2,17],15:[2,17],16:[2,17],17:[2,17],18:[2,17],19:[2,17],20:[2,17],21:[2,17],22:[2,17]},{5:22,9:20,21:[1,5],22:[1,21]},{5:22,9:23,21:[1,5],22:[1,21]},{5:22,9:24,21:[1,5],22:[1,21]},{5:22,9:25,21:[1,5],22:[1,21]},{5:22,9:26,21:[1,5],22:[1,21]},{5:22,9:27,21:[1,5],22:[1,21]},{5:22,9:28,21:[1,5],22:[1,21]},{5:22,9:29,21:[1,5],22:[1,21]},{5:22,9:30,21:[1,5],22:[1,21]},{5:22,9:31,21:[1,5],22:[1,21]},{5:22,9:32,21:[1,5],22:[1,21]},{5:22,9:33,21:[1,5],22:[1,21]},{7:34,8:[1,6],10:[1,7],11:[1,8],12:[1,9],13:[1,10],14:[1,11],15:[1,12],16:[1,13],17:[1,14],18:[1,15],19:[1,16],20:[1,17]},{1:[2,3]},{5:22,9:35,21:[1,5],22:[1,21]},{1:[2,18],8:[2,18],10:[2,18],11:[2,18],12:[2,18],13:[2,18],14:[2,18],15:[2,18],16:[2,18],17:[2,18],18:[2,18],19:[2,18],20:[2,18],21:[2,18],22:[2,18]},{1:[2,19],8:[2,19],10:[2,19],11:[2,19],12:[2,19],13:[2,19],14:[2,19],15:[2,19],16:[2,19],17:[2,19],18:[2,19],19:[2,19],20:[2,19],21:[2,19],22:[2,19]},{5:22,9:36,21:[1,5],22:[1,21]},{5:22,9:37,21:[1,5],22:[1,21]},{5:22,9:38,21:[1,5],22:[1,21]},{5:22,9:39,21:[1,5],22:[1,21]},{5:22,9:40,21:[1,5],22:[1,21]},{5:22,9:41,21:[1,5],22:[1,21]},{5:22,9:42,21:[1,5],22:[1,21]},{5:22,9:43,21:[1,5],22:[1,21]},{1:[2,14],8:[2,14],10:[2,14],11:[2,14],12:[2,14],13:[2,14],14:[2,14],15:[2,14],16:[2,14],17:[2,14],18:[2,14],19:[2,14],20:[2,14],21:[2,14]},{1:[2,15],8:[2,15],10:[2,15],11:[2,15],12:[2,15],13:[2,15],14:[2,15],15:[2,15],16:[2,15],17:[2,15],18:[2,15],19:[2,15],20:[2,15],21:[2,15]},{1:[2,16],8:[2,16],10:[2,16],11:[2,16],12:[2,16],13:[2,16],14:[2,16],15:[2,16],16:[2,16],17:[2,16],18:[2,16],19:[2,16],20:[2,16],21:[2,16]},{1:[2,4],4:44,5:3,7:4,8:[1,6],10:[1,7],11:[1,8],12:[1,9],13:[1,10],14:[1,11],15:[1,12],16:[1,13],17:[1,14],18:[1,15],19:[1,16],20:[1,17],21:[1,5]},{5:22,9:45,21:[1,5],22:[1,21]},{5:22,9:46,21:[1,5],22:[1,21]},{5:22,9:47,21:[1,5],22:[1,21]},{1:[2,8],8:[2,8],10:[2,8],11:[2,8],12:[2,8],13:[2,8],14:[2,8],15:[2,8],16:[2,8],17:[2,8],18:[2,8],19:[2,8],20:[2,8],21:[2,8]},{5:22,9:48,21:[1,5],22:[1,21]},{5:22,9:49,21:[1,5],22:[1,21]},{5:22,9:50,21:[1,5],22:[1,21]},{5:22,9:51,21:[1,5],22:[1,21]},{5:22,9:52,21:[1,5],22:[1,21]},{1:[2,2]},{1:[2,5],8:[2,5],10:[2,5],11:[2,5],12:[2,5],13:[2,5],14:[2,5],15:[2,5],16:[2,5],17:[2,5],18:[2,5],19:[2,5],20:[2,5],21:[2,5]},{1:[2,6],8:[2,6],10:[2,6],11:[2,6],12:[2,6],13:[2,6],14:[2,6],15:[2,6],16:[2,6],17:[2,6],18:[2,6],19:[2,6],20:[2,6],21:[2,6]},{1:[2,7],8:[2,7],10:[2,7],11:[2,7],12:[2,7],13:[2,7],14:[2,7],15:[2,7],16:[2,7],17:[2,7],18:[2,7],19:[2,7],20:[2,7],21:[2,7]},{1:[2,9],8:[2,9],10:[2,9],11:[2,9],12:[2,9],13:[2,9],14:[2,9],15:[2,9],16:[2,9],17:[2,9],18:[2,9],19:[2,9],20:[2,9],21:[2,9]},{1:[2,10],8:[2,10],10:[2,10],11:[2,10],12:[2,10],13:[2,10],14:[2,10],15:[2,10],16:[2,10],17:[2,10],18:[2,10],19:[2,10],20:[2,10],21:[2,10]},{1:[2,11],8:[2,11],10:[2,11],11:[2,11],12:[2,11],13:[2,11],14:[2,11],15:[2,11],16:[2,11],17:[2,11],18:[2,11],19:[2,11],20:[2,11],21:[2,11]},{1:[2,12],8:[2,12],10:[2,12],11:[2,12],12:[2,12],13:[2,12],14:[2,12],15:[2,12],16:[2,12],17:[2,12],18:[2,12],19:[2,12],20:[2,12],21:[2,12]},{1:[2,13],8:[2,13],10:[2,13],11:[2,13],12:[2,13],13:[2,13],14:[2,13],15:[2,13],16:[2,13],17:[2,13],18:[2,13],19:[2,13],20:[2,13],21:[2,13]}],
defaultActions: {2:[2,1],19:[2,3],44:[2,2]},
parseError: function parseError(str, hash) {
    throw new Error(str);
},
parse: function parse(input) {
    var self = this,
        stack = [0],
        vstack = [null], // semantic value stack
        lstack = [], // location stack
        table = this.table,
        yytext = '',
        yylineno = 0,
        yyleng = 0,
        recovering = 0,
        TERROR = 2,
        EOF = 1;

    //this.reductionCount = this.shiftCount = 0;

    this.lexer.setInput(input);
    this.lexer.yy = this.yy;
    this.yy.lexer = this.lexer;
    if (typeof this.lexer.yylloc == 'undefined')
        this.lexer.yylloc = {};
    var yyloc = this.lexer.yylloc;
    lstack.push(yyloc);

    if (typeof this.yy.parseError === 'function')
        this.parseError = this.yy.parseError;

    function popStack (n) {
        stack.length = stack.length - 2*n;
        vstack.length = vstack.length - n;
        lstack.length = lstack.length - n;
    }

    function lex() {
        var token;
        token = self.lexer.lex() || 1; // $end = 1
        // if token isn't its numeric value, convert
        if (typeof token !== 'number') {
            token = self.symbols_[token] || token;
        }
        return token;
    }

    var symbol, preErrorSymbol, state, action, a, r, yyval={},p,len,newState, expected;
    while (true) {
        // retreive state number from top of stack
        state = stack[stack.length-1];

        // use default actions if available
        if (this.defaultActions[state]) {
            action = this.defaultActions[state];
        } else {
            if (symbol == null)
                symbol = lex();
            // read action for current state and first input
            action = table[state] && table[state][symbol];
        }

        // handle parse error
        _handle_error:
        if (typeof action === 'undefined' || !action.length || !action[0]) {

            if (!recovering) {
                // Report error
                expected = [];
                for (p in table[state]) if (this.terminals_[p] && p > 2) {
                    expected.push("'"+this.terminals_[p]+"'");
                }
                var errStr = '';
                if (this.lexer.showPosition) {
                    errStr = 'Parse error on line '+(yylineno+1)+":\n"+this.lexer.showPosition()+"\nExpecting "+expected.join(', ') + ", got '" + this.terminals_[symbol]+ "'";
                } else {
                    errStr = 'Parse error on line '+(yylineno+1)+": Unexpected " +
                                  (symbol == 1 /*EOF*/ ? "end of input" :
                                              ("'"+(this.terminals_[symbol] || symbol)+"'"));
                }
                this.parseError(errStr,
                    {text: this.lexer.match, token: this.terminals_[symbol] || symbol, line: this.lexer.yylineno, loc: yyloc, expected: expected});
            }

            // just recovered from another error
            if (recovering == 3) {
                if (symbol == EOF) {
                    throw new Error(errStr || 'Parsing halted.');
                }

                // discard current lookahead and grab another
                yyleng = this.lexer.yyleng;
                yytext = this.lexer.yytext;
                yylineno = this.lexer.yylineno;
                yyloc = this.lexer.yylloc;
                symbol = lex();
            }

            // try to recover from error
            while (1) {
                // check for error recovery rule in this state
                if ((TERROR.toString()) in table[state]) {
                    break;
                }
                if (state == 0) {
                    throw new Error(errStr || 'Parsing halted.');
                }
                popStack(1);
                state = stack[stack.length-1];
            }

            preErrorSymbol = symbol; // save the lookahead token
            symbol = TERROR;         // insert generic error symbol as new lookahead
            state = stack[stack.length-1];
            action = table[state] && table[state][TERROR];
            recovering = 3; // allow 3 real symbols to be shifted before reporting a new error
        }

        // this shouldn't happen, unless resolve defaults are off
        if (action[0] instanceof Array && action.length > 1) {
            throw new Error('Parse Error: multiple actions possible at state: '+state+', token: '+symbol);
        }

        switch (action[0]) {

            case 1: // shift
                //this.shiftCount++;

                stack.push(symbol);
                vstack.push(this.lexer.yytext);
                lstack.push(this.lexer.yylloc);
                stack.push(action[1]); // push state
                symbol = null;
                if (!preErrorSymbol) { // normal execution/no error
                    yyleng = this.lexer.yyleng;
                    yytext = this.lexer.yytext;
                    yylineno = this.lexer.yylineno;
                    yyloc = this.lexer.yylloc;
                    if (recovering > 0)
                        recovering--;
                } else { // error just occurred, resume old lookahead f/ before error
                    symbol = preErrorSymbol;
                    preErrorSymbol = null;
                }
                break;

            case 2: // reduce
                //this.reductionCount++;

                len = this.productions_[action[1]][1];

                // perform semantic action
                yyval.$ = vstack[vstack.length-len]; // default to $$ = $1
                // default location, uses first token for firsts, last for lasts
                yyval._$ = {
                    first_line: lstack[lstack.length-(len||1)].first_line,
                    last_line: lstack[lstack.length-1].last_line,
                    first_column: lstack[lstack.length-(len||1)].first_column,
                    last_column: lstack[lstack.length-1].last_column
                };
                r = this.performAction.call(yyval, yytext, yyleng, yylineno, this.yy, action[1], vstack, lstack);

                if (typeof r !== 'undefined') {
                    return r;
                }

                // pop off stack
                if (len) {
                    stack = stack.slice(0,-1*len*2);
                    vstack = vstack.slice(0, -1*len);
                    lstack = lstack.slice(0, -1*len);
                }

                stack.push(this.productions_[action[1]][0]);    // push nonterminal (reduce)
                vstack.push(yyval.$);
                lstack.push(yyval._$);
                // goto new state = table[STATE][NONTERMINAL]
                newState = table[stack[stack.length-2]][stack[stack.length-1]];
                stack.push(newState);
                break;

            case 3: // accept
                return true;
        }

    }

    return true;
}};

return parser;
})();
if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = dism;
exports.parse = function () { return dism.parse.apply(dism, arguments); }
exports.main = function commonjsMain(args) {
    if (!args[1])
        throw new Error('Usage: '+args[0]+' FILE');
    if (typeof process !== 'undefined') {
        var source = require('fs').readFileSync(require('path').join(process.cwd(), args[1]), "utf8");
    } else {
        var cwd = require("file").path(require("file").cwd());
        var source = cwd.join(args[1]).read({charset: "utf-8"});
    }
    return exports.parser.parse(source);
}
if (typeof module !== 'undefined' && require.main === module) {
  exports.main(typeof process !== 'undefined' ? process.argv.slice(1) : require("system").args);
}
}