(function(){var b=function(a,i){function r(){var d=arguments,e=this.getContentElement("advanced","txtdlgGenStyle");e&&e.commit.apply(e,d);this.foreach(function(A){A.commit&&"txtdlgGenStyle"!=A.id&&A.commit.apply(A,d)})}function h(C){if(!s){s=1;var D=this.getDialog(),e=D.imageElement;if(e){this.commit(c,e);for(var C=[].concat(C),A=C.length,d,B=0;B<A;B++){(d=D.getContentElement.apply(D,C[B].split(":")))&&d.setup(c,e)}}s=0}}var c=1,j=/^\s*(\d+)((px)|\%)?\s*$/i,v=/(^\s*(\d+)((px)|\%)?\s*$)|^$/i,n=/^\d+px$/,w=function(){var e=this.getValue(),A=this.getDialog(),d=e.match(j);d&&("%"==d[2]&&k(A,!1),e=d[1]);A.lockRatio&&(d=A.originalElement,"true"==d.getCustomData("isReady")&&("txtHeight"==this.id?(e&&"0"!=e&&(e=Math.round(d.$.width*(e/d.$.height))),isNaN(e)||A.setValueOf("info","txtWidth",e)):(e&&"0"!=e&&(e=Math.round(d.$.height*(e/d.$.width))),isNaN(e)||A.setValueOf("info","txtHeight",e))));f(A)},f=function(d){if(!d.originalElement||!d.preview){return 1}d.commitContent(4,d.preview);return 0},s,k=function(C,D){if(!C.getContentElement("info","ratioLock")){return null}var e=C.originalElement;if(!e){return null}if("check"==D){if(!C.userlockRatio&&"true"==e.getCustomData("isReady")){var A=C.getValueOf("info","txtWidth"),d=C.getValueOf("info","txtHeight"),e=1000*e.$.width/e.$.height,B=1000*A/d;C.lockRatio=!1;!A&&!d?C.lockRatio=!0:!isNaN(e)&&!isNaN(B)&&Math.round(e)==Math.round(B)&&(C.lockRatio=!0)}}else{void 0!=D?C.lockRatio=D:(C.userlockRatio=1,C.lockRatio=!C.lockRatio)}A=CKEDITOR.document.getById(o);C.lockRatio?A.removeClass("cke_btn_unlocked"):A.addClass("cke_btn_unlocked");A.setAttribute("aria-checked",C.lockRatio);CKEDITOR.env.hc&&A.getChild(0).setHtml(C.lockRatio?CKEDITOR.env.ie?"■":"▣":CKEDITOR.env.ie?"□":"▢");return C.lockRatio},x=function(A){var B=A.originalElement;if("true"==B.getCustomData("isReady")){var d=A.getContentElement("info","txtWidth"),e=A.getContentElement("info","txtHeight");d&&d.setValue(B.$.width);e&&e.setValue(B.$.height)}f(A)},y=function(C,D){function d(G,H){var F=G.match(j);return F?("%"==F[2]&&(F[1]+="%",k(e,!1)),F[1]):H}if(C==c){var e=this.getDialog(),E="",A="txtWidth"==this.id?"width":"height",B=D.getAttribute(A);B&&(E=d(B,E));E=d(D.getStyle(A),E);this.setValue(E)}},t,q=function(){var d=this.originalElement;d.setCustomData("isReady","true");d.removeListener("load",q);d.removeListener("error",g);d.removeListener("abort",g);CKEDITOR.document.getById(l).setStyle("display","none");this.dontResetSize||x(this);this.firstLoad&&CKEDITOR.tools.setTimeout(function(){k(this,"check")},0,this);this.dontResetSize=this.firstLoad=!1},g=function(){var d=this.originalElement;d.removeListener("load",q);d.removeListener("error",g);d.removeListener("abort",g);d=CKEDITOR.getUrl(CKEDITOR.plugins.get("image").path+"images/noimage.png");this.preview&&this.preview.setAttribute("src",d);CKEDITOR.document.getById(l).setStyle("display","none");k(this,!1)},m=function(d){return CKEDITOR.tools.getNextId()+"_"+d},o=m("btnLockSizes"),u=m("btnResetSize"),l=m("ImagePreviewLoader"),p=m("previewLink"),z=m("previewImage");return{title:a.lang.image["image"==i?"title":"titleButton"],minWidth:420,minHeight:360,onShow:function(){this.linkEditMode=this.imageEditMode=this.linkElement=this.imageElement=!1;this.lockRatio=!0;this.userlockRatio=0;this.dontResetSize=!1;this.firstLoad=!0;this.addLink=!1;var B=this.getParentEditor(),C=B.getSelection(),e=(C=C&&C.getSelectedElement())&&B.elementPath(C).contains("a",1);CKEDITOR.document.getById(l).setStyle("display","none");t=new CKEDITOR.dom.element("img",B.document);this.preview=CKEDITOR.document.getById(z);this.originalElement=B.document.createElement("img");this.originalElement.setAttribute("alt","");this.originalElement.setCustomData("isReady","false");if(e){this.linkElement=e;this.linkEditMode=!0;var d=e.getChildren();if(1==d.count()){var A=d.getItem(0).getName();if("img"==A||"input"==A){this.imageElement=d.getItem(0),"img"==this.imageElement.getName()?this.imageEditMode="img":"input"==this.imageElement.getName()&&(this.imageEditMode="input")}}"image"==i&&this.setupContent(2,e)}if(C&&"img"==C.getName()&&!C.data("cke-realelement")||C&&"input"==C.getName()&&"image"==C.getAttribute("type")){this.imageEditMode=C.getName(),this.imageElement=C}this.imageEditMode?(this.cleanImageElement=this.imageElement,this.imageElement=this.cleanImageElement.clone(!0,!0),this.setupContent(c,this.imageElement)):this.imageElement=B.document.createElement("img");k(this,!0);CKEDITOR.tools.trim(this.getValueOf("info","txtUrl"))||(this.preview.removeAttribute("src"),this.preview.setStyle("display","none"))},onOk:function(){if(this.imageEditMode){var d=this.imageEditMode;"image"==i&&"input"==d&&confirm(a.lang.image.button2Img)?(this.imageElement=a.document.createElement("img"),this.imageElement.setAttribute("alt",""),a.insertElement(this.imageElement)):"image"!=i&&"img"==d&&confirm(a.lang.image.img2Button)?(this.imageElement=a.document.createElement("input"),this.imageElement.setAttributes({type:"image",alt:""}),a.insertElement(this.imageElement)):(this.imageElement=this.cleanImageElement,delete this.cleanImageElement)}else{"image"==i?this.imageElement=a.document.createElement("img"):(this.imageElement=a.document.createElement("input"),this.imageElement.setAttribute("type","image")),this.imageElement.setAttribute("alt","")}this.linkEditMode||(this.linkElement=a.document.createElement("a"));this.commitContent(c,this.imageElement);this.commitContent(2,this.linkElement);this.imageElement.getAttribute("style")||this.imageElement.removeAttribute("style");this.imageEditMode?!this.linkEditMode&&this.addLink?(a.insertElement(this.linkElement),this.imageElement.appendTo(this.linkElement)):this.linkEditMode&&!this.addLink&&(a.getSelection().selectElement(this.linkElement),a.insertElement(this.imageElement)):this.addLink?this.linkEditMode?a.insertElement(this.imageElement):(a.insertElement(this.linkElement),this.linkElement.append(this.imageElement,!1)):a.insertElement(this.imageElement)},onLoad:function(){"image"!=i&&this.hidePage("Link");var d=this._.element.getDocument();this.getContentElement("info","ratioLock")&&(this.addFocusable(d.getById(u),5),this.addFocusable(d.getById(o),5));this.commitContent=r},onHide:function(){this.preview&&this.commitContent(8,this.preview);this.originalElement&&(this.originalElement.removeListener("load",q),this.originalElement.removeListener("error",g),this.originalElement.removeListener("abort",g),this.originalElement.remove(),this.originalElement=!1);delete this.imageElement},contents:[{id:"info",label:a.lang.image.infoTab,accessKey:"I",elements:[{type:"vbox",padding:0,children:[{type:"hbox",widths:["280px","110px"],align:"right",children:[{id:"txtUrl",type:"text",label:a.lang.common.url,required:!0,onChange:function(){var A=this.getDialog(),B=this.getValue();if(0<B.length){var A=this.getDialog(),e=A.originalElement;A.preview.removeStyle("display");e.setCustomData("isReady","false");var d=CKEDITOR.document.getById(l);d&&d.setStyle("display","");e.on("load",q,A);e.on("error",g,A);e.on("abort",g,A);e.setAttribute("src",B);t.setAttribute("src",B);A.preview.setAttribute("src",t.$.src);f(A)}else{A.preview&&(A.preview.removeAttribute("src"),A.preview.setStyle("display","none"))}},setup:function(e,A){if(e==c){var d=A.data("cke-saved-src")||A.getAttribute("src");this.getDialog().dontResetSize=!0;this.setValue(d);this.setInitValue()}},commit:function(d,e){d==c&&(this.getValue()||this.isChanged())?(e.data("cke-saved-src",this.getValue()),e.setAttribute("src",this.getValue())):8==d&&(e.setAttribute("src",""),e.removeAttribute("src"))},validate:CKEDITOR.dialog.validate.notEmpty(a.lang.image.urlMissing)},{type:"button",id:"browse",style:"display:inline-block;margin-top:10px;",align:"center",label:a.lang.common.browseServer,hidden:!0,filebrowser:"info:txtUrl"}]}]},{id:"txtAlt",type:"text",label:a.lang.image.alt,accessKey:"T","default":"",onChange:function(){f(this.getDialog())},setup:function(d,e){d==c&&this.setValue(e.getAttribute("alt"))},commit:function(d,e){d==c?(this.getValue()||this.isChanged())&&e.setAttribute("alt",this.getValue()):4==d?e.setAttribute("alt",this.getValue()):8==d&&e.removeAttribute("alt")}},{type:"hbox",children:[{id:"basic",type:"vbox",children:[{type:"hbox",requiredContent:"img{width,height}",widths:["50%","50%"],children:[{type:"vbox",padding:1,children:[{type:"text",width:"45px",id:"txtWidth",label:a.lang.common.width,onKeyUp:w,onChange:function(){h.call(this,"advanced:txtdlgGenStyle")},validate:function(){var d=this.getValue().match(v);(d=!!(d&&0!==parseInt(d[1],10)))||alert(a.lang.common.invalidWidth);return d},setup:y,commit:function(A,B,e){var d=this.getValue();A==c?(d?B.setStyle("width",CKEDITOR.tools.cssLength(d)):B.removeStyle("width"),!e&&B.removeAttribute("width")):4==A?d.match(j)?B.setStyle("width",CKEDITOR.tools.cssLength(d)):(A=this.getDialog().originalElement,"true"==A.getCustomData("isReady")&&B.setStyle("width",A.$.width+"px")):8==A&&(B.removeAttribute("width"),B.removeStyle("width"))}},{type:"text",id:"txtHeight",width:"45px",label:a.lang.common.height,onKeyUp:w,onChange:function(){h.call(this,"advanced:txtdlgGenStyle")},validate:function(){var d=this.getValue().match(v);(d=!!(d&&0!==parseInt(d[1],10)))||alert(a.lang.common.invalidHeight);return d},setup:y,commit:function(A,B,e){var d=this.getValue();A==c?(d?B.setStyle("height",CKEDITOR.tools.cssLength(d)):B.removeStyle("height"),!e&&B.removeAttribute("height")):4==A?d.match(j)?B.setStyle("height",CKEDITOR.tools.cssLength(d)):(A=this.getDialog().originalElement,"true"==A.getCustomData("isReady")&&B.setStyle("height",A.$.height+"px")):8==A&&(B.removeAttribute("height"),B.removeStyle("height"))}}]},{id:"ratioLock",type:"html",style:"margin-top:30px;width:40px;height:40px;",onLoad:function(){var d=CKEDITOR.document.getById(u),e=CKEDITOR.document.getById(o);d&&(d.on("click",function(A){x(this);A.data&&A.data.preventDefault()},this.getDialog()),d.on("mouseover",function(){this.addClass("cke_btn_over")},d),d.on("mouseout",function(){this.removeClass("cke_btn_over")},d));e&&(e.on("click",function(B){k(this);var C=this.originalElement,A=this.getValueOf("info","txtWidth");if(C.getCustomData("isReady")=="true"&&A){C=C.$.height/C.$.width*A;if(!isNaN(C)){this.setValueOf("info","txtHeight",Math.round(C));f(this)}}B.data&&B.data.preventDefault()},this.getDialog()),e.on("mouseover",function(){this.addClass("cke_btn_over")},e),e.on("mouseout",function(){this.removeClass("cke_btn_over")},e))},html:'<div><a href="javascript:void(0)" tabindex="-1" title="'+a.lang.image.lockRatio+'" class="cke_btn_locked" id="'+o+'" role="checkbox"><span class="cke_icon"></span><span class="cke_label">'+a.lang.image.lockRatio+'</span></a><a href="javascript:void(0)" tabindex="-1" title="'+a.lang.image.resetSize+'" class="cke_btn_reset" id="'+u+'" role="button"><span class="cke_label">'+a.lang.image.resetSize+"</span></a></div>"}]},{type:"vbox",padding:1,children:[{type:"text",id:"txtBorder",requiredContent:"img{border-width}",width:"60px",label:a.lang.image.border,"default":"",onKeyUp:function(){f(this.getDialog())},onChange:function(){h.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(a.lang.image.validateBorder),setup:function(e,A){if(e==c){var d;d=(d=(d=A.getStyle("border-width"))&&d.match(/^(\d+px)(?: \1 \1 \1)?$/))&&parseInt(d[1],10);isNaN(parseInt(d,10))&&(d=A.getAttribute("border"));this.setValue(d)}},commit:function(A,B,e){var d=parseInt(this.getValue(),10);A==c||4==A?(isNaN(d)?!d&&this.isChanged()&&B.removeStyle("border"):(B.setStyle("border-width",CKEDITOR.tools.cssLength(d)),B.setStyle("border-style","solid")),!e&&A==c&&B.removeAttribute("border")):8==A&&(B.removeAttribute("border"),B.removeStyle("border-width"),B.removeStyle("border-style"),B.removeStyle("border-color"))}},{type:"text",id:"txtHSpace",requiredContent:"img{margin-left,margin-right}",width:"60px",label:a.lang.image.hSpace,"default":"",onKeyUp:function(){f(this.getDialog())},onChange:function(){h.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(a.lang.image.validateHSpace),setup:function(A,B){if(A==c){var e,d;e=B.getStyle("margin-left");d=B.getStyle("margin-right");e=e&&e.match(n);d=d&&d.match(n);e=parseInt(e,10);d=parseInt(d,10);e=e==d&&e;isNaN(parseInt(e,10))&&(e=B.getAttribute("hspace"));this.setValue(e)}},commit:function(A,B,d){var e=parseInt(this.getValue(),10);A==c||4==A?(isNaN(e)?!e&&this.isChanged()&&(B.removeStyle("margin-left"),B.removeStyle("margin-right")):(B.setStyle("margin-left",CKEDITOR.tools.cssLength(e)),B.setStyle("margin-right",CKEDITOR.tools.cssLength(e))),!d&&A==c&&B.removeAttribute("hspace")):8==A&&(B.removeAttribute("hspace"),B.removeStyle("margin-left"),B.removeStyle("margin-right"))}},{type:"text",id:"txtVSpace",requiredContent:"img{margin-top,margin-bottom}",width:"60px",label:a.lang.image.vSpace,"default":"",onKeyUp:function(){f(this.getDialog())},onChange:function(){h.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(a.lang.image.validateVSpace),setup:function(A,B){if(A==c){var d,e;d=B.getStyle("margin-top");e=B.getStyle("margin-bottom");d=d&&d.match(n);e=e&&e.match(n);d=parseInt(d,10);e=parseInt(e,10);d=d==e&&d;isNaN(parseInt(d,10))&&(d=B.getAttribute("vspace"));this.setValue(d)}},commit:function(A,B,d){var e=parseInt(this.getValue(),10);A==c||4==A?(isNaN(e)?!e&&this.isChanged()&&(B.removeStyle("margin-top"),B.removeStyle("margin-bottom")):(B.setStyle("margin-top",CKEDITOR.tools.cssLength(e)),B.setStyle("margin-bottom",CKEDITOR.tools.cssLength(e))),!d&&A==c&&B.removeAttribute("vspace")):8==A&&(B.removeAttribute("vspace"),B.removeStyle("margin-top"),B.removeStyle("margin-bottom"))}},{id:"cmbAlign",requiredContent:"img{float}",type:"select",widths:["35%","65%"],style:"width:90px",label:a.lang.common.align,"default":"",items:[[a.lang.common.notSet,""],[a.lang.common.alignLeft,"left"],[a.lang.common.alignRight,"right"]],onChange:function(){f(this.getDialog());h.call(this,"advanced:txtdlgGenStyle")},setup:function(e,A){if(e==c){var d=A.getStyle("float");switch(d){case"inherit":case"none":d=""}!d&&(d=(A.getAttribute("align")||"").toLowerCase());this.setValue(d)}},commit:function(A,B,d){var e=this.getValue();if(A==c||4==A){if(e?B.setStyle("float",e):B.removeStyle("float"),!d&&A==c){switch(e=(B.getAttribute("align")||"").toLowerCase(),e){case"left":case"right":B.removeAttribute("align")}}}else{8==A&&B.removeStyle("float")}}}]}]},{type:"vbox",height:"250px",children:[{type:"html",id:"htmlPreview",style:"width:95%;",html:"<div>"+CKEDITOR.tools.htmlEncode(a.lang.common.preview)+'<br><div id="'+l+'" class="ImagePreviewLoader" style="display:none"><div class="loading">&nbsp;</div></div><div class="ImagePreviewBox"><table><tr><td><a href="javascript:void(0)" target="_blank" onclick="return false;" id="'+p+'"><img id="'+z+'" alt="" /></a>'+(a.config.image_previewText||"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas feugiat consequat diam. Maecenas metus. Vivamus diam purus, cursus a, commodo non, facilisis vitae, nulla. Aenean dictum lacinia tortor. Nunc iaculis, nibh non iaculis aliquam, orci felis euismod neque, sed ornare massa mauris sed velit. Nulla pretium mi et risus. Fusce mi pede, tempor id, cursus ac, ullamcorper nec, enim. Sed tortor. Curabitur molestie. Duis velit augue, condimentum at, ultrices a, luctus ut, orci. Donec pellentesque egestas eros. Integer cursus, augue in cursus faucibus, eros pede bibendum sem, in tempus tellus justo quis ligula. Etiam eget tortor. Vestibulum rutrum, est ut placerat elementum, lectus nisl aliquam velit, tempor aliquam eros nunc nonummy metus. In eros metus, gravida a, gravida sed, lobortis id, turpis. Ut ultrices, ipsum at venenatis fringilla, sem nulla lacinia tellus, eget aliquet turpis mauris non enim. Nam turpis. Suspendisse lacinia. Curabitur ac tortor ut ipsum egestas elementum. Nunc imperdiet gravida mauris.")+"</td></tr></table></div></div>"}]}]}]},{id:"Link",requiredContent:"a[href]",label:a.lang.image.linkTab,padding:0,elements:[{id:"txtUrl",type:"text",label:a.lang.common.url,style:"width: 100%","default":"",setup:function(e,A){if(2==e){var d=A.data("cke-saved-href");d||(d=A.getAttribute("href"));this.setValue(d)}},commit:function(e,A){if(2==e&&(this.getValue()||this.isChanged())){var d=decodeURI(this.getValue());A.data("cke-saved-href",d);A.setAttribute("href",d);if(this.getValue()||!a.config.image_removeLinkByEmptyURL){this.getDialog().addLink=!0}}}},{type:"button",id:"browse",filebrowser:{action:"Browse",target:"Link:txtUrl",url:a.config.filebrowserImageBrowseLinkUrl},style:"float:right",hidden:!0,label:a.lang.common.browseServer},{id:"cmbTarget",type:"select",requiredContent:"a[target]",label:a.lang.common.target,"default":"",items:[[a.lang.common.notSet,""],[a.lang.common.targetNew,"_blank"],[a.lang.common.targetTop,"_top"],[a.lang.common.targetSelf,"_self"],[a.lang.common.targetParent,"_parent"]],setup:function(d,e){2==d&&this.setValue(e.getAttribute("target")||"")},commit:function(d,e){2==d&&(this.getValue()||this.isChanged())&&e.setAttribute("target",this.getValue())}}]},{id:"Upload",hidden:!0,filebrowser:"uploadButton",label:a.lang.image.upload,elements:[{type:"file",id:"upload",label:a.lang.image.btnUpload,style:"height:40px",size:38},{type:"fileButton",id:"uploadButton",filebrowser:"info:txtUrl",label:a.lang.image.btnUpload,"for":["Upload","upload"]}]},{id:"advanced",label:a.lang.common.advancedTab,elements:[{type:"hbox",widths:["50%","25%","25%"],children:[{type:"text",id:"linkId",requiredContent:"img[id]",label:a.lang.common.id,setup:function(d,e){d==c&&this.setValue(e.getAttribute("id"))},commit:function(d,e){d==c&&(this.getValue()||this.isChanged())&&e.setAttribute("id",this.getValue())}},{id:"cmbLangDir",type:"select",requiredContent:"img[dir]",style:"width : 100px;",label:a.lang.common.langDir,"default":"",items:[[a.lang.common.notSet,""],[a.lang.common.langDirLtr,"ltr"],[a.lang.common.langDirRtl,"rtl"]],setup:function(d,e){d==c&&this.setValue(e.getAttribute("dir"))},commit:function(d,e){d==c&&(this.getValue()||this.isChanged())&&e.setAttribute("dir",this.getValue())}},{type:"text",id:"txtLangCode",requiredContent:"img[lang]",label:a.lang.common.langCode,"default":"",setup:function(d,e){d==c&&this.setValue(e.getAttribute("lang"))},commit:function(d,e){d==c&&(this.getValue()||this.isChanged())&&e.setAttribute("lang",this.getValue())}}]},{type:"text",id:"txtGenLongDescr",requiredContent:"img[longdesc]",label:a.lang.common.longDescr,setup:function(d,e){d==c&&this.setValue(e.getAttribute("longDesc"))},commit:function(d,e){d==c&&(this.getValue()||this.isChanged())&&e.setAttribute("longDesc",this.getValue())}},{type:"hbox",widths:["50%","50%"],children:[{type:"text",id:"txtGenClass",requiredContent:"img(cke-xyz)",label:a.lang.common.cssClass,"default":"",setup:function(d,e){d==c&&this.setValue(e.getAttribute("class"))},commit:function(d,e){d==c&&(this.getValue()||this.isChanged())&&e.setAttribute("class",this.getValue())}},{type:"text",id:"txtGenTitle",requiredContent:"img[title]",label:a.lang.common.advisoryTitle,"default":"",onChange:function(){f(this.getDialog())},setup:function(d,e){d==c&&this.setValue(e.getAttribute("title"))},commit:function(d,e){d==c?(this.getValue()||this.isChanged())&&e.setAttribute("title",this.getValue()):4==d?e.setAttribute("title",this.getValue()):8==d&&e.removeAttribute("title")}}]},{type:"text",id:"txtdlgGenStyle",requiredContent:"img{cke-xyz}",label:a.lang.common.cssStyle,validate:CKEDITOR.dialog.validate.inlineStyle(a.lang.common.invalidInlineStyle),"default":"",setup:function(A,B){if(A==c){var d=B.getAttribute("style");!d&&B.$.style.cssText&&(d=B.$.style.cssText);this.setValue(d);var e=B.$.style.height,d=B.$.style.width,e=(e?e:"").match(j),d=(d?d:"").match(j);this.attributesInStyle={height:!!e,width:!!d}}},onChange:function(){h.call(this,"info:cmbFloat info:cmbAlign info:txtVSpace info:txtHSpace info:txtBorder info:txtWidth info:txtHeight".split(" "));f(this)},commit:function(d,e){d==c&&(this.getValue()||this.isChanged())&&e.setAttribute("style",this.getValue())}}]}]}};CKEDITOR.dialog.add("image",function(a){return b(a,"image")});CKEDITOR.dialog.add("imagebutton",function(a){return b(a,"imagebutton")})})();