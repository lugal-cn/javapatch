CKEDITOR.dialog.add("radio",function(b){return{title:b.lang.forms.checkboxAndRadio.radioTitle,minWidth:350,minHeight:140,onShow:function(){delete this.radioButton;var a=this.getParentEditor().getSelection().getSelectedElement();a&&("input"==a.getName()&&"radio"==a.getAttribute("type"))&&(this.radioButton=a,this.setupContent(a))},onOk:function(){var c,g=this.radioButton,a=!g;a&&(c=this.getParentEditor(),g=c.document.createElement("input"),g.setAttribute("type","radio"));a&&c.insertElement(g);this.commitContent({element:g})},contents:[{id:"info",label:b.lang.forms.checkboxAndRadio.radioTitle,title:b.lang.forms.checkboxAndRadio.radioTitle,elements:[{id:"name",type:"text",label:b.lang.common.name,"default":"",accessKey:"N",setup:function(a){this.setValue(a.data("cke-saved-name")||a.getAttribute("name")||"")},commit:function(a){a=a.element;this.getValue()?a.data("cke-saved-name",this.getValue()):(a.data("cke-saved-name",!1),a.removeAttribute("name"))}},{id:"value",type:"text",label:b.lang.forms.checkboxAndRadio.value,"default":"",accessKey:"V",setup:function(a){this.setValue(a.getAttribute("value")||"")},commit:function(a){a=a.element;this.getValue()?a.setAttribute("value",this.getValue()):a.removeAttribute("value")}},{id:"checked",type:"checkbox",label:b.lang.forms.checkboxAndRadio.selected,"default":"",accessKey:"S",value:"checked",setup:function(a){this.setValue(a.getAttribute("checked"))},commit:function(e){var i=e.element;if(!CKEDITOR.env.ie&&!CKEDITOR.env.opera){this.getValue()?i.setAttribute("checked","checked"):i.removeAttribute("checked")}else{var a=i.getAttribute("checked"),c=!!this.getValue();a!=c&&(a=CKEDITOR.dom.element.createFromHtml('<input type="radio"'+(c?' checked="checked"':"")+"></input>",b.document),i.copyAttributes(a,{type:1,checked:1}),a.replace(i),b.getSelection().selectElement(a),e.element=a)}}}]}]}});