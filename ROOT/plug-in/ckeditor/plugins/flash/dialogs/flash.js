(function(){function o(e,f,h){var d=c[this.id];if(d){for(var a=this instanceof CKEDITOR.ui.dialog.checkbox,l=0;l<d.length;l++){var k=d[l];switch(k.type){case i:if(!e){continue}if(null!==e.getAttribute(k.name)){e=e.getAttribute(k.name);a?this.setValue("true"==e.toLowerCase()):this.setValue(e);return}a&&this.setValue(!!k["default"]);break;case g:if(!e){continue}if(k.name in h){e=h[k.name];a?this.setValue("true"==e.toLowerCase()):this.setValue(e);return}a&&this.setValue(!!k["default"]);break;case j:if(!f){continue}if(f.getAttribute(k.name)){e=f.getAttribute(k.name);a?this.setValue("true"==e.toLowerCase()):this.setValue(e);return}a&&this.setValue(!!k["default"])}}}}function n(u,v,a){var k=c[this.id];if(k){for(var f=""===this.getValue(),e=this instanceof CKEDITOR.ui.dialog.checkbox,d=0;d<k.length;d++){var h=k[d];switch(h.type){case i:if(!u||"data"==h.name&&v&&!u.hasAttribute("data")){continue}var l=this.getValue();f||e&&l===h["default"]?u.removeAttribute(h.name):u.setAttribute(h.name,l);break;case g:if(!u){continue}l=this.getValue();if(f||e&&l===h["default"]){h.name in a&&a[h.name].remove()}else{if(h.name in a){a[h.name].setAttribute("value",l)}else{var p=CKEDITOR.dom.element.createFromHtml("<cke:param></cke:param>",u.getDocument());p.setAttributes({name:h.name,value:l});1>u.getChildCount()?p.appendTo(u):p.insertBefore(u.getFirst())}}break;case j:if(!v){continue}l=this.getValue();f||e&&l===h["default"]?v.removeAttribute(h.name):v.setAttribute(h.name,l)}}}}for(var i=1,g=2,j=4,c={id:[{type:i,name:"id"}],classid:[{type:i,name:"classid"}],codebase:[{type:i,name:"codebase"}],pluginspage:[{type:j,name:"pluginspage"}],src:[{type:g,name:"movie"},{type:j,name:"src"},{type:i,name:"data"}],name:[{type:j,name:"name"}],align:[{type:i,name:"align"}],"class":[{type:i,name:"class"},{type:j,name:"class"}],width:[{type:i,name:"width"},{type:j,name:"width"}],height:[{type:i,name:"height"},{type:j,name:"height"}],hSpace:[{type:i,name:"hSpace"},{type:j,name:"hSpace"}],vSpace:[{type:i,name:"vSpace"},{type:j,name:"vSpace"}],style:[{type:i,name:"style"},{type:j,name:"style"}],type:[{type:j,name:"type"}]},b="play loop menu quality scale salign wmode bgcolor base flashvars allowScriptAccess allowFullScreen".split(" "),m=0;m<b.length;m++){c[b[m]]=[{type:j,name:b[m]},{type:g,name:b[m]}]}b=["allowFullScreen","play","loop","menu"];for(m=0;m<b.length;m++){c[b[m]][0]["default"]=c[b[m]][1]["default"]=!0}CKEDITOR.dialog.add("flash",function(d){var a=!d.config.flashEmbedTagOnly,e=d.config.flashAddEmbedTag||d.config.flashEmbedTagOnly,h,f="<div>"+CKEDITOR.tools.htmlEncode(d.lang.common.preview)+'<br><div id="cke_FlashPreviewLoader'+CKEDITOR.tools.getNextNumber()+'" style="display:none"><div class="loading">&nbsp;</div></div><div id="cke_FlashPreviewBox'+CKEDITOR.tools.getNextNumber()+'" class="FlashPreviewBox"></div></div>';return{title:d.lang.flash.title,minWidth:420,minHeight:310,onShow:function(){this.fakeImage=this.objectNode=this.embedNode=null;h=new CKEDITOR.dom.element("embed",d.document);var B=this.getSelectedElement();if(B&&B.data("cke-real-element-type")&&"flash"==B.data("cke-real-element-type")){this.fakeImage=B;var A=d.restoreRealElement(B),k=null,y=null,z={};if("cke:object"==A.getName()){k=A;A=k.getElementsByTag("embed","cke");0<A.count()&&(y=A.getItem(0));for(var A=k.getElementsByTag("param","cke"),D=0,l=A.count();D<l;D++){var C=A.getItem(D),p=C.getAttribute("name"),C=C.getAttribute("value");z[p]=C}}else{"cke:embed"==A.getName()&&(y=A)}this.objectNode=k;this.embedNode=y;this.setupContent(k,y,z,B)}},onOk:function(){var u=null,t=null,p=null;if(this.fakeImage){u=this.objectNode,t=this.embedNode}else{if(a&&(u=CKEDITOR.dom.element.createFromHtml("<cke:object></cke:object>",d.document),u.setAttributes({classid:"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000",codebase:"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"})),e){t=CKEDITOR.dom.element.createFromHtml("<cke:embed></cke:embed>",d.document),t.setAttributes({type:"application/x-shockwave-flash",pluginspage:"http://www.macromedia.com/go/getflashplayer"}),u&&t.appendTo(u)}}if(u){for(var p={},l=u.getElementsByTag("param","cke"),v=0,k=l.count();v<k;v++){p[l.getItem(v).getAttribute("name")]=l.getItem(v)}}l={};v={};this.commitContent(u,t,p,l,v);u=d.createFakeElement(u||t,"cke_flash","flash",!0);u.setAttributes(v);u.setStyles(l);this.fakeImage?(u.replace(this.fakeImage),d.getSelection().selectElement(u)):d.insertElement(u)},onHide:function(){this.preview&&this.preview.setHtml("")},contents:[{id:"info",label:d.lang.common.generalTab,accessKey:"I",elements:[{type:"vbox",padding:0,children:[{type:"hbox",widths:["280px","110px"],align:"right",children:[{id:"src",type:"text",label:d.lang.common.url,required:!0,validate:CKEDITOR.dialog.validate.notEmpty(d.lang.flash.validateSrc),setup:o,commit:n,onLoad:function(){var k=this.getDialog(),l=function(p){h.setAttribute("src",p);k.preview.setHtml('<embed height="100%" width="100%" src="'+CKEDITOR.tools.htmlEncode(h.getAttribute("src"))+'" type="application/x-shockwave-flash"></embed>')};k.preview=k.getContentElement("info","preview").getElement().getChild(3);this.on("change",function(p){p.data&&p.data.value&&l(p.data.value)});this.getInputElement().on("change",function(){l(this.getValue())},this)}},{type:"button",id:"browse",filebrowser:"info:src",hidden:!0,style:"display:inline-block;margin-top:10px;",label:d.lang.common.browseServer}]}]},{type:"hbox",widths:["25%","25%","25%","25%","25%"],children:[{type:"text",id:"width",requiredContent:"embed[width]",style:"width:95px",label:d.lang.common.width,validate:CKEDITOR.dialog.validate.htmlLength(d.lang.common.invalidHtmlLength.replace("%1",d.lang.common.width)),setup:o,commit:n},{type:"text",id:"height",requiredContent:"embed[height]",style:"width:95px",label:d.lang.common.height,validate:CKEDITOR.dialog.validate.htmlLength(d.lang.common.invalidHtmlLength.replace("%1",d.lang.common.height)),setup:o,commit:n},{type:"text",id:"hSpace",requiredContent:"embed[hspace]",style:"width:95px",label:d.lang.flash.hSpace,validate:CKEDITOR.dialog.validate.integer(d.lang.flash.validateHSpace),setup:o,commit:n},{type:"text",id:"vSpace",requiredContent:"embed[vspace]",style:"width:95px",label:d.lang.flash.vSpace,validate:CKEDITOR.dialog.validate.integer(d.lang.flash.validateVSpace),setup:o,commit:n}]},{type:"vbox",children:[{type:"html",id:"preview",style:"width:95%;",html:f}]}]},{id:"Upload",hidden:!0,filebrowser:"uploadButton",label:d.lang.common.upload,elements:[{type:"file",id:"upload",label:d.lang.common.upload,size:38},{type:"fileButton",id:"uploadButton",label:d.lang.common.uploadSubmit,filebrowser:"info:src","for":["Upload","upload"]}]},{id:"properties",label:d.lang.flash.propertiesTab,elements:[{type:"hbox",widths:["50%","50%"],children:[{id:"scale",type:"select",requiredContent:"embed[scale]",label:d.lang.flash.scale,"default":"",style:"width : 100%;",items:[[d.lang.common.notSet,""],[d.lang.flash.scaleAll,"showall"],[d.lang.flash.scaleNoBorder,"noborder"],[d.lang.flash.scaleFit,"exactfit"]],setup:o,commit:n},{id:"allowScriptAccess",type:"select",requiredContent:"embed[allowscriptaccess]",label:d.lang.flash.access,"default":"",style:"width : 100%;",items:[[d.lang.common.notSet,""],[d.lang.flash.accessAlways,"always"],[d.lang.flash.accessSameDomain,"samedomain"],[d.lang.flash.accessNever,"never"]],setup:o,commit:n}]},{type:"hbox",widths:["50%","50%"],children:[{id:"wmode",type:"select",requiredContent:"embed[wmode]",label:d.lang.flash.windowMode,"default":"",style:"width : 100%;",items:[[d.lang.common.notSet,""],[d.lang.flash.windowModeWindow,"window"],[d.lang.flash.windowModeOpaque,"opaque"],[d.lang.flash.windowModeTransparent,"transparent"]],setup:o,commit:n},{id:"quality",type:"select",requiredContent:"embed[quality]",label:d.lang.flash.quality,"default":"high",style:"width : 100%;",items:[[d.lang.common.notSet,""],[d.lang.flash.qualityBest,"best"],[d.lang.flash.qualityHigh,"high"],[d.lang.flash.qualityAutoHigh,"autohigh"],[d.lang.flash.qualityMedium,"medium"],[d.lang.flash.qualityAutoLow,"autolow"],[d.lang.flash.qualityLow,"low"]],setup:o,commit:n}]},{type:"hbox",widths:["50%","50%"],children:[{id:"align",type:"select",requiredContent:"object[align]",label:d.lang.common.align,"default":"",style:"width : 100%;",items:[[d.lang.common.notSet,""],[d.lang.common.alignLeft,"left"],[d.lang.flash.alignAbsBottom,"absBottom"],[d.lang.flash.alignAbsMiddle,"absMiddle"],[d.lang.flash.alignBaseline,"baseline"],[d.lang.common.alignBottom,"bottom"],[d.lang.common.alignMiddle,"middle"],[d.lang.common.alignRight,"right"],[d.lang.flash.alignTextTop,"textTop"],[d.lang.common.alignTop,"top"]],setup:o,commit:function(w,x,k,l,p){var v=this.getValue();n.apply(this,arguments);v&&(p.align=v)}},{type:"html",html:"<div></div>"}]},{type:"fieldset",label:CKEDITOR.tools.htmlEncode(d.lang.flash.flashvars),children:[{type:"vbox",padding:0,children:[{type:"checkbox",id:"menu",label:d.lang.flash.chkMenu,"default":!0,setup:o,commit:n},{type:"checkbox",id:"play",label:d.lang.flash.chkPlay,"default":!0,setup:o,commit:n},{type:"checkbox",id:"loop",label:d.lang.flash.chkLoop,"default":!0,setup:o,commit:n},{type:"checkbox",id:"allowFullScreen",label:d.lang.flash.chkFull,"default":!0,setup:o,commit:n}]}]}]},{id:"advanced",label:d.lang.common.advancedTab,elements:[{type:"hbox",children:[{type:"text",id:"id",requiredContent:"object[id]",label:d.lang.common.id,setup:o,commit:n}]},{type:"hbox",widths:["45%","55%"],children:[{type:"text",id:"bgcolor",requiredContent:"embed[bgcolor]",label:d.lang.flash.bgcolor,setup:o,commit:n},{type:"text",id:"class",requiredContent:"embed(cke-xyz)",label:d.lang.common.cssClass,setup:o,commit:n}]},{type:"text",id:"style",requiredContent:"embed{cke-xyz}",validate:CKEDITOR.dialog.validate.inlineStyle(d.lang.common.invalidInlineStyle),label:d.lang.common.cssStyle,setup:o,commit:n}]}]}})})();