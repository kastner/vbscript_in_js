/* Jison generated parser */
var vbs4 = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"program":3,"statement_list":4,"EOF":5,"statement_line":6,"statement":7,"NEWLINE":8,"STRING":9,"function":10,"if_statement":11,"if_else_statement":12,"assignment":13,"call_statement":14,"function_or_sub":15,"member_access":16,"arguments":17,"END":18,"FUNCTION":19,"SUB":20,"IF":21,"conditional":22,"THEN":23,"ELSE":24,"comparable":25,"compare":26,">":27,"<":28,">=":29,"<=":30,"=":31,"IS":32,"CALL":33,".":34,"IDENTIFIER":35,"member_access_or_string":36,"SET":37,"EMPTYBRACKETS":38,"(":39,"argument_list":40,")":41,"argument":42,",":43,"$accept":0,"$end":1},
terminals_: {2:"error",5:"EOF",8:"NEWLINE",9:"STRING",18:"END",19:"FUNCTION",20:"SUB",21:"IF",23:"THEN",24:"ELSE",27:">",28:"<",29:">=",30:"<=",31:"=",32:"IS",33:"CALL",34:".",35:"IDENTIFIER",37:"SET",38:"EMPTYBRACKETS",39:"(",41:")",43:","},
productions_: [0,[3,2],[4,1],[4,2],[6,2],[7,1],[7,1],[7,1],[7,1],[7,1],[7,1],[10,7],[15,1],[15,1],[11,7],[12,10],[22,3],[25,1],[25,1],[25,1],[26,1],[26,1],[26,1],[26,1],[26,1],[26,1],[14,2],[14,3],[16,3],[16,1],[36,1],[36,1],[13,4],[13,3],[17,1],[17,3],[40,0],[40,1],[40,3],[42,1],[42,1]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
case 1: return { type:'Program', body: $$[$0-1] }; 
break;
case 2: this.$ = [$$[$0]]; 
break;
case 3: 
      if ($$[$0-1]['push']) {
        $$[$0-1].push($$[$0]);
        this.$ = $$[$0-1];
      } else {
        console.log("So... statement_list isn't cool... let's see what it is");
        console.log($$[$0-1]);
        //console.log($$[$0]);
        var tmp = [$$[$0-1]];
        tmp.push($$[$0]);
        this.$ = tmp;
      }
    //this.$ = $$[$0-1].concat($$[$01]); 
    
break;
case 11: this.$ = { type: 'Function', sub_type: $$[$0-6], name: $$[$0-5], arguments: $$[$0-4], body: $$[$0-2] }; 
break;
case 14: this.$ = { type: 'If', condition: $$[$0-5], body: $$[$0-2]}; 
break;
case 15: this.$ = { type: 'If', condition: $$[$0-8], body: $$[$0-5], else_body: $$[$0-2]}; 
break;
case 16: this.$ = { type: 'Conditional', first: $$[$0-2], second: $$[$0], compare: $$[$0-1]}; 
break;
case 17: this.$ = { type: 'Call', blah: "fooo", name: $$[$0], arguments: null}; 
break;
case 19: this.$ = { type: 'String', value: $$[$0] }; 
break;
case 25: this.$ = '=='; 
break;
case 26: this.$ = { type: 'Call', name: $$[$0-1], arguments: $$[$0] }; 
break;
case 27: this.$ = { type: 'Call', bare_call: true, name: $$[$0-1], arguments: $$[$0] }; 
break;
case 28: this.$ = $$[$0-2] + "." + $$[$0]; 
break;
case 32: this.$ = { type: 'Assignment', name: $$[$0-2], value: $$[$0] }; 
break;
case 33: this.$ = { type: 'Assignment', name: $$[$0-2], value: $$[$0] }; 
break;
case 35: this.$ = $$[$0-1]; 
break;
case 36: this.$ = []; 
break;
case 37: this.$ = [$$[$0]]; 
break;
case 38: this.$ = $$[$0-2].concat($$[$0]); 
break;
case 39: this.$ = {type: 'Argument', value: $$[$0] }; 
break;
case 40: this.$ = {type: 'Argument', value: $$[$0] }; 
break;
}
},
table: [{3:1,4:2,6:3,7:4,9:[1,5],10:6,11:7,12:8,13:9,14:10,15:11,16:14,19:[1,16],20:[1,17],21:[1,12],33:[1,15],35:[1,18],37:[1,13]},{1:[3]},{5:[1,19],6:20,7:4,9:[1,5],10:6,11:7,12:8,13:9,14:10,15:11,16:14,19:[1,16],20:[1,17],21:[1,12],33:[1,15],35:[1,18],37:[1,13]},{5:[2,2],9:[2,2],18:[2,2],19:[2,2],20:[2,2],21:[2,2],24:[2,2],33:[2,2],35:[2,2],37:[2,2]},{8:[1,21]},{8:[2,5]},{8:[2,6]},{8:[2,7]},{8:[2,8]},{8:[2,9]},{8:[2,10]},{16:22,35:[1,18]},{9:[1,27],14:26,16:25,22:23,25:24,33:[1,15],35:[1,18]},{16:28,35:[1,18]},{17:30,31:[1,29],34:[1,31],38:[1,32],39:[1,33]},{16:34,35:[1,18]},{8:[2,12],35:[2,12]},{8:[2,13],35:[2,13]},{8:[2,29],23:[2,29],27:[2,29],28:[2,29],29:[2,29],30:[2,29],31:[2,29],32:[2,29],34:[2,29],38:[2,29],39:[2,29]},{1:[2,1]},{5:[2,3],9:[2,3],18:[2,3],19:[2,3],20:[2,3],21:[2,3],24:[2,3],33:[2,3],35:[2,3],37:[2,3]},{5:[2,4],9:[2,4],18:[2,4],19:[2,4],20:[2,4],21:[2,4],24:[2,4],33:[2,4],35:[2,4],37:[2,4]},{17:35,34:[1,31],38:[1,32],39:[1,33]},{23:[1,36]},{26:37,27:[1,38],28:[1,39],29:[1,40],30:[1,41],31:[1,42],32:[1,43]},{17:30,23:[2,17],27:[2,17],28:[2,17],29:[2,17],30:[2,17],31:[2,17],32:[2,17],34:[1,31],38:[1,32],39:[1,33]},{23:[2,18],27:[2,18],28:[2,18],29:[2,18],30:[2,18],31:[2,18],32:[2,18]},{23:[2,19],27:[2,19],28:[2,19],29:[2,19],30:[2,19],31:[2,19],32:[2,19]},{31:[1,44],34:[1,31]},{9:[1,47],16:46,35:[1,18],36:45},{8:[2,26],23:[2,26],27:[2,26],28:[2,26],29:[2,26],30:[2,26],31:[2,26],32:[2,26]},{35:[1,48]},{8:[2,34],23:[2,34],27:[2,34],28:[2,34],29:[2,34],30:[2,34],31:[2,34],32:[2,34]},{9:[1,52],35:[1,51],40:49,41:[2,36],42:50,43:[2,36]},{17:53,34:[1,31],38:[1,32],39:[1,33]},{8:[1,54]},{8:[1,55]},{9:[1,27],14:26,16:25,25:56,33:[1,15],35:[1,18]},{9:[2,20],33:[2,20],35:[2,20]},{9:[2,21],33:[2,21],35:[2,21]},{9:[2,22],33:[2,22],35:[2,22]},{9:[2,23],33:[2,23],35:[2,23]},{9:[2,24],33:[2,24],35:[2,24]},{9:[2,25],33:[2,25],35:[2,25]},{9:[1,47],16:46,35:[1,18],36:57},{8:[2,33]},{8:[2,30],34:[1,31]},{8:[2,31]},{8:[2,28],23:[2,28],27:[2,28],28:[2,28],29:[2,28],30:[2,28],31:[2,28],32:[2,28],34:[2,28],38:[2,28],39:[2,28]},{41:[1,58],43:[1,59]},{41:[2,37],43:[2,37]},{41:[2,39],43:[2,39]},{41:[2,40],43:[2,40]},{8:[2,27],23:[2,27],27:[2,27],28:[2,27],29:[2,27],30:[2,27],31:[2,27],32:[2,27]},{4:60,6:3,7:4,9:[1,5],10:6,11:7,12:8,13:9,14:10,15:11,16:14,19:[1,16],20:[1,17],21:[1,12],33:[1,15],35:[1,18],37:[1,13]},{4:61,6:3,7:4,9:[1,5],10:6,11:7,12:8,13:9,14:10,15:11,16:14,19:[1,16],20:[1,17],21:[1,12],33:[1,15],35:[1,18],37:[1,13]},{23:[2,16]},{8:[2,32]},{8:[2,35],23:[2,35],27:[2,35],28:[2,35],29:[2,35],30:[2,35],31:[2,35],32:[2,35]},{9:[1,52],35:[1,51],42:62},{6:20,7:4,9:[1,5],10:6,11:7,12:8,13:9,14:10,15:11,16:14,18:[1,63],19:[1,16],20:[1,17],21:[1,12],33:[1,15],35:[1,18],37:[1,13]},{6:20,7:4,9:[1,5],10:6,11:7,12:8,13:9,14:10,15:11,16:14,18:[1,64],19:[1,16],20:[1,17],21:[1,12],24:[1,65],33:[1,15],35:[1,18],37:[1,13]},{41:[2,38],43:[2,38]},{15:66,19:[1,16],20:[1,17]},{21:[1,67]},{8:[1,68]},{8:[2,11]},{8:[2,14]},{4:69,6:3,7:4,9:[1,5],10:6,11:7,12:8,13:9,14:10,15:11,16:14,19:[1,16],20:[1,17],21:[1,12],33:[1,15],35:[1,18],37:[1,13]},{6:20,7:4,9:[1,5],10:6,11:7,12:8,13:9,14:10,15:11,16:14,18:[1,70],19:[1,16],20:[1,17],21:[1,12],33:[1,15],35:[1,18],37:[1,13]},{21:[1,71]},{8:[2,15]}],
defaultActions: {5:[2,5],6:[2,6],7:[2,7],8:[2,8],9:[2,9],10:[2,10],19:[2,1],45:[2,33],47:[2,31],56:[2,16],57:[2,32],66:[2,11],67:[2,14],71:[2,15]},
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
/* Jison generated lexer */
var lexer = (function(){
var lexer = ({EOF:1,
parseError:function parseError(str, hash) {
        if (this.yy.parseError) {
            this.yy.parseError(str, hash);
        } else {
            throw new Error(str);
        }
    },
setInput:function (input) {
        this._input = input;
        this._more = this._less = this.done = false;
        this.yylineno = this.yyleng = 0;
        this.yytext = this.matched = this.match = '';
        this.conditionStack = ['INITIAL'];
        this.yylloc = {first_line:1,first_column:0,last_line:1,last_column:0};
        return this;
    },
input:function () {
        var ch = this._input[0];
        this.yytext+=ch;
        this.yyleng++;
        this.match+=ch;
        this.matched+=ch;
        var lines = ch.match(/\n/);
        if (lines) this.yylineno++;
        this._input = this._input.slice(1);
        return ch;
    },
unput:function (ch) {
        this._input = ch + this._input;
        return this;
    },
more:function () {
        this._more = true;
        return this;
    },
pastInput:function () {
        var past = this.matched.substr(0, this.matched.length - this.match.length);
        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\n/g, "");
    },
upcomingInput:function () {
        var next = this.match;
        if (next.length < 20) {
            next += this._input.substr(0, 20-next.length);
        }
        return (next.substr(0,20)+(next.length > 20 ? '...':'')).replace(/\n/g, "");
    },
showPosition:function () {
        var pre = this.pastInput();
        var c = new Array(pre.length + 1).join("-");
        return pre + this.upcomingInput() + "\n" + c+"^";
    },
next:function () {
        if (this.done) {
            return this.EOF;
        }
        if (!this._input) this.done = true;

        var token,
            match,
            tempMatch,
            index,
            col,
            lines;
        if (!this._more) {
            this.yytext = '';
            this.match = '';
        }
        var rules = this._currentRules();
        for (var i=0;i < rules.length; i++) {
            tempMatch = this._input.match(this.rules[rules[i]]);
            if (tempMatch && (!match || tempMatch[0].length > match[0].length)) {
                match = tempMatch;
                index = i;
                if (!this.options.flex) break;
            }
        }
        if (match) {
            lines = match[0].match(/\n.*/g);
            if (lines) this.yylineno += lines.length;
            this.yylloc = {first_line: this.yylloc.last_line,
                           last_line: this.yylineno+1,
                           first_column: this.yylloc.last_column,
                           last_column: lines ? lines[lines.length-1].length-1 : this.yylloc.last_column + match[0].length}
            this.yytext += match[0];
            this.match += match[0];
            this.yyleng = this.yytext.length;
            this._more = false;
            this._input = this._input.slice(match[0].length);
            this.matched += match[0];
            token = this.performAction.call(this, this.yy, this, rules[index],this.conditionStack[this.conditionStack.length-1]);
            if (token) return token;
            else return;
        }
        if (this._input === "") {
            return this.EOF;
        } else {
            this.parseError('Lexical error on line '+(this.yylineno+1)+'. Unrecognized text.\n'+this.showPosition(), 
                    {text: "", token: null, line: this.yylineno});
        }
    },
lex:function lex() {
        var r = this.next();
        if (typeof r !== 'undefined') {
            return r;
        } else {
            return this.lex();
        }
    },
begin:function begin(condition) {
        this.conditionStack.push(condition);
    },
popState:function popState() {
        return this.conditionStack.pop();
    },
_currentRules:function _currentRules() {
        return this.conditions[this.conditionStack[this.conditionStack.length-1]].rules;
    },
topState:function () {
        return this.conditionStack[this.conditionStack.length-2];
    },
pushState:function begin(condition) {
        this.begin(condition);
    }});
lexer.options = {};
lexer.performAction = function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {

var YYSTATE=YY_START
switch($avoiding_name_collisions) {
case 0: return 8; 
break;
case 1: /* skip whitespace */ 
break;
case 2: return 33; 
break;
case 3: return 33; 
break;
case 4: return 19; 
break;
case 5: return 20; 
break;
case 6: return 21; 
break;
case 7: return 23; 
break;
case 8: return 24; 
break;
case 9: return 32; 
break;
case 10: return 18; 
break;
case 11: return 37; 
break;
case 12: return yy_.yytext; 
break;
case 13: yy_.yytext = 'null'; return 35; 
break;
case 14: return 9; 
break;
case 15: return 38; 
break;
case 16: return yy_.yytext; 
break;
case 17: return 35; 
break;
case 18: return 5; 
break;
}
};
lexer.rules = [/^\n+/,/^[ \t]+/,/^Call\b/,/^call\b/,/^Function\b/,/^Sub\b/,/^If\b/,/^Then\b/,/^Else\b/,/^Is\b/,/^End\b/,/^Set\b/,/^MOD\b/,/^Nothing\b/,/^L?"(\\.|[^\\"])*"/,/^\(\)/,/^[<>\(\)=,\.]/,/^\w+/,/^$/];
lexer.conditions = {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18],"inclusive":true}};
return lexer;})()
parser.lexer = lexer;
return parser;
})();
if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = vbs4;
exports.parse = function () { return vbs4.parse.apply(vbs4, arguments); }
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