a = [ 
      { obj_expr: null, identifier: '4', args: [] },
      [ 
        { obj_expr: null, identifier: '0', args: [] }, 
        { obj_expr: null, identifier: '3', args: [] } 
      ],
      [ 
        [ 
          { obj_expr: null, identifier: '0', args: [] }, 
          { obj_expr: null, identifier: '3', args: [] } 
        ]
      ] 
    ];

function flatten(array) {
  var ret = [];
  function inner_flatten(a2) {
    if (!a2.length) {
      ret.push(a2);
    } else {
      for (var i=0; i<a2.length; i++) {
        if (!a2[i].length) {
          ret.push(a2[i]);
        } else {
          inner_flatten(a2[i]);
        }
      }
    }
  }

  inner_flatten(array);
  return ret;
}

var a2 = flatten(a);
a2.forEach(function(i,j) { console.log(i.identifier); })
