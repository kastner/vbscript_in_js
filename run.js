var util = require('util');
var parser = require('./vbs4').parser;
var source = require('fs').readFileSync(process.argv[2], 'utf8');
//console.log(source);

var ast = parser.parse(source);
//console.log(util.inspect(ast, false, null));

var Node = function (_node) {
  var self = this;
  self.node = _node;

  self.compile = function () {
    throw "Not implemented (node type: " + self.node.type + ")";
  }

  self.toString = function () {
    return this.node.type;
  }

  self.compileChildren = function (childKind) {
    var children = this.node[childKind].map(function (node) { return (new Node(node)).compile(); });
    return children;
  }

  if (Nodes[self.node.type]) {
    self = Nodes[self.node.type](self);
  }

  return self;
};

var Nodes = {
  "Call": function (self) {
    self.compile = function () {
      var args = self.node.arguments.map(function (argument) { var a = new Node(argument); return a.compile(); });
      return "VBS['" + self.node.name+ "'](" + args.join(",") + ");";
    }
    return self;
  },

  "Conditional": function (self) {
    self.compile = function () {
      return "(" + self.node.first + " " + self.node.compare + " " + self.node.second + ")";
    }
  },

  "IfElse": function (self) {
    self.compile = function () {
      var body = self.compileChildren.apply(self, ['body']);
      var else_body = self.compileChildren.apply(self, ['else_body']);
      var conditional = (new Node(self.node.condition)).compile();
      return [
        "if " + conditional + " {",
        "  " + body,
        "} else {",
        "  " + else_body,
        "}"
      ].join("\n");
    }
  },

  "Function": function (self) {
    self.compile = function () {
      var func_name = self.node.name;
      var args = self.node.arguments.map(function (argument) { var a = new Node(argument); return a.compile(); });
      var fun_body = self.compileChildren('body');
      fun_body += "if (typeof " + func_name + " !== 'undefined') { return " + func_name + "; }";
      return "VBS['" + func_name + "'] = function (" + args.join(", ") + ") {\n" + fun_body + "}";
    }
    return self;
  },

  "Argument": function (self) {
    self.compile = function () {
      return self.node.value.toString();
    }
    return self;
  },

  "Assignment": function (self) {
    self.compile = function () {
      return self.node.name + " = " + self.node.value + ";"
    }
  }
};

var prg = (new Node(ast)).compileChildren('body').join("\n");
//var prg = new Node(ast.body[1]).compile();
console.log(prg);

// The namespace
var VBS = {};
console.log(eval(prg));
