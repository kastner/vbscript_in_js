VBScript in JavaScript
======================

This is an attempt to write a VBScript parser in JS.
The output is also JavaScript.

It's far from compelete, but it does compile the `.vbs` files.

View the live demo: [kastner.github.com/vbscript_in_js/](http://kastner.github.com/vbscript_in_js/)

How
---

Here's what's worked for me... YMMV:

  * use [node](http://nodejs.org) v0.6.2 or higher
  * use [npm](http://npmjs.org/) (`curl http://npmjs.org/install.sh | sh`)
  * install jison: `npm install jison -g`
  * compile and run: `jison vbs4.jison && node run.js test3.vbs`


What
----

VBScript -> JS compiler, using the amazing [jison](http://jison.org) project.

This is my first time playing with a formal language definition. It's not pretty ;)


Why
---

I suggested that someone port their old, giant IE6 only application to modern browsers by simply, "writing a VBScript interpreter in JS".
That got me thinking about how hard it would be (hint: I vastly underestimated the complexity).

This project is the result of me hacking around with that idea for the past few days here and there.


When
----

Seriously, calling this abondon-ware is being kind. This is a **hack**, pure-and-simple. If someone wanted to run with it, be my guest, but don't expect it to do anything useful in it's current state.


In a Perfect World
------------------

This wouldn't even be needed, since VBScript would never have been used in client browsers. Baring that, here's what I imagine this project would look like if it had some attention given to it:

  * a standard lib of VBScript functions (like inStr - most likely in JS)
  * a way to _automatically_ run in modern browsers
    * auto-detection and parsing of `<script language='VBScript'>` tags (much like [CoffeeScript](http://coffeescript.org))
    * auto DOM manipulation / access (`foo_onClick`, etc.)
    * inline handlers working somehow?


Example
-------

given this VBScript input:

```
Set oOldSort = Nothing

Sub ChangeSort(oSortField, oField)
  If TypeName(oOldSort) = "HTMLSpanElement" Then
    oOldSort.className = "smallestblack"
  End If

  If oSortField Is Nothing Then
    frmSearch.Sort.value = ""
  Else
    oSortField.className = "smallestred"
    Set oOldSort = oSortField
    If oField.Name = "LocType" Then
      frmSearch.Sort.value = "Type"
    Else
      frmSearch.Sort.value = oField.Name
    End If
  End If
End Sub

```

this is the javascript that is produced:

```javascript
(function () {
  oOldSort = null;
  function ChangeSort (oSortField, oField) {
    if (TypeName(oOldSort) = "HTMLSpanElement") {
      oOldSort.className = "smallestblack";
    }
    if (oSortField == null) {
      frmSearch.Sort.value = "";
    } else {
      oSortField.className = "smallestred";
      oOldSort = oSortField;
      if (oField.Name = "LocType") {
        frmSearch.Sort.value = "Type";
      } else {
        frmSearch.Sort.value = oField.Name;
      }
    }
  }
})();
```
