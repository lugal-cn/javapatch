(function(){function s(h){if(!h){throw"Languages-by-groups list are required for construct selectbox"}var b=[],c="",d;for(d in h){for(var e in h[d]){var g=h[d][e];"en_US"==g?c=g:b.push(g)}}b.sort();c&&b.unshift(c);return{getCurrentLangGroup:function(A){h:{for(var B in h){for(var z in h[B]){if(z.toUpperCase()===A.toUpperCase()){A=B;break h}}}A=""}return A},setLangList:function(){var A={},B;for(B in h){for(var z in h[B]){A[h[B][z]]=z}}return A}()}}var f=function(){var b=function(g,h,z){var z=z||{},d=z.expires;if("number"==typeof d&&d){var e=new Date;e.setTime(e.getTime()+1000*d);d=z.expires=e}d&&d.toUTCString&&(z.expires=d.toUTCString());var h=encodeURIComponent(h),g=g+"="+h,c;for(c in z){h=z[c],g+="; "+c,!0!==h&&(g+="="+h)}document.cookie=g};return{postMessage:{init:function(c){document.addEventListener?window.addEventListener("message",c,!1):window.attachEvent("onmessage",c)},send:function(g){var h=g.fn||null,c=g.id||"",d=g.target||window,e=g.message||{id:c};"[object Object]"==Object.prototype.toString.call(g.message)&&(g.message.id||(g.message.id=c),e=g.message);g=window.JSON.stringify(e,h);d.postMessage(g,"*")}},hash:{create:function(){},parse:function(){}},cookie:{set:b,get:function(c){return(c=document.cookie.match(RegExp("(?:^|; )"+c.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g,"\\$1")+"=([^;]*)")))?decodeURIComponent(c[1]):void 0},remove:function(c){b(c,"",{expires:-1})}}}}(),a=a||{};a.TextAreaNumber=null;a.load=!0;a.cmd={SpellTab:"spell",Thesaurus:"thes",GrammTab:"grammar"};a.dialog=null;a.optionNode=null;a.selectNode=null;a.grammerSuggest=null;a.textNode={};a.iframeMain=null;a.dataTemp="";a.div_overlay=null;a.textNodeInfo={};a.selectNode={};a.selectNodeResponce={};a.selectingLang=a.currentLang;a.langList=null;a.langSelectbox=null;a.banner="";a.show_grammar=null;a.div_overlay_no_check=null;a.wsc_customerId=CKEDITOR.config.wsc_customerId;a.cust_dic_ids=CKEDITOR.config.wsc_customDictionaryIds;a.userDictionaryName=CKEDITOR.config.wsc_userDictionaryName;a.defaultLanguage=CKEDITOR.config.defaultLanguage;a.targetFromFrame={};a.onLoadOverlay=null;a.LocalizationComing={};a.OverlayPlace=null;a.LocalizationButton={ChangeTo:{instance:null,text:"Change to"},ChangeAll:{instance:null,text:"Change All"},IgnoreWord:{instance:null,text:"Ignore word"},IgnoreAllWords:{instance:null,text:"Ignore all words"},Options:{instance:null,text:"Options",optionsDialog:{instance:null}},AddWord:{instance:null,text:"Add word"},FinishChecking:{instance:null,text:"Finish Checking"}};a.LocalizationLabel={ChangeTo:{instance:null,text:"Change to"},Suggestions:{instance:null,text:"Suggestions"}};var i=function(b){for(var c in b){b[c].instance.getElement().setText(a.LocalizationComing[c])}},t=function(b){for(var c in b){if(!b[c].instance.setLabel){break}b[c].instance.setLabel(a.LocalizationComing[c])}},k,l;a.framesetHtml=function(b){return'<iframe src="'+a.templatePath+a.serverLocation+'" id='+a.iframeNumber+"_"+b+' frameborder="0" allowtransparency="1" style="width:100%;border: 1px solid #AEB3B9;overflow: auto;background:#fff; border-radius: 3px;"></iframe>'};a.setIframe=function(b,c){var d=a.framesetHtml(c);return b.getElement().setHtml(d)};a.setCurrentIframe=function(b){a.setIframe(a.dialog._.contents[b].Content,b)};a.setHeightBannerFrame=function(){var b=a.dialog.getContentElement("SpellTab","banner").getElement(),c=a.dialog.getContentElement("GrammTab","banner").getElement(),d=a.dialog.getContentElement("Thesaurus","banner").getElement();b.setStyle("height","90px");c.setStyle("height","90px");d.setStyle("height","90px")};a.setHeightFrame=function(){document.getElementById(a.iframeNumber+"_"+a.dialog._.currentTabId).style.height="240px"};a.sendData=function(b){var c=b._.currentTabId,d=b._.contents[c].Content,e,g;a.setIframe(d,c);b.parts.tabs.removeAllListeners();b.parts.tabs.on("click",function(h){h=h||window.event;h.data.getTarget().is("a")&&c!=b._.currentTabId&&(c=b._.currentTabId,d=b._.contents[c].Content,e=a.iframeNumber+"_"+c,a.div_overlay.setEnable(),d.getElement().getChildCount()?p(a.targetFromFrame[e],a.cmd[c]):(a.setIframe(d,c),g=document.getElementById(e),a.targetFromFrame[e]=g.contentWindow))})};a.buildSelectLang=function(){var b=new CKEDITOR.dom.element("div"),c=new CKEDITOR.dom.element("select"),d="wscLang"+a.CKNumber;b.addClass("cke_dialog_ui_input_select");b.setAttribute("role","presentation");b.setStyles({height:"auto",position:"absolute",right:"0",top:"-1px",width:"160px","white-space":"normal"});c.setAttribute("id",d);c.addClass("cke_dialog_ui_input_select");c.setStyles({width:"160px"});b.append(c);return b};a.buildOptionLang=function(c){var b=document.getElementById("wscLang"+a.CKNumber),d=document.createDocumentFragment(),e,g=[];if(0===b.options.length){for(e in c){g.push([e,c[e]])}g.sort();for(var h=0;h<g.length;h++){c=document.createElement("option"),c.setAttribute("value",g[h][1]),e=document.createTextNode(g[h][0]),c.appendChild(e),g[h][1]==a.selectingLang&&c.setAttribute("selected","selected"),d.appendChild(c)}b.appendChild(d)}};a.buildOptionSynonyms=function(b){b=a.selectNodeResponce[b];a.selectNode.synonyms.clear();for(var c=0;c<b.length;c++){a.selectNode.synonyms.add(b[c],b[c])}a.selectNode.synonyms.getInputElement().$.firstChild.selected=!0;a.textNode.Thesaurus.setValue(a.selectNode.synonyms.getInputElement().getValue())};var m=function(g){var h=document,z=g.target||h.body,b=g.id||"overlayBlock",d=g.opacity||"0.9",g=g.background||"#f1f1f1",e=h.getElementById(b),c=e||h.createElement("div");c.style.cssText="position: absolute;top:30px;bottom:40px;left:1px;right:1px;z-index: 10020;padding:0;margin:0;background:"+g+";opacity: "+d+";filter: alpha(opacity="+100*d+");display: none;";c.id=b;e||z.appendChild(c);return{setDisable:function(){c.style.display="none"},setEnable:function(){c.style.display="block"}}},u=function(d,z,b){var c=new CKEDITOR.dom.element("div"),g=new CKEDITOR.dom.element("input"),h=new CKEDITOR.dom.element("label"),e="wscGrammerSuggest"+d+"_"+z;c.addClass("cke_dialog_ui_input_radio");c.setAttribute("role","presentation");c.setStyles({width:"97%",padding:"5px","white-space":"normal"});g.setAttributes({type:"radio",value:z,name:"wscGrammerSuggest",id:e});g.setStyles({"float":"left"});g.on("click",function(A){a.textNode.GrammTab.setValue(A.sender.getValue())});b&&g.setAttribute("checked",!0);g.addClass("cke_dialog_ui_radio_input");h.appendText(d);h.setAttribute("for",e);h.setStyles({display:"block","line-height":"16px","margin-left":"18px","white-space":"normal"});c.append(g);c.append(h);return c},r=function(b){var c=new s(b),b=document.getElementById("wscLang"+a.CKNumber),d=a.iframeNumber+"_"+a.dialog._.currentTabId;a.buildOptionLang(c.setLangList);q[c.getCurrentLangGroup(a.selectingLang)]();b.onchange=function(){q[c.getCurrentLangGroup(this.value)]();a.div_overlay.setEnable();a.selectingLang=this.value;f.postMessage.send({message:{changeLang:a.selectingLang,text:a.dataTemp},target:a.targetFromFrame[d],id:"selectionLang_outer__page"})}},v=function(b){if("no_any_suggestions"==b){b="No suggestions";a.LocalizationButton.ChangeTo.instance.disable();a.LocalizationButton.ChangeAll.instance.disable();var c=function(d){d=a.LocalizationButton[d].instance;d.getElement().hasClass("cke_disabled")?d.getElement().setStyle("color","#a0a0a0"):d.disable()};c("ChangeTo");c("ChangeAll")}else{a.LocalizationButton.ChangeTo.instance.enable(),a.LocalizationButton.ChangeAll.instance.enable(),a.LocalizationButton.ChangeTo.instance.getElement().setStyle("color","#333"),a.LocalizationButton.ChangeAll.instance.getElement().setStyle("color","#333")}return b},w={iframeOnload:function(){a.div_overlay.setEnable();var b=a.dialog._.currentTabId;p(a.targetFromFrame[a.iframeNumber+"_"+b],a.cmd[b])},suggestlist:function(b){delete b.id;a.div_overlay_no_check.setDisable();n();r(a.langList);"false"==a.show_grammar&&o();var c=v(b.word),d="";c instanceof Array&&(c=b.word[0]);d=c=c.split(",");l.clear();a.textNode.SpellTab.setValue(d[0]);for(b=0;b<d.length;b++){l.add(d[b],d[b])}j();a.div_overlay.setDisable()},grammerSuggest:function(b){delete b.id;delete b.mocklangs;n();var c=b.grammSuggest[0];a.grammerSuggest.getElement().setHtml("");a.textNode.GrammTab.reset();a.textNode.GrammTab.setValue(c);a.textNodeInfo.GrammTab.getElement().setHtml("");a.textNodeInfo.GrammTab.getElement().setText(b.info);for(var b=b.grammSuggest,c=b.length,d=!0,e=0;e<c;e++){a.grammerSuggest.getElement().append(u(b[e],b[e],d)),d=!1}j();a.div_overlay.setDisable()},thesaurusSuggest:function(b){delete b.id;delete b.mocklangs;n();a.selectNodeResponce=b;a.textNode.Thesaurus.reset();a.selectNode.categories.clear();for(var c in b){a.selectNode.categories.add(c,c)}b=a.selectNode.categories.getInputElement().getChildren().$[0].value;a.selectNode.categories.getInputElement().getChildren().$[0].selected=!0;a.buildOptionSynonyms(b);j();a.div_overlay.setDisable()},finish:function(b){delete b.id;a.dialog.getContentElement(a.dialog._.currentTabId,"bottomGroup").getElement().hide();a.dialog.getContentElement(a.dialog._.currentTabId,"BlockFinishChecking").getElement().show();a.div_overlay.setDisable()},settext:function(b){delete b.id;a.dialog.getParentEditor().focus();a.dialog.getParentEditor().setData(b.text,a.dataTemp="");a.dialog.hide()},ReplaceText:function(b){delete b.id;a.div_overlay.setEnable();a.dataTemp=b.text;a.selectingLang=b.currentLang;window.setTimeout(function(){a.div_overlay.setDisable()},500);i(a.LocalizationButton);t(a.LocalizationLabel)},options_checkbox_send:function(b){delete b.id;b={osp:f.cookie.get("osp"),udn:f.cookie.get("udn"),cust_dic_ids:a.cust_dic_ids};f.postMessage.send({message:b,target:a.targetFromFrame[a.iframeNumber+"_"+a.dialog._.currentTabId],id:"options_outer__page"})},getOptions:function(b){var c=b.DefOptions.udn;a.LocalizationComing=b.DefOptions.localizationButtonsAndText;a.show_grammar=b.show_grammar;a.langList=b.lang;if(a.bnr=b.bannerId){a.setHeightBannerFrame();var d=b.banner;a.dialog.getContentElement(a.dialog._.currentTabId,"banner").getElement().setHtml(d)}else{a.setHeightFrame()}"false"==a.show_grammar&&o();"undefined"==c&&(a.userDictionaryName?(c=a.userDictionaryName,d={osp:f.cookie.get("osp"),udn:a.userDictionaryName,cust_dic_ids:a.cust_dic_ids,id:"options_dic_send",udnCmd:"create"},f.postMessage.send({message:d,target:a.targetFromFrame[void 0]})):c="");f.cookie.set("osp",b.DefOptions.osp);f.cookie.set("udn",c);f.cookie.set("cust_dic_ids",b.DefOptions.cust_dic_ids);f.postMessage.send({id:"giveOptions"})},options_dic_send:function(){var b={osp:f.cookie.get("osp"),udn:f.cookie.get("udn"),cust_dic_ids:a.cust_dic_ids,id:"options_dic_send",udnCmd:f.cookie.get("udnCmd")};f.postMessage.send({message:b,target:a.targetFromFrame[a.iframeNumber+"_"+a.dialog._.currentTabId]})},data:function(b){delete b.id},giveOptions:function(){},setOptionsConfirmF:function(){},setOptionsConfirmT:function(){k.setValue("")},clickBusy:function(){a.div_overlay.setEnable()},suggestAllCame:function(){a.div_overlay.setDisable();a.div_overlay_no_check.setDisable()},TextCorrect:function(){r(a.langList)}},x=function(b){b=b||window.event;b=window.JSON.parse(b.data);w[b.id](b)},p=function(b,c,d,e){c=c||CKEDITOR.config.wsc_cmd||"spell";d=d||a.dataTemp;f.postMessage.send({message:{customerId:a.wsc_customerId,text:d,txt_ctrl:a.TextAreaNumber,cmd:c,cust_dic_ids:a.cust_dic_ids,udn:a.userDictionaryName,slang:a.selectingLang,reset_suggest:e||!1},target:b,id:"data_outer__page"});a.div_overlay.setEnable()},q={superset:function(){a.dialog.showPage("Thesaurus");a.dialog.showPage("GrammTab");a.dialog.showPage("SpellTab")},usual:function(){a.dialog.hidePage("Thesaurus");o();a.dialog.showPage("SpellTab")}},y=function(b){var c=new function(d){var e={};return{getCmdByTab:function(g){for(var h in d){e[d[h]]=h}return e[g]}}}(a.cmd);b.selectPage(c.getCmdByTab(CKEDITOR.config.wsc_cmd));a.sendData(b)},o=function(){a.dialog.hidePage("GrammTab")},j=function(){a.dialog.getContentElement(a.dialog._.currentTabId,"bottomGroup").getElement().show()},n=function(){a.dialog.getContentElement(a.dialog._.currentTabId,"BlockFinishChecking").getElement().hide()};a.CKNumber=CKEDITOR.tools.getNextNumber();CKEDITOR.dialog.add("checkspell",function(b){var c=function(){a.div_overlay.setEnable();var g=a.dialog._.currentTabId,h=a.iframeNumber+"_"+g,z=a.textNode[g].getValue();f.postMessage.send({message:{cmd:this.getElement().getAttribute("title-cmd"),tabId:g,new_word:z},target:a.targetFromFrame[h],id:"cmd_outer__page"});"FinishChecking"==this.getElement().getAttribute("title-cmd")&&b.config.wsc_onFinish.call(CKEDITOR.document.getWindow().getFrame())},d="file:"==document.location.protocol?"http:":document.location.protocol,e=CKEDITOR.config.wsc_customLoaderScript||d+"//loader.webspellchecker.net/sproxy_fck/sproxy.php?plugin=fck2&customerid="+CKEDITOR.config.wsc_customerId+"&cmd=script&doc=wsc&schema=22";return{title:b.config.wsc_dialogTitle||b.lang.wsc.title,minWidth:560,minHeight:444,buttons:[CKEDITOR.dialog.cancelButton],onShow:function(){a.dialog=this;a.TextAreaNumber="cke_textarea_"+CKEDITOR.currentInstance.name;f.postMessage.init(x);a.dataTemp=CKEDITOR.currentInstance.getData();a.OverlayPlace=a.dialog.parts.tabs.getParent().$;CKEDITOR.scriptLoader.load(e,function(g){CKEDITOR.config&&CKEDITOR.config.wsc&&CKEDITOR.config.wsc.DefaultParams?(a.serverLocationHash=CKEDITOR.config.wsc.DefaultParams.serviceHost,a.logotype=CKEDITOR.config.wsc.DefaultParams.logoPath,a.loadIcon=CKEDITOR.config.wsc.DefaultParams.iconPath,a.loadIconEmptyEditor=CKEDITOR.config.wsc.DefaultParams.iconPathEmptyEditor,a.LangComparer=new CKEDITOR.config.wsc.DefaultParams._SP_FCK_LangCompare):(a.serverLocationHash=DefaultParams.serviceHost,a.logotype=DefaultParams.logoPath,a.loadIcon=DefaultParams.iconPath,a.loadIconEmptyEditor=DefaultParams.iconPathEmptyEditor,a.LangComparer=new _SP_FCK_LangCompare);a.pluginPath=CKEDITOR.getUrl(b.plugins.wsc.path);a.iframeNumber=a.TextAreaNumber;a.serverLocation="#server="+a.serverLocationHash;a.templatePath=a.pluginPath+"dialogs/tmp.html";a.LangComparer.setDefaulLangCode(a.defaultLanguage);a.currentLang=b.config.wsc_lang||a.LangComparer.getSPLangCode(b.langCode);a.div_overlay=new m({opacity:"1",background:"#fff url("+a.loadIcon+") no-repeat 50% 50%",target:a.OverlayPlace});var h=CKEDITOR.document.getById("cke_dialog_tabs_"+(a.CKNumber+1));h.setStyle("width","97%");h.getElementsByTag("DIV").count()||h.append(a.buildSelectLang());a.div_overlay_no_check=new m({opacity:"1",id:"no_check_over",background:"#fff url("+a.loadIconEmptyEditor+") no-repeat 50% 50%",target:a.OverlayPlace});g&&(y(a.dialog),a.dialog.setupContent(a.dialog))})},onHide:function(){a.dataTemp=""},contents:[{id:"SpellTab",label:"SpellChecker",accessKey:"S",elements:[{type:"html",id:"banner",label:"banner",style:"",html:"<div></div>"},{type:"html",id:"Content",label:"spellContent",html:"",setup:function(h){var h=a.iframeNumber+"_"+h._.currentTabId,g=document.getElementById(h);a.targetFromFrame[h]=g.contentWindow}},{type:"hbox",id:"bottomGroup",style:"width:560px; margin: 0 auto;",widths:["50%","50%"],children:[{type:"hbox",id:"leftCol",align:"left",width:"50%",children:[{type:"vbox",id:"rightCol1",widths:["50%","50%"],children:[{type:"text",id:"text",label:a.LocalizationLabel.ChangeTo.text+":",labelLayout:"horizontal",labelStyle:"font: 12px/25px arial, sans-serif;",width:"140px","default":"",onShow:function(){a.textNode.SpellTab=this;a.LocalizationLabel.ChangeTo.instance=this},onHide:function(){this.reset()}},{type:"hbox",id:"rightCol",align:"right",width:"30%",children:[{type:"vbox",id:"rightCol_col__left",children:[{type:"text",id:"labelSuggestions",label:a.LocalizationLabel.Suggestions.text+":",onShow:function(){a.LocalizationLabel.Suggestions.instance=this;this.getInputElement().hide()}},{type:"html",id:"logo",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">',setup:function(){this.getElement().$.src=a.logotype;this.getElement().getParent().setStyles({"text-align":"left"})}}]},{type:"select",id:"list_of_suggestions",labelStyle:"font: 12px/25px arial, sans-serif;",size:"6",inputStyle:"width: 140px; height: auto;",items:[["loading..."]],onShow:function(){l=this},onHide:function(){this.clear()},onChange:function(){a.textNode.SpellTab.setValue(this.getValue())}}]}]}]},{type:"hbox",id:"rightCol",align:"right",width:"50%",children:[{type:"vbox",id:"rightCol_col__left",widths:["50%","50%","50%","50%"],children:[{type:"button",id:"ChangeTo",label:a.LocalizationButton.ChangeTo.text,title:"Change to",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id);a.LocalizationButton.ChangeTo.instance=this},onClick:c},{type:"button",id:"ChangeAll",label:a.LocalizationButton.ChangeAll.text,title:"Change All",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id);a.LocalizationButton.ChangeAll.instance=this},onClick:c},{type:"button",id:"AddWord",label:a.LocalizationButton.AddWord.text,title:"Add word",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id);a.LocalizationButton.AddWord.instance=this},onClick:c},{type:"button",id:"FinishChecking",label:a.LocalizationButton.FinishChecking.text,title:"Finish Checking",style:"width: 100%;margin-top: 9px;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id);a.LocalizationButton.FinishChecking.instance=this},onClick:c}]},{type:"vbox",id:"rightCol_col__right",widths:["50%","50%","50%"],children:[{type:"button",id:"IgnoreWord",label:a.LocalizationButton.IgnoreWord.text,title:"Ignore word",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id);a.LocalizationButton.IgnoreWord.instance=this},onClick:c},{type:"button",id:"IgnoreAllWords",label:a.LocalizationButton.IgnoreAllWords.text,title:"Ignore all words",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id);a.LocalizationButton.IgnoreAllWords.instance=this},onClick:c},{type:"button",id:"option",label:a.LocalizationButton.Options.text,title:"Option",style:"width: 100%;",onLoad:function(){a.LocalizationButton.Options.instance=this;"file:"==document.location.protocol&&this.disable()},onClick:function(){"file:"==document.location.protocol?alert("WSC: Options functionality is disabled when runing from file system"):b.openDialog("options")}}]}]}]},{type:"hbox",id:"BlockFinishChecking",style:"width:560px; margin: 0 auto;",widths:["70%","30%"],onShow:function(){this.getElement().hide()},onHide:j,children:[{type:"hbox",id:"leftCol",align:"left",width:"70%",children:[{type:"vbox",id:"rightCol1",setup:function(){this.getChild()[0].getElement().$.src=a.logotype;this.getChild()[0].getElement().getParent().setStyles({"text-align":"center"})},children:[{type:"html",id:"logo",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">'}]}]},{type:"hbox",id:"rightCol",align:"right",width:"30%",children:[{type:"vbox",id:"rightCol_col__left",children:[{type:"button",id:"Option_button",label:a.LocalizationButton.Options.text,title:"Option",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id);"file:"==document.location.protocol&&this.disable()},onClick:function(){"file:"==document.location.protocol?alert("WSC: Options functionality is disabled when runing from file system"):b.openDialog("options")}},{type:"button",id:"FinishChecking",label:a.LocalizationButton.FinishChecking.text,title:"Finish Checking",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c}]}]}]}]},{id:"GrammTab",label:"Grammar",accessKey:"G",elements:[{type:"html",id:"banner",label:"banner",style:"",html:"<div></div>"},{type:"html",id:"Content",label:"GrammarContent",html:"",setup:function(){var h=a.iframeNumber+"_"+a.dialog._.currentTabId,g=document.getElementById(h);a.targetFromFrame[h]=g.contentWindow}},{type:"vbox",id:"bottomGroup",style:"width:560px; margin: 0 auto;",children:[{type:"hbox",id:"leftCol",widths:["66%","34%"],children:[{type:"vbox",children:[{type:"text",id:"text",label:"Change to:",labelLayout:"horizontal",labelStyle:"font: 12px/25px arial, sans-serif;",inputStyle:"float: right; width: 200px;","default":"",onShow:function(){a.textNode.GrammTab=this},onHide:function(){this.reset()}},{type:"html",id:"html_text",html:"<div style='min-height: 17px; line-height: 17px; padding: 5px; text-align: left;background: #F1F1F1;color: #595959; white-space: normal!important;'></div>",onShow:function(){a.textNodeInfo.GrammTab=this}},{type:"html",id:"radio",html:"",onShow:function(){a.grammerSuggest=this}}]},{type:"vbox",children:[{type:"button",id:"ChangeTo",label:"Change to",title:"Change to",style:"width: 133px; float: right;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c},{type:"button",id:"IgnoreWord",label:"Ignore word",title:"Ignore word",style:"width: 133px; float: right;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c},{type:"button",id:"IgnoreAllWords",label:"Ignore Problem",title:"Ignore Problem",style:"width: 133px; float: right;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c},{type:"button",id:"FinishChecking",label:"Finish Checking",title:"Finish Checking",style:"width: 133px; float: right; margin-top: 9px;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c}]}]}]},{type:"hbox",id:"BlockFinishChecking",style:"width:560px; margin: 0 auto;",widths:["70%","30%"],onShow:function(){this.getElement().hide()},onHide:j,children:[{type:"hbox",id:"leftCol",align:"left",width:"70%",children:[{type:"vbox",id:"rightCol1",children:[{type:"html",id:"logo",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">',setup:function(){this.getElement().$.src=a.logotype;this.getElement().getParent().setStyles({"text-align":"center"})}}]}]},{type:"hbox",id:"rightCol",align:"right",width:"30%",children:[{type:"vbox",id:"rightCol_col__left",children:[{type:"button",id:"FinishChecking",label:"Finish Checking",title:"Finish Checking",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c}]}]}]}]},{id:"Thesaurus",label:"Thesaurus",accessKey:"T",elements:[{type:"html",id:"banner",label:"banner",style:"",html:"<div></div>"},{type:"html",id:"Content",label:"spellContent",html:"",setup:function(){var h=a.iframeNumber+"_"+a.dialog._.currentTabId,g=document.getElementById(h);a.targetFromFrame[h]=g.contentWindow}},{type:"vbox",id:"bottomGroup",style:"width:560px; margin: 0 auto;",children:[{type:"hbox",widths:["75%","25%"],children:[{type:"vbox",children:[{type:"hbox",widths:["65%","35%"],children:[{type:"text",id:"ChangeTo",label:"Change to:",labelLayout:"horizontal",inputStyle:"width: 160px;",labelStyle:"font: 12px/25px arial, sans-serif;","default":"",onShow:function(){a.textNode.Thesaurus=this},onHide:function(){this.reset()}},{type:"button",id:"ChangeTo",label:"Change to",title:"Change to",style:"width: 121px; margin-top: 1px;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c}]},{type:"hbox",children:[{type:"select",id:"categories",label:"Categories:",labelStyle:"font: 12px/25px arial, sans-serif;",size:"5",inputStyle:"width: 180px; height: auto;",items:[],onShow:function(){a.selectNode.categories=this},onHide:function(){this.clear()},onChange:function(){a.buildOptionSynonyms(this.getValue())}},{type:"select",id:"synonyms",label:"Synonyms:",labelStyle:"font: 12px/25px arial, sans-serif;",size:"5",inputStyle:"width: 180px; height: auto;",items:[],onShow:function(){a.selectNode.synonyms=this;a.textNode.Thesaurus.setValue(this.getValue())},onHide:function(){this.clear()},onChange:function(){a.textNode.Thesaurus.setValue(this.getValue())}}]}]},{type:"vbox",width:"120px",style:"margin-top:46px;",children:[{type:"html",id:"logotype",label:"WebSpellChecker.net",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">',setup:function(){this.getElement().$.src=a.logotype;this.getElement().getParent().setStyles({"text-align":"center"})}},{type:"button",id:"FinishChecking",label:"Finish Checking",title:"Finish Checking",style:"width: 121px; float: right; margin-top: 9px;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c}]}]}]},{type:"hbox",id:"BlockFinishChecking",style:"width:560px; margin: 0 auto;",widths:["70%","30%"],onShow:function(){this.getElement().hide()},children:[{type:"hbox",id:"leftCol",align:"left",width:"70%",children:[{type:"vbox",id:"rightCol1",children:[{type:"html",id:"logo",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">',setup:function(){this.getElement().$.src=a.logotype;this.getElement().getParent().setStyles({"text-align":"center"})}}]}]},{type:"hbox",id:"rightCol",align:"right",width:"30%",children:[{type:"vbox",id:"rightCol_col__left",children:[{type:"button",id:"FinishChecking",label:"Finish Checking",title:"Finish Checking",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:c}]}]}]}]}]}});CKEDITOR.dialog.add("options",function(){var d=null,z={},b={},c=null,e=null;f.cookie.get("udn");f.cookie.get("osp");var g=function(){e=this.getElement().getAttribute("title-cmd");var A=[];A[0]=b.IgnoreAllCapsWords;A[1]=b.IgnoreWordsNumbers;A[2]=b.IgnoreMixedCaseWords;A[3]=b.IgnoreDomainNames;A=A.toString().replace(/,/g,"");f.cookie.set("osp",A);f.cookie.set("udnCmd",e?e:"ignore");"delete"!=e&&(A="",""!==k.getValue()&&(A=k.getValue()),f.cookie.set("udn",A));f.postMessage.send({id:"options_dic_send"})},h=function(){c.getElement().setHtml(a.LocalizationComing.error);c.getElement().show()};return{title:a.LocalizationComing.Options,minWidth:430,minHeight:130,resizable:CKEDITOR.DIALOG_RESIZE_NONE,contents:[{id:"OptionsTab",label:"Options",accessKey:"O",elements:[{type:"hbox",id:"options_error",children:[{type:"html",style:"display: block;text-align: center;white-space: normal!important; font-size: 12px;color:red",html:"<div></div>",onShow:function(){c=this}}]},{type:"vbox",id:"Options_content",children:[{type:"hbox",id:"Options_manager",widths:["52%","48%"],children:[{type:"fieldset",label:"Spell Checking Options",style:"border: none;margin-top: 13px;padding: 10px 0 10px 10px",onShow:function(){this.getInputElement().$.children[0].innerHTML=a.LocalizationComing.SpellCheckingOptions},children:[{type:"vbox",id:"Options_checkbox",children:[{type:"checkbox",id:"IgnoreAllCapsWords",label:"Ignore All-Caps Words",labelStyle:"margin-left: 5px; font: 12px/16px arial, sans-serif;display: inline-block;white-space: normal;",style:"float:left; min-height: 16px;","default":"",onClick:function(){b[this.id]=!this.getValue()?0:1}},{type:"checkbox",id:"IgnoreWordsNumbers",label:"Ignore Words with Numbers",labelStyle:"margin-left: 5px; font: 12px/16px arial, sans-serif;display: inline-block;white-space: normal;",style:"float:left; min-height: 16px;","default":"",onClick:function(){b[this.id]=!this.getValue()?0:1}},{type:"checkbox",id:"IgnoreMixedCaseWords",label:"Ignore Mixed-Case Words",labelStyle:"margin-left: 5px; font: 12px/16px arial, sans-serif;display: inline-block;white-space: normal;",style:"float:left; min-height: 16px;","default":"",onClick:function(){b[this.id]=!this.getValue()?0:1}},{type:"checkbox",id:"IgnoreDomainNames",label:"Ignore Domain Names",labelStyle:"margin-left: 5px; font: 12px/16px arial, sans-serif;display: inline-block;white-space: normal;",style:"float:left; min-height: 16px;","default":"",onClick:function(){b[this.id]=!this.getValue()?0:1}}]}]},{type:"vbox",id:"Options_DictionaryName",children:[{type:"text",id:"DictionaryName",style:"margin-bottom: 10px",label:"Dictionary Name:",labelLayout:"vertical",labelStyle:"font: 12px/25px arial, sans-serif;","default":"",onLoad:function(){k=this;this.setValue(a.userDictionaryName?a.userDictionaryName:(f.cookie.get("udn"),this.getValue()))},onShow:function(){k=this;this.setValue(!f.cookie.get("udn")?this.getValue():f.cookie.get("udn"));this.setLabel(a.LocalizationComing.DictionaryName)},onHide:function(){this.reset()}},{type:"hbox",id:"Options_buttons",children:[{type:"vbox",id:"Options_leftCol_col",widths:["50%","50%"],children:[{type:"button",id:"create",label:"Create",title:"Create",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onShow:function(){this.getElement().setText(a.LocalizationComing.Create)},onClick:g},{type:"button",id:"restore",label:"Restore",title:"Restore",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onShow:function(){this.getElement().setText(a.LocalizationComing.Restore)},onClick:g}]},{type:"vbox",id:"Options_rightCol_col",widths:["50%","50%"],children:[{type:"button",id:"rename",label:"Rename",title:"Rename",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onShow:function(){this.getElement().setText(a.LocalizationComing.Rename)},onClick:g},{type:"button",id:"delete",label:"Remove",title:"Remove",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onShow:function(){this.getElement().setText(a.LocalizationComing.Remove)},onClick:g}]}]}]}]},{type:"hbox",id:"Options_text",children:[{type:"html",style:"text-align: justify;margin-top: 15px;white-space: normal!important; font-size: 12px;color:#777;",html:"<div>"+a.LocalizationComing.OptionsTextIntro+"</div>",onShow:function(){this.getElement().setText(a.LocalizationComing.OptionsTextIntro)}}]}]}]}],buttons:[CKEDITOR.dialog.okButton,CKEDITOR.dialog.cancelButton],onOk:function(){var A=[];A[0]=b.IgnoreAllCapsWords;A[1]=b.IgnoreWordsNumbers;A[2]=b.IgnoreMixedCaseWords;A[3]=b.IgnoreDomainNames;A=A.toString().replace(/,/g,"");f.cookie.set("osp",A);f.cookie.set("udn",k.getValue());f.postMessage.send({id:"options_checkbox_send"});c.getElement().hide();c.getElement().setHtml(" ")},onLoad:function(){d=this;f.postMessage.init(h);z.IgnoreAllCapsWords=d.getContentElement("OptionsTab","IgnoreAllCapsWords");z.IgnoreWordsNumbers=d.getContentElement("OptionsTab","IgnoreWordsNumbers");z.IgnoreMixedCaseWords=d.getContentElement("OptionsTab","IgnoreMixedCaseWords");z.IgnoreDomainNames=d.getContentElement("OptionsTab","IgnoreDomainNames")},onShow:function(){var A=f.cookie.get("osp").split("");b.IgnoreAllCapsWords=A[0];b.IgnoreWordsNumbers=A[1];b.IgnoreMixedCaseWords=A[2];b.IgnoreDomainNames=A[3];!parseInt(b.IgnoreAllCapsWords,10)?z.IgnoreAllCapsWords.setValue("",!1):z.IgnoreAllCapsWords.setValue("checked",!1);!parseInt(b.IgnoreWordsNumbers,10)?z.IgnoreWordsNumbers.setValue("",!1):z.IgnoreWordsNumbers.setValue("checked",!1);!parseInt(b.IgnoreMixedCaseWords,10)?z.IgnoreMixedCaseWords.setValue("",!1):z.IgnoreMixedCaseWords.setValue("checked",!1);!parseInt(b.IgnoreDomainNames,10)?z.IgnoreDomainNames.setValue("",!1):z.IgnoreDomainNames.setValue("checked",!1);b.IgnoreAllCapsWords=!z.IgnoreAllCapsWords.getValue()?0:1;b.IgnoreWordsNumbers=!z.IgnoreWordsNumbers.getValue()?0:1;b.IgnoreMixedCaseWords=!z.IgnoreMixedCaseWords.getValue()?0:1;b.IgnoreDomainNames=!z.IgnoreDomainNames.getValue()?0:1;z.IgnoreAllCapsWords.getElement().$.lastChild.innerHTML=a.LocalizationComing.IgnoreAllCapsWords;z.IgnoreWordsNumbers.getElement().$.lastChild.innerHTML=a.LocalizationComing.IgnoreWordsWithNumbers;z.IgnoreMixedCaseWords.getElement().$.lastChild.innerHTML=a.LocalizationComing.IgnoreMixedCaseWords;z.IgnoreDomainNames.getElement().$.lastChild.innerHTML=a.LocalizationComing.IgnoreDomainNames}}});CKEDITOR.dialog.on("resize",function(b){var b=b.data,c=b.dialog,d=CKEDITOR.document.getById(a.iframeNumber+"_"+c._.currentTabId);"checkspell"==c._.name&&(a.bnr?d&&d.setSize("height",b.height-310):d&&d.setSize("height",b.height-220))});CKEDITOR.on("dialogDefinition",function(b){var c=b.data.definition;a.onLoadOverlay=new m({opacity:"1",background:"#fff",target:c.dialog.parts.tabs.getParent().$});a.onLoadOverlay.setEnable();c.dialog.on("show",function(){});c.dialog.on("cancel",function(){c.dialog.getParentEditor().config.wsc_onClose.call(this.document.getWindow().getFrame());a.div_overlay.setDisable();return !1},this,null,-1)})})();