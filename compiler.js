var compiler = (function () {
  return {
    "compile": function (source, parser) {
      var ast = parser.parse(source);

      var Node = function (_node) {
        var self = this;
        self.node = _node;

        self.compile = function (opts) {
          throw "Not implemented (node type: " + self.node.type + ")";
        }

        self.toString = function () {
          return this.node.type;
        }

        self.compileChildren = function (childKind, opts) {
          opts.indent += 1;
          var children = this.node[childKind].map(function (node) { 
            return indent(opts.indent) + (new Node(node)).compile(opts);
          });
          opts.indent -= 1;
          return children;
        }

        if (Nodes[self.node.type]) {
          self = Nodes[self.node.type](self);
        }

        return self;
      };

      var Nodes = {
        "Call": function (self) {
          self.compile = function (opts) {
            var ret = "";
            if (self.node.arguments) {
              var args = self.node.arguments.map(function (argument) { var a = new Node(argument); return a.compile(opts); });
              ret = self.node.name + "(" + args.join(",") + ")";
            } else {
              ret = self.node.name;
            }

            if (self.node.bare_call) {
              ret += ";";
            }
            return ret;
          }
          return self;
        },

        "Conditional": function (self) {
          self.compile = function (opts) {
            var first = (new Node(self.node.first)).compile(opts);
            var second = (new Node(self.node.second)).compile(opts);
            return "(" + first + " " + self.node.compare + " " + second + ")";
          }
        },

        "If": function (self) {
          self.compile = function (opts) {
            var body = self.compileChildren.apply(self, ['body', opts]).join("\n");
            var else_body;
            if (self.node.else_body) {
              var else_body = self.compileChildren.apply(self, ['else_body', opts]).join("\n");
            }
            var conditional = (new Node(self.node.condition)).compile(opts);
            var ret = "if " + conditional + " {\n" + body;
            if (self.node.else_body) {
              ret += "\n" + indent(opts.indent) + "} else {\n" + else_body;
            }
            ret += "\n" + indent(opts.indent) + "}";
            return ret;
          }
        },

        "Function": function (self) {
          self.compile = function (opts) {
            var func_name = self.node.name;
            var args = self.node.arguments.map(function (argument) { var a = new Node(argument); return a.compile(opts); });
            var fun_body = self.compileChildren('body', opts).join("\n");
            if (self.node.sub_type == 'Function') {
              fun_body += "\n" + indent(opts.indent + 1) + "if (typeof " + func_name + " !== 'undefined') { return " + func_name + "; }";
            }
            return "function " + func_name + " (" + args.join(", ") + ") {\n" + fun_body + "\n" + indent(opts.indent) + "}";
          }
          return self;
        },

        "Argument": function (self) {
          self.compile = function (opts) {
            return self.node.value.toString();
          }
          return self;
        },

        "Assignment": function (self) {
          self.compile = function (opts) {
            return self.node.name + " = " + self.node.value + ";";
          }
        },

        "String": function (self) {
          self.compile = function (opts) {
            return self.node.value;
          }
        }
      };

      function indent(level) {
        return (new Array(level+1).join("  "));
      }

      var prg = (new Node(ast)).compileChildren('body', {indent: -1}).join("\n");
      //prg = "(function () {\n" + prg + "\n})();"; /* wrap everything in an anonymous function */
      return prg;
    }
  }
})();

if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
  exports.compiler = compiler;
  exports.compile = function () { return compiler.compile.apply(compiler, arguments); }
}
