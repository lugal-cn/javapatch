(function(){function f(a,b){var g;try{g=a.getSelection().getRanges()[0]}catch(c){return null}g.shrink(CKEDITOR.SHRINK_TEXT);return a.elementPath(g.getCommonAncestor()).contains(b,1)}function h(a,b){var g=a.lang.liststyle;if("bulletedListStyle"==b){return{title:g.bulletedTitle,minWidth:300,minHeight:50,contents:[{id:"info",accessKey:"I",elements:[{type:"select",label:g.type,id:"type",align:"center",style:"width:150px",items:[[g.notset,""],[g.circle,"circle"],[g.disc,"disc"],[g.square,"square"]],setup:function(i){this.setValue(i.getStyle("list-style-type")||e[i.getAttribute("type")]||i.getAttribute("type")||"")},commit:function(i){var k=this.getValue();k?i.setStyle("list-style-type",k):i.removeStyle("list-style-type")}}]}],onShow:function(){var i=this.getParentEditor();(i=f(i,"ul"))&&this.setupContent(i)},onOk:function(){var i=this.getParentEditor();(i=f(i,"ul"))&&this.commitContent(i)}}}if("numberedListStyle"==b){var c=[[g.notset,""],[g.lowerRoman,"lower-roman"],[g.upperRoman,"upper-roman"],[g.lowerAlpha,"lower-alpha"],[g.upperAlpha,"upper-alpha"],[g.decimal,"decimal"]];(!CKEDITOR.env.ie||7<CKEDITOR.env.version)&&c.concat([[g.armenian,"armenian"],[g.decimalLeadingZero,"decimal-leading-zero"],[g.georgian,"georgian"],[g.lowerGreek,"lower-greek"]]);return{title:g.numberedTitle,minWidth:300,minHeight:50,contents:[{id:"info",accessKey:"I",elements:[{type:"hbox",widths:["25%","75%"],children:[{label:g.start,type:"text",id:"start",validate:CKEDITOR.dialog.validate.integer(g.validateStartNumber),setup:function(i){this.setValue(i.getFirst(d).getAttribute("value")||i.getAttribute("start")||1)},commit:function(n){var o=n.getFirst(d),i=o.getAttribute("value")||n.getAttribute("start")||1;n.getFirst(d).removeAttribute("value");var m=parseInt(this.getValue(),10);isNaN(m)?n.removeAttribute("start"):n.setAttribute("start",m);n=o;o=i;for(m=isNaN(m)?1:m;(n=n.getNext(d))&&o++;){n.getAttribute("value")==o&&n.setAttribute("value",m+o-i)}}},{type:"select",label:g.type,id:"type",style:"width: 100%;",items:c,setup:function(i){this.setValue(i.getStyle("list-style-type")||e[i.getAttribute("type")]||i.getAttribute("type")||"")},commit:function(i){var k=this.getValue();k?i.setStyle("list-style-type",k):i.removeStyle("list-style-type")}}]}]}],onShow:function(){var i=this.getParentEditor();(i=f(i,"ol"))&&this.setupContent(i)},onOk:function(){var i=this.getParentEditor();(i=f(i,"ol"))&&this.commitContent(i)}}}}var d=function(a){return a.type==CKEDITOR.NODE_ELEMENT&&a.is("li")},e={a:"lower-alpha",A:"upper-alpha",i:"lower-roman",I:"upper-roman",1:"decimal",disc:"disc",circle:"circle",square:"square"};CKEDITOR.dialog.add("numberedListStyle",function(a){return h(a,"numberedListStyle")});CKEDITOR.dialog.add("bulletedListStyle",function(a){return h(a,"bulletedListStyle")})})();