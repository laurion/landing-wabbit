(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define([], factory);
    } else if (typeof exports === 'object') {
        module.exports = factory();
    } else {
        root.templatizer = factory();
    }
}(this, function () {
    var jade=function(){function r(r){return null!=r&&""!==r}function n(e){return Array.isArray(e)?e.map(n).filter(r).join(" "):e}var e={};return e.merge=function t(n,e){if(1===arguments.length){for(var a=n[0],s=1;s<n.length;s++)a=t(a,n[s]);return a}var i=n["class"],l=e["class"];(i||l)&&(i=i||[],l=l||[],Array.isArray(i)||(i=[i]),Array.isArray(l)||(l=[l]),n["class"]=i.concat(l).filter(r));for(var o in e)"class"!=o&&(n[o]=e[o]);return n},e.joinClasses=n,e.cls=function(r,t){for(var a=[],s=0;s<r.length;s++)a.push(t&&t[s]?e.escape(n([r[s]])):n(r[s]));var i=n(a);return i.length?' class="'+i+'"':""},e.attr=function(r,n,t,a){return"boolean"==typeof n||null==n?n?" "+(a?r:r+'="'+r+'"'):"":0==r.indexOf("data")&&"string"!=typeof n?" "+r+"='"+JSON.stringify(n).replace(/'/g,"&apos;")+"'":t?" "+r+'="'+e.escape(n)+'"':" "+r+'="'+n+'"'},e.attrs=function(r,t){var a=[],s=Object.keys(r);if(s.length)for(var i=0;i<s.length;++i){var l=s[i],o=r[l];"class"==l?(o=n(o))&&a.push(" "+l+'="'+o+'"'):a.push(e.attr(l,o,!1,t))}return a.join("")},e.escape=function(r){var n=String(r).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;");return n===""+r?r:n},e.rethrow=function a(r,n,e,t){if(!(r instanceof Error))throw r;if(!("undefined"==typeof window&&n||t))throw r.message+=" on line "+e,r;try{t=t||require("fs").readFileSync(n,"utf8")}catch(s){a(r,null,e)}var i=3,l=t.split("\n"),o=Math.max(e-i,0),c=Math.min(l.length,e+i),i=l.slice(o,c).map(function(r,n){var t=n+o+1;return(t==e?"  > ":"    ")+t+"| "+r}).join("\n");throw r.path=n,r.message=(n||"Jade")+":"+e+"\n"+i+"\n\n"+r.message,r},e}();

    var templatizer = {};
    templatizer["includes"] = {};
    templatizer["pages"] = {};
    templatizer["includes"]["css"] = {};
    templatizer["includes"]["images"] = {};
    templatizer["includes"]["js"] = {};
    templatizer["includes"]["video"] = {};
    templatizer["includes"]["css"]["colors"] = {};
    templatizer["includes"]["css"]["fonts"] = {};
    templatizer["includes"]["css"]["nivo_lightbox_themes"] = {};
    templatizer["includes"]["images"]["switcher"] = {};
    templatizer["includes"]["css"]["nivo_lightbox_themes"]["default"] = {};

    // body.jade compiled template
    templatizer["body"] = function tmpl_body() {
        return '<body><div role="page-container"></div></body>';
    };

    // includes/mainStripe.jade compiled template
    templatizer["includes"]["mainStripe"] = function tmpl_includes_mainStripe() {
        return '<div class="mainstripe"><div class="imgBack"><img src="http://placehold.it/1200x1600"/></div><div class="overlay"><div class="container"><h1>Wabbit</h1><div class="register-container"><div class="sign-up"><div class="row"><div class="col-sm-4 col-sm-offset-4"><div class="row"><div class="col-xs-8"><input type="text" class="form-control"/></div><div class="col-xs-4"><button type="button" class="btn btn-primary register">Register Now!</button></div></div></div></div></div></div></div></div></div>';
    };

    // pages/home.jade compiled template
    templatizer["pages"]["home"] = function tmpl_pages_home() {
        return '<div class="mainstripe"><div class="imgBack"><img src="http://placehold.it/1200x1600"/></div><div class="overlay"><div class="container"><h1>Wabbit</h1><div class="register-container"><div class="sign-up"><div class="row"><div class="col-sm-4 col-sm-offset-4"><div class="row"><div class="col-xs-8"><input type="text" class="form-control"/></div><div class="col-xs-4"><button type="button" class="btn btn-primary register">Register Now!</button></div></div></div></div></div></div></div></div></div>';
    };

    return templatizer;
}));