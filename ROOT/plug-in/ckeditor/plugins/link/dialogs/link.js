CKEDITOR.dialog.add("link",function(j){var l,n;function p(a){return a.replace(/'/g,"\\$&")}function t(e){var d,g=l,a,c;d=[n,"("];for(var f=0;f<g.length;f++){a=g[f].toLowerCase(),c=e[a],0<f&&d.push(","),d.push("'",c?p(encodeURIComponent(e[a])):"","'")}d.push(")");return d.join("")}function v(a){for(var f,c=a.length,d=[],e=0;e<c;e++){f=a.charCodeAt(e),d.push(f)}return"String.fromCharCode("+d.join(",")+")"}function x(a){return(a=a.getAttribute("class"))?a.replace(/\s*(?:cke_anchor_empty|cke_anchor)(?:\s*$)?/g,""):""}var z=CKEDITOR.plugins.link,s=function(){var a=this.getDialog(),d=a.getContentElement("target","popupFeatures"),a=a.getContentElement("target","linkTargetName"),c=this.getValue();if(d&&a){switch(d=d.getElement(),d.hide(),a.setValue(""),c){case"frame":a.setLabel(j.lang.link.targetFrameName);a.getElement().show();break;case"popup":d.show();a.setLabel(j.lang.link.targetPopupName);a.getElement().show();break;default:a.setValue(c),a.getElement().hide()}}},B=/^javascript:/,E=/^mailto:([^?]+)(?:\?(.+))?$/,H=/subject=([^;?:@&=$,\/]*)/,m=/body=([^;?:@&=$,\/]*)/,o=/^#(.*)$/,q=/^((?:http|https|ftp|news):\/\/)?(.*)$/,r=/^(_(?:self|top|parent|blank))$/,u=/^javascript:void\(location\.href='mailto:'\+String\.fromCharCode\(([^)]+)\)(?:\+'(.*)')?\)$/,w=/^javascript:([^(]+)\(([^)]+)\)$/,y=/\s*window.open\(\s*this\.href\s*,\s*(?:'([^']*)'|null)\s*,\s*'([^']*)'\s*\)\s*;\s*return\s*false;*\s*/,A=/(?:^|,)([^=]+)=(\d+|yes|no)/gi,C=function(e,c){var g=c&&(c.data("cke-saved-href")||c.getAttribute("href"))||"",h,J,f={};g.match(B)&&("encode"==k?g=g.replace(u,function(L,K,M){return"mailto:"+String.fromCharCode.apply(String,K.split(","))+(M&&M.replace(/\\'/g,"'"))}):k&&g.replace(w,function(K,L,M){if(L==n){f.type="email";for(var K=f.email={},L=/(^')|('$)/g,M=M.match(/[^,\s]+/g),N=M.length,P,O,Q=0;Q<N;Q++){P=decodeURIComponent,O=M[Q].replace(L,"").replace(/\\'/g,"'"),O=P(O),P=l[Q].toLowerCase(),K[P]=O}K.address=[K.name,K.domain].join("@")}}));if(!f.type){if(h=g.match(o)){f.type="anchor",f.anchor={},f.anchor.name=f.anchor.id=h[1]}else{if(h=g.match(E)){J=g.match(H);g=g.match(m);f.type="email";var a=f.email={};a.address=h[1];J&&(a.subject=decodeURIComponent(J[1]));g&&(a.body=decodeURIComponent(g[1]))}else{g&&(J=g.match(q))?(f.type="url",f.url={},f.url.protocol=J[1],f.url.url=J[2]):f.type="url"}}}if(c){h=c.getAttribute("target");f.target={};f.adv={};if(h){h.match(r)?f.target.type=f.target.name=h:(f.target.type="frame",f.target.name=h)}else{if(h=(h=c.data("cke-pa-onclick")||c.getAttribute("onclick"))&&h.match(y)){f.target.type="popup";for(f.target.name=h[1];g=A.exec(h[2]);){("yes"==g[2]||"1"==g[2])&&!(g[1] in {height:1,width:1,top:1,left:1})?f.target[g[1]]=!0:isFinite(g[2])&&(f.target[g[1]]=g[2])}}}h=function(K,L){var M=c.getAttribute(L);null!==M&&(f.adv[K]=M||"")};h("advId","id");h("advLangDir","dir");h("advAccessKey","accessKey");f.adv.advName=c.data("cke-saved-name")||c.getAttribute("name")||"";h("advLangCode","lang");h("advTabIndex","tabindex");h("advTitle","title");h("advContentType","type");CKEDITOR.plugins.link.synAnchorSelector?f.adv.advCSSClasses=x(c):h("advCSSClasses","class");h("advCharset","charset");h("advStyles","style");h("advRel","rel")}h=f.anchors=[];var d;if(CKEDITOR.plugins.link.emptyAnchorFix){a=e.document.getElementsByTag("a");g=0;for(J=a.count();g<J;g++){if(d=a.getItem(g),d.data("cke-saved-name")||d.hasAttribute("name")){h.push({name:d.data("cke-saved-name")||d.getAttribute("name"),id:d.getAttribute("id")})}}}else{a=new CKEDITOR.dom.nodeList(e.document.$.anchors);g=0;for(J=a.count();g<J;g++){d=a.getItem(g),h[g]={name:d.getAttribute("name"),id:d.getAttribute("id")}}}if(CKEDITOR.plugins.link.fakeAnchor){a=e.document.getElementsByTag("img");g=0;for(J=a.count();g<J;g++){(d=CKEDITOR.plugins.link.tryRestoreFakeAnchor(e,a.getItem(g)))&&h.push({name:d.getAttribute("name"),id:d.getAttribute("id")})}}this._.selectedElement=c;return f},G=function(a){a.target&&this.setValue(a.target[this.id]||"")},I=function(a){a.adv&&this.setValue(a.adv[this.id]||"")},b=function(a){a.target||(a.target={});a.target[this.id]=this.getValue()||""},i=function(a){a.adv||(a.adv={});a.adv[this.id]=this.getValue()||""},k=j.config.emailProtection||"";k&&"encode"!=k&&(n=l=void 0,k.replace(/^([^(]+)\(([^)]+)\)$/,function(c,d,a){n=d;l=[];a.replace(/[^,\s]+/g,function(e){l.push(e)})}));var F=j.lang.common,D=j.lang.link;return{title:D.title,minWidth:350,minHeight:230,contents:[{id:"info",label:D.info,title:D.info,elements:[{id:"linkType",type:"select",label:D.type,"default":"url",items:[[D.toUrl,"url"],[D.toAnchor,"anchor"],[D.toEmail,"email"]],onChange:function(){var e=this.getDialog(),f=["urlOptions","anchorOptions","emailOptions"],a=this.getValue(),c=e.definition.getContents("upload"),c=c&&c.hidden;if(a=="url"){j.config.linkShowTargetTab&&e.showPage("target");c||e.showPage("upload")}else{e.hidePage("target");c||e.hidePage("upload")}for(c=0;c<f.length;c++){var d=e.getContentElement("info",f[c]);if(d){d=d.getElement().getParent().getParent();f[c]==a+"Options"?d.show():d.hide()}}e.layout()},setup:function(a){a.type&&this.setValue(a.type)},commit:function(a){a.type=this.getValue()}},{type:"vbox",id:"urlOptions",children:[{type:"hbox",widths:["25%","75%"],children:[{id:"protocol",type:"select",label:F.protocol,"default":"http://",items:[["http://","http://"],["https://","https://"],["ftp://","ftp://"],["news://","news://"],[D.other,""]],setup:function(a){a.url&&this.setValue(a.url.protocol||"")},commit:function(a){if(!a.url){a.url={}}a.url.protocol=this.getValue()}},{type:"text",id:"url",label:F.url,required:!0,onLoad:function(){this.allowOnChange=true},onKeyUp:function(){this.allowOnChange=false;var d=this.getDialog().getContentElement("info","protocol"),e=this.getValue(),a=/^((javascript:)|[#\/\.\?])/i,c=/^(http|https|ftp|news):\/\/(?=.)/i.exec(e);if(c){this.setValue(e.substr(c[0].length));d.setValue(c[0].toLowerCase())}else{a.test(e)&&d.setValue("")}this.allowOnChange=true},onChange:function(){if(this.allowOnChange){this.onKeyUp()}},validate:function(){var a=this.getDialog();if(a.getContentElement("info","linkType")&&a.getValueOf("info","linkType")!="url"){return true}if(/javascript\:/.test(this.getValue())){alert(F.invalidValue);return false}return this.getDialog().fakeObj?true:CKEDITOR.dialog.validate.notEmpty(D.noUrl).apply(this)},setup:function(a){this.allowOnChange=false;a.url&&this.setValue(a.url.url);this.allowOnChange=true},commit:function(a){this.onChange();if(!a.url){a.url={}}a.url.url=this.getValue();this.allowOnChange=false}}],setup:function(){this.getDialog().getContentElement("info","linkType")||this.getElement().show()}},{type:"button",id:"browse",hidden:"true",filebrowser:"info:url",label:F.browseServer}]},{type:"vbox",id:"anchorOptions",width:260,align:"center",padding:0,children:[{type:"fieldset",id:"selectAnchorText",label:D.selectAnchor,setup:function(a){a.anchors.length>0?this.getElement().show():this.getElement().hide()},children:[{type:"hbox",id:"selectAnchor",children:[{type:"select",id:"anchorName","default":"",label:D.anchorName,style:"width: 100%;",items:[[""]],setup:function(a){this.clear();this.add("");for(var c=0;c<a.anchors.length;c++){a.anchors[c].name&&this.add(a.anchors[c].name)}a.anchor&&this.setValue(a.anchor.name);(a=this.getDialog().getContentElement("info","linkType"))&&a.getValue()=="email"&&this.focus()},commit:function(a){if(!a.anchor){a.anchor={}}a.anchor.name=this.getValue()}},{type:"select",id:"anchorId","default":"",label:D.anchorId,style:"width: 100%;",items:[[""]],setup:function(a){this.clear();this.add("");for(var c=0;c<a.anchors.length;c++){a.anchors[c].id&&this.add(a.anchors[c].id)}a.anchor&&this.setValue(a.anchor.id)},commit:function(a){if(!a.anchor){a.anchor={}}a.anchor.id=this.getValue()}}],setup:function(a){a.anchors.length>0?this.getElement().show():this.getElement().hide()}}]},{type:"html",id:"noAnchors",style:"text-align: center;",html:'<div role="note" tabIndex="-1">'+CKEDITOR.tools.htmlEncode(D.noAnchors)+"</div>",focus:!0,setup:function(a){a.anchors.length<1?this.getElement().show():this.getElement().hide()}}],setup:function(){this.getDialog().getContentElement("info","linkType")||this.getElement().hide()}},{type:"vbox",id:"emailOptions",padding:1,children:[{type:"text",id:"emailAddress",label:D.emailAddress,required:!0,validate:function(){var a=this.getDialog();return !a.getContentElement("info","linkType")||a.getValueOf("info","linkType")!="email"?true:CKEDITOR.dialog.validate.notEmpty(D.noEmail).apply(this)},setup:function(a){a.email&&this.setValue(a.email.address);(a=this.getDialog().getContentElement("info","linkType"))&&a.getValue()=="email"&&this.select()},commit:function(a){if(!a.email){a.email={}}a.email.address=this.getValue()}},{type:"text",id:"emailSubject",label:D.emailSubject,setup:function(a){a.email&&this.setValue(a.email.subject)},commit:function(a){if(!a.email){a.email={}}a.email.subject=this.getValue()}},{type:"textarea",id:"emailBody",label:D.emailBody,rows:3,"default":"",setup:function(a){a.email&&this.setValue(a.email.body)},commit:function(a){if(!a.email){a.email={}}a.email.body=this.getValue()}}],setup:function(){this.getDialog().getContentElement("info","linkType")||this.getElement().hide()}}]},{id:"target",requiredContent:"a[target]",label:D.target,title:D.target,elements:[{type:"hbox",widths:["50%","50%"],children:[{type:"select",id:"linkTargetType",label:F.target,"default":"notSet",style:"width : 100%;",items:[[F.notSet,"notSet"],[D.targetFrame,"frame"],[D.targetPopup,"popup"],[F.targetNew,"_blank"],[F.targetTop,"_top"],[F.targetSelf,"_self"],[F.targetParent,"_parent"]],onChange:s,setup:function(a){a.target&&this.setValue(a.target.type||"notSet");s.call(this)},commit:function(a){if(!a.target){a.target={}}a.target.type=this.getValue()}},{type:"text",id:"linkTargetName",label:D.targetFrameName,"default":"",setup:function(a){a.target&&this.setValue(a.target.name)},commit:function(a){if(!a.target){a.target={}}a.target.name=this.getValue().replace(/\W/gi,"")}}]},{type:"vbox",width:"100%",align:"center",padding:2,id:"popupFeatures",children:[{type:"fieldset",label:D.popupFeatures,children:[{type:"hbox",children:[{type:"checkbox",id:"resizable",label:D.popupResizable,setup:G,commit:b},{type:"checkbox",id:"status",label:D.popupStatusBar,setup:G,commit:b}]},{type:"hbox",children:[{type:"checkbox",id:"location",label:D.popupLocationBar,setup:G,commit:b},{type:"checkbox",id:"toolbar",label:D.popupToolbar,setup:G,commit:b}]},{type:"hbox",children:[{type:"checkbox",id:"menubar",label:D.popupMenuBar,setup:G,commit:b},{type:"checkbox",id:"fullscreen",label:D.popupFullScreen,setup:G,commit:b}]},{type:"hbox",children:[{type:"checkbox",id:"scrollbars",label:D.popupScrollBars,setup:G,commit:b},{type:"checkbox",id:"dependent",label:D.popupDependent,setup:G,commit:b}]},{type:"hbox",children:[{type:"text",widths:["50%","50%"],labelLayout:"horizontal",label:F.width,id:"width",setup:G,commit:b},{type:"text",labelLayout:"horizontal",widths:["50%","50%"],label:D.popupLeft,id:"left",setup:G,commit:b}]},{type:"hbox",children:[{type:"text",labelLayout:"horizontal",widths:["50%","50%"],label:F.height,id:"height",setup:G,commit:b},{type:"text",labelLayout:"horizontal",label:D.popupTop,widths:["50%","50%"],id:"top",setup:G,commit:b}]}]}]}]},{id:"upload",label:D.upload,title:D.upload,hidden:!0,filebrowser:"uploadButton",elements:[{type:"file",id:"upload",label:F.upload,style:"height:40px",size:29},{type:"fileButton",id:"uploadButton",label:F.uploadSubmit,filebrowser:"info:url","for":["upload","upload"]}]},{id:"advanced",label:D.advanced,title:D.advanced,elements:[{type:"vbox",padding:1,children:[{type:"hbox",widths:["45%","35%","20%"],children:[{type:"text",id:"advId",requiredContent:"a[id]",label:D.id,setup:I,commit:i},{type:"select",id:"advLangDir",requiredContent:"a[dir]",label:D.langDir,"default":"",style:"width:110px",items:[[F.notSet,""],[D.langDirLTR,"ltr"],[D.langDirRTL,"rtl"]],setup:I,commit:i},{type:"text",id:"advAccessKey",requiredContent:"a[accesskey]",width:"80px",label:D.acccessKey,maxLength:1,setup:I,commit:i}]},{type:"hbox",widths:["45%","35%","20%"],children:[{type:"text",label:D.name,id:"advName",requiredContent:"a[name]",setup:I,commit:i},{type:"text",label:D.langCode,id:"advLangCode",requiredContent:"a[lang]",width:"110px","default":"",setup:I,commit:i},{type:"text",label:D.tabIndex,id:"advTabIndex",requiredContent:"a[tabindex]",width:"80px",maxLength:5,setup:I,commit:i}]}]},{type:"vbox",padding:1,children:[{type:"hbox",widths:["45%","55%"],children:[{type:"text",label:D.advisoryTitle,requiredContent:"a[title]","default":"",id:"advTitle",setup:I,commit:i},{type:"text",label:D.advisoryContentType,requiredContent:"a[type]","default":"",id:"advContentType",setup:I,commit:i}]},{type:"hbox",widths:["45%","55%"],children:[{type:"text",label:D.cssClasses,requiredContent:"a(cke-xyz)","default":"",id:"advCSSClasses",setup:I,commit:i},{type:"text",label:D.charset,requiredContent:"a[charset]","default":"",id:"advCharset",setup:I,commit:i}]},{type:"hbox",widths:["45%","55%"],children:[{type:"text",label:D.rel,requiredContent:"a[rel]","default":"",id:"advRel",setup:I,commit:i},{type:"text",label:D.styles,requiredContent:"a{cke-xyz}","default":"",id:"advStyles",validate:CKEDITOR.dialog.validate.inlineStyle(j.lang.common.invalidInlineStyle),setup:I,commit:i}]}]}]}],onShow:function(){var c=this.getParentEditor(),d=c.getSelection(),a=null;(a=z.getSelectedLink(c))&&a.hasAttribute("href")?d.selectElement(a):a=null;this.setupContent(C.apply(this,[c,a]))},onOk:function(){var K={},a=[],c={},d=this.getParentEditor();this.commitContent(c);switch(c.type||"url"){case"url":var e=c.url&&c.url.protocol!=void 0?c.url.protocol:"http://",h=c.url&&CKEDITOR.tools.trim(c.url.url)||"";K["data-cke-saved-href"]=h.indexOf("/")===0?h:e+h;break;case"anchor":e=c.anchor&&c.anchor.id;K["data-cke-saved-href"]="#"+(c.anchor&&c.anchor.name||e||"");break;case"email":var f=c.email,e=f.address;switch(k){case"":case"encode":var h=encodeURIComponent(f.subject||""),g=encodeURIComponent(f.body||""),f=[];h&&f.push("subject="+h);g&&f.push("body="+g);f=f.length?"?"+f.join("&"):"";if(k=="encode"){e=["javascript:void(location.href='mailto:'+",v(e)];f&&e.push("+'",p(f),"'");e.push(")")}else{e=["mailto:",e,f]}break;default:e=e.split("@",2);f.name=e[0];f.domain=e[1];e=["javascript:",t(f)]}K["data-cke-saved-href"]=e.join("")}if(c.target){if(c.target.type=="popup"){for(var e=["window.open(this.href, '",c.target.name||"","', '"],J=["resizable","status","location","toolbar","menubar","fullscreen","scrollbars","dependent"],h=J.length,f=function(L){c.target[L]&&J.push(L+"="+c.target[L])},g=0;g<h;g++){J[g]=J[g]+(c.target[J[g]]?"=yes":"=no")}f("width");f("left");f("height");f("top");e.push(J.join(","),"'); return false;");K["data-cke-pa-onclick"]=e.join("");a.push("target")}else{c.target.type!="notSet"&&c.target.name?K.target=c.target.name:a.push("target");a.push("data-cke-pa-onclick","onclick")}}if(c.adv){e=function(M,N){var L=c.adv[M];L?K[N]=L:a.push(N)};e("advId","id");e("advLangDir","dir");e("advAccessKey","accessKey");c.adv.advName?K.name=K["data-cke-saved-name"]=c.adv.advName:a=a.concat(["data-cke-saved-name","name"]);e("advLangCode","lang");e("advTabIndex","tabindex");e("advTitle","title");e("advContentType","type");e("advCSSClasses","class");e("advCharset","charset");e("advStyles","style");e("advRel","rel")}e=d.getSelection();K.href=K["data-cke-saved-href"];if(this._.selectedElement){d=this._.selectedElement;h=d.data("cke-saved-href");f=d.getHtml();d.setAttributes(K);d.removeAttributes(a);c.adv&&(c.adv.advName&&CKEDITOR.plugins.link.synAnchorSelector)&&d.addClass(d.getChildCount()?"cke_anchor":"cke_anchor_empty");if(h==f||c.type=="email"&&f.indexOf("@")!=-1){d.setHtml(c.type=="email"?c.email.address:K["data-cke-saved-href"])}e.selectElement(d);delete this._.selectedElement}else{e=e.getRanges(1)[0];if(e.collapsed){d=new CKEDITOR.dom.text(c.type=="email"?c.email.address:K["data-cke-saved-href"],d.document);e.insertNode(d);e.selectNodeContents(d)}d=new CKEDITOR.style({element:"a",attributes:K});d.type=CKEDITOR.STYLE_INLINE;d.applyToRange(e);e.select()}},onLoad:function(){j.config.linkShowAdvancedTab||this.hidePage("advanced");j.config.linkShowTargetTab||this.hidePage("target")},onFocus:function(){var a=this.getContentElement("info","linkType");if(a&&a.getValue()=="url"){a=this.getContentElement("info","url");a.select()}}}});