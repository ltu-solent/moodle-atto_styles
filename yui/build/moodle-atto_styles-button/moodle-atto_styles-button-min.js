YUI.add("moodle-atto_styles-button",function(e,t){var n="atto_styles";e.namespace("M.atto_styles").Button=e.Base.create("button",e.M.editor_atto.EditorPlugin,[],{initializer:function(){var t=this.get("styles");t=JSON.parse(t);var r=[],i,s;e.Array.each(t,function(e){i="<i></i>",s="<span>",e.type==="nostyle"?(i='<i class="nostyleelement"></i>',s='<span class="nostyle">'):e.type==="block"?(i='<i class="blockelement"></i>',s='<span class="blockstyle">'):e.type=="inline"&&(i='<i class="inlineelement"></i>',s='<span class="inlinestyle">'),r.push({text:s+i+e.title+"</span>",callbackArgs:["<"+e.type+">",e.classes]})});var o=this._showToolbarMenu;this._showToolbarMenu=function(e,t){o.call(this,e,t);var n,r,i;n=this.hasRangeSelected(),r=this.menus[t.buttonClass],i=r.get("contentBox"),n?i.removeClass("disableinline"):i.addClass("disableinline")},this.addToolbarMenu({icon:"icon",iconComponent:n,buttonClass:"styles",globalItemConfig:{callback:this._changeStyle},items:r})},_changeStyle:function(e,t){var n,r,i,s,o,u,a;if(t[0]==="<nostyle>"){r=window.getSelection().focusNode;for(i=r;i;i=i.parentNode){if(i.nodeType!==1)continue;s=window.getComputedStyle(i,null);if(s){i.removeAttribute("class");break}}return}if(t[0]==="<block>"){document.execCommand("formatBlock",!1,"<div>"),r=window.getSelection().focusNode;for(i=r;i;i=i.parentNode){if(i.nodeType!==1)continue;s=window.getComputedStyle(i,null);if(s){var f=s.getPropertyValue("display");if(f==="block"){n=i;var l=window.getSelection().focusNode.parentNode;l.insertAdjacentHTML("afterend","<br>");break}}}n.setAttribute("class",t[1])}else{o=t[1].split(" "),u=this.get("host");for(a=0;a<o.length;a+=1)u.toggleInlineSelectionClass([o[a]])}this.markUpdated()},hasRangeSelected:function(){var e,t;return e=rangy.getSelection(),e.rangeCount?(t=e.getRangeAt(0),!t.collapsed):!1}},{ATTRS:{styles:{value:{}}}})},"@VERSION@",{requires:["moodle-editor_atto-plugin"]});
