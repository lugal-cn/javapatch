/*!
 * CityPicker v1.0.2
 * https://github.com/tshi0912/citypicker
 *
 * Copyright (c) 2015-2016 Tao Shi
 * Released under the MIT license
 *
 * Date: 2016-02-29T12:11:36.477Z
 */
(function(b){if(typeof define==="function"&&define.amd){define(["jquery","ChineseDistricts"],b)}else{if(typeof exports==="object"){b(require("jquery"),require("ChineseDistricts"))}else{b(jQuery,ChineseDistricts)}}})(function(k,n){if(typeof n==="undefined"){throw new Error('The file "city-picker.data.js" must be included first!')}var j="citypicker";var o="change."+j;var l="province";var i="city";var p="district";function m(a,b){this.$element=k(a);this.$dropdown=null;this.options=k.extend({},m.DEFAULTS,k.isPlainObject(b)&&b);this.active=false;this.dems=[];this.needBlur=false;this.init()}m.prototype={constructor:m,init:function(){this.defineDems();this.render();this.bind();this.active=true},render:function(){var c=this.getPosition(),b=this.$element.attr("placeholder")||this.options.placeholder,e='<span class="city-picker-span" style="'+this.getWidthStyle(c.width)+"height:"+c.height+"px;line-height:"+(c.height-1)+'px;">'+(b?'<span class="placeholder">'+b+"</span>":"")+'<span class="title"></span><div class="arrow"></div></span>',a='<div class="city-picker-dropdown" style="left:0px;top:100%;'+this.getWidthStyle(c.width,true)+'"><div class="city-select-wrap"><div class="city-select-tab"><a class="active" data-count="province">省份</a>'+(this.includeDem("city")?'<a data-count="city">城市</a>':"")+(this.includeDem("district")?'<a data-count="district">区县</a>':"")+'</div><div class="city-select-content"><div class="city-select province" data-count="province"></div>'+(this.includeDem("city")?'<div class="city-select city" data-count="city"></div>':"")+(this.includeDem("district")?'<div class="city-select district" data-count="district"></div>':"")+"</div></div>";this.$element.addClass("city-picker-input");this.$textspan=k(e).insertAfter(this.$element);this.$dropdown=k(a).insertAfter(this.$textspan);var d=this.$dropdown.find(".city-select");k.each(this.dems,k.proxy(function(g,f){this["$"+f]=d.filter("."+f+"")},this));this.refresh()},refresh:function(b){var c=this.$dropdown.find(".city-select");c.data("item",null);var a=this.$element.val()||"";a=a.split("/");k.each(this.dems,k.proxy(function(e,d){if(a[e]&&e<a.length){this.options[d]=a[e]}else{if(b){this.options[d]=""}}this.output(d)},this));this.tab(l);this.feedText();this.feedVal()},defineDems:function(){var a=false;k.each([l,i,p],k.proxy(function(c,b){if(!a){this.dems.push(b)}if(b===this.options.level){a=true}},this))},includeDem:function(a){return k.inArray(a,this.dems)!==-1},getPosition:function(){var a,b,e,c,d;a=this.$element.position();c=this.getSize(this.$element);b=c.height;e=c.width;if(this.options.responsive){d=this.$element.offsetParent().width();if(d){e=e/d;if(e>0.99){e=1}e=e*100+"%"}}return{top:a.top||0,left:a.left||0,height:b,width:e}},getSize:function(d){var c,a,b;if(!d.is(":visible")){c=k("<div />").appendTo(k("body"));c.css({position:"absolute !important",visibility:"hidden !important",display:"block !important"});a=d.clone().appendTo(c);b={width:a.outerWidth(),height:a.outerHeight()};c.remove()}else{b={width:d.outerWidth(),height:d.outerHeight()}}return b},getWidthStyle:function(b,a){if(this.options.responsive&&!k.isNumeric(b)){return"width:"+b+";"}else{return"width:"+(a?Math.max(320,b):b)+"px;"}},bind:function(){var a=this;k(document).on("click",(this._mouteclick=function(b){var e=k(b.target);var c,d,f;if(e.is(".city-picker-span")){d=e}else{if(e.is(".city-picker-span *")){d=e.parents(".city-picker-span")}}if(e.is(".city-picker-input")){f=e}if(e.is(".city-picker-dropdown")){c=e}else{if(e.is(".city-picker-dropdown *")){c=e.parents(".city-picker-dropdown")}}if((!f&&!d&&!c)||(d&&d.get(0)!==a.$textspan.get(0))||(f&&f.get(0)!==a.$element.get(0))||(c&&c.get(0)!==a.$dropdown.get(0))){a.close(true)}}));this.$element.on("change",(this._changeElement=k.proxy(function(){this.close(true);this.refresh(true)},this))).on("focus",(this._focusElement=k.proxy(function(){this.needBlur=true;this.open()},this))).on("blur",(this._blurElement=k.proxy(function(){if(this.needBlur){this.needBlur=false;this.close(true)}},this)));this.$textspan.on("click",function(b){var d=k(b.target),c;a.needBlur=false;if(d.is(".select-item")){c=d.data("count");a.open(c)}else{if(a.$dropdown.is(":visible")){a.close()}else{a.open()}}}).on("mousedown",function(){a.needBlur=false});this.$dropdown.on("click",".city-select a",function(){var c=k(this).parents(".city-select");var d=c.find("a.active");var b=c.next().length===0;d.removeClass("active");k(this).addClass("active");if(d.data("code")!==k(this).data("code")){c.data("item",{address:k(this).attr("title"),code:k(this).data("code")});k(this).trigger(o);a.feedText();a.feedVal();if(b){a.close()}}}).on("click",".city-select-tab a",function(){if(!k(this).hasClass("active")){var b=k(this).data("count");a.tab(b)}}).on("mousedown",function(){a.needBlur=false});if(this.$province){this.$province.on(o,(this._changeProvince=k.proxy(function(){this.output(i);this.output(p);this.tab(i)},this)))}if(this.$city){this.$city.on(o,(this._changeCity=k.proxy(function(){this.output(p);this.tab(p)},this)))}},open:function(a){a=a||l;this.$dropdown.show();this.$textspan.addClass("open").addClass("focus");this.tab(a)},close:function(a){this.$dropdown.hide();this.$textspan.removeClass("open");if(a){this.$textspan.removeClass("focus")}},unbind:function(){k(document).off("click",this._mouteclick);this.$element.off("change",this._changeElement);this.$element.off("focus",this._focusElement);this.$element.off("blur",this._blurElement);this.$textspan.off("click");this.$textspan.off("mousedown");this.$dropdown.off("click");this.$dropdown.off("mousedown");if(this.$province){this.$province.off(o,this._changeProvince)}if(this.$city){this.$city.off(o,this._changeCity)}},getText:function(){var a="";this.$dropdown.find(".city-select").each(function(){var b=k(this).data("item"),c=k(this).data("count");if(b){a+=(k(this).hasClass("province")?"":"/")+'<span class="select-item" data-count="'+c+'" data-code="'+b.code+'">'+b.address+"</span>"}});return a},getPlaceHolder:function(){return this.$element.attr("placeholder")||this.options.placeholder},feedText:function(){var a=this.getText();if(a){this.$textspan.find(">.placeholder").hide();this.$textspan.find(">.title").html(this.getText()).show()}else{this.$textspan.find(">.placeholder").text(this.getPlaceHolder()).show();this.$textspan.find(">.title").html("").hide()}},getVal:function(){var a="";this.$dropdown.find(".city-select").each(function(){var b=k(this).data("item");if(b){a+=(k(this).hasClass("province")?"":"/")+b.address}});return a},feedVal:function(){this.$element.val(this.getVal())},output:function(d){var a=this.options;var f=this["$"+d];var e=d===l?{}:[];var b;var g;var r;var h=null;var c;if(!f||!f.length){return}b=f.data("item");c=(b?b.address:null)||a[d];r=(d===l?86:d===i?this.$province&&this.$province.find(".active").data("code"):d===p?this.$city&&this.$city.find(".active").data("code"):r);g=k.isNumeric(r)?n[r]:null;if(k.isPlainObject(g)){k.each(g,function(q,x){var v;if(d===l){v=[];for(var w=0;w<x.length;w++){if(x[w].address===c){h={code:x[w].code,address:x[w].address}}v.push({code:x[w].code,address:x[w].address,selected:x[w].address===c})}e[q]=v}else{if(x===c){h={code:q,address:x}}e.push({code:q,address:x,selected:x===c})}})}f.html(d===l?this.getProvinceList(e):this.getList(e,d));f.data("item",h)},getProvinceList:function(c){var d=[],b=this,a=this.options.simple;k.each(c,function(e,f){d.push('<dl class="clearfix">');d.push("<dt>"+e+"</dt><dd>");k.each(f,function(g,h){d.push('<a title="'+(h.address||"")+'" data-code="'+(h.code||"")+'" class="'+(h.selected?" active":"")+'">'+(a?b.simplize(h.address,l):h.address)+"</a>")});d.push("</dd></dl>")});return d.join("")},getList:function(c,e){var d=[],b=this,a=this.options.simple;d.push('<dl class="clearfix"><dd>');k.each(c,function(g,f){d.push('<a title="'+(f.address||"")+'" data-code="'+(f.code||"")+'" class="'+(f.selected?" active":"")+'">'+(a?b.simplize(f.address,e):f.address)+"</a>")});d.push("</dd></dl>");return d.join("")},simplize:function(b,a){b=b||"";if(a===l){return b.replace(/[省,市,自治区,壮族,回族,维吾尔]/g,"")}else{if(a===i){return b.replace(/[市,地区,回族,蒙古,苗族,白族,傣族,景颇族,藏族,彝族,壮族,傈僳族,布依族,侗族]/g,"").replace("哈萨克","").replace("自治州","").replace(/自治县/,"")}else{if(a===p){return b.length>2?b.replace(/[市,区,县,旗]/g,""):b}}}},tab:function(b){var c=this.$dropdown.find(".city-select");var e=this.$dropdown.find(".city-select-tab > a");var d=this["$"+b];var a=this.$dropdown.find('.city-select-tab > a[data-count="'+b+'"]');if(d){c.hide();d.show();e.removeClass("active");a.addClass("active")}},reset:function(){this.$element.val(null).trigger("change")},destroy:function(){this.unbind();this.$element.removeData(j).removeClass("city-picker-input");this.$textspan.remove();this.$dropdown.remove()}};m.DEFAULTS={simple:false,responsive:false,placeholder:"请选择省/市/区",level:"district",province:"",city:"",district:""};m.setDefaults=function(a){k.extend(m.DEFAULTS,a)};m.other=k.fn.citypicker;k.fn.citypicker=function(a){var b=[].slice.call(arguments,1);return this.each(function(){var f=k(this);var c=f.data(j);var e;var d;if(!c){if(/destroy/.test(a)){return}e=k.extend({},f.data(),k.isPlainObject(a)&&a);f.data(j,(c=new m(this,e)))}if(typeof a==="string"&&k.isFunction(d=c[a])){d.apply(c,b)}})};k.fn.citypicker.Constructor=m;k.fn.citypicker.setDefaults=m.setDefaults;k.fn.citypicker.noConflict=function(){k.fn.citypicker=m.other;return this};k(function(){k('[data-toggle="city-picker"]').citypicker()})});