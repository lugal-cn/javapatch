(function(d,b){if(d.cleanData){var a=d.cleanData;d.cleanData=function(g){for(var h=0,e;(e=g[h])!=null;h++){try{d(e).triggerHandler("remove")}catch(f){}}a(g)}}else{var c=d.fn.remove;d.fn.remove=function(e,f){return this.each(function(){if(!f){if(!e||d.filter(e,[this]).length){d("*",this).add([this]).each(function(){try{d(this).triggerHandler("remove")}catch(g){}})}}return c.call(d(this),e,f)})}}d.widget=function(h,j,g){var i=h.split(".")[0],f;h=h.split(".")[1];f=i+"-"+h;if(!g){g=j;j=d.Widget}d.expr[":"][f]=function(k){return !!d.data(k,h)};d[i]=d[i]||{};d[i][h]=function(k,l){if(arguments.length){this._createWidget(k,l)}};var e=new j();e.options=d.extend(true,{},e.options);d[i][h].prototype=d.extend(true,e,{namespace:i,widgetName:h,widgetEventPrefix:d[i][h].prototype.widgetEventPrefix||h,widgetBaseClass:f},g);d.widget.bridge(h,d[i][h])};d.widget.bridge=function(f,e){d.fn[f]=function(i){var g=typeof i==="string",h=Array.prototype.slice.call(arguments,1),j=this;i=!g&&h.length?d.extend.apply(null,[true,i].concat(h)):i;if(g&&i.charAt(0)==="_"){return j}if(g){this.each(function(){var k=d.data(this,f),l=k&&d.isFunction(k[i])?k[i].apply(k,h):k;if(l!==k&&l!==b){j=l;return false}})}else{this.each(function(){var k=d.data(this,f);if(k){k.option(i||{})._init()}else{d.data(this,f,new e(i,this))}})}return j}};d.Widget=function(e,f){if(arguments.length){this._createWidget(e,f)}};d.Widget.prototype={widgetName:"widget",widgetEventPrefix:"",options:{disabled:false},_createWidget:function(e,f){d.data(f,this.widgetName,this);this.element=d(f);this.options=d.extend(true,{},this.options,this._getCreateOptions(),e);var g=this;this.element.bind("remove."+this.widgetName,function(){g.destroy()});this._create();this._trigger("create");this._init()},_getCreateOptions:function(){return d.metadata&&d.metadata.get(this.element[0])[this.widgetName]},_create:function(){},_init:function(){},destroy:function(){this.element.unbind("."+this.widgetName).removeData(this.widgetName);this.widget().unbind("."+this.widgetName).removeAttr("aria-disabled").removeClass(this.widgetBaseClass+"-disabled ui-state-disabled")},widget:function(){return this.element},option:function(e,f){var g=e;if(arguments.length===0){return d.extend({},this.options)}if(typeof e==="string"){if(f===b){return this.options[e]}g={};g[e]=f}this._setOptions(g);return this},_setOptions:function(f){var e=this;d.each(f,function(g,h){e._setOption(g,h)});return this},_setOption:function(e,f){this.options[e]=f;if(e==="disabled"){this.widget()[f?"addClass":"removeClass"](this.widgetBaseClass+"-disabled ui-state-disabled").attr("aria-disabled",f)}return this},enable:function(){return this._setOption("disabled",false)},disable:function(){return this._setOption("disabled",true)},_trigger:function(h,j,k){var g=this.options[h];j=d.Event(j);j.type=(h===this.widgetEventPrefix?h:this.widgetEventPrefix+h).toLowerCase();k=k||{};if(j.originalEvent){for(var f=d.event.props.length,e;f;){e=d.event.props[--f];j[e]=j.originalEvent[e]}}this.element.trigger(j,k);return !(d.isFunction(g)&&g.call(this.element[0],j,k)===false||j.isDefaultPrevented())}}})(jQuery);