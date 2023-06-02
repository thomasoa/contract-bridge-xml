var currentShown="loadingthearticles";
var footer=null;

expiration=new Date();
expiration.setFullYear(expiration.getFullYear()+1);
expiration="; expires=" + expiration.toGMTString();

function selectArticle(name) {
    var link=document.getElementById(name+"toclink");
    var selected=document.getElementById(name+"tocselected");
    if (link!=null) {
        link.style.display="none";
    }

    if (selected!=null) {
        selected.style.display="block";
    }
}

function deselectArticle(name) {
    var link=document.getElementById(name+"toclink");
    var selected=document.getElementById(name+"tocselected");
    if (link!=null) {
        link.style.display="block";
    }

    if (selected!=null) {
        selected.style.display="none";
    }
}

function openEntry(name) {
    var oldElement=document.getElementById(currentShown);
    newElement=document.getElementById(name);
    if (newElement!=null) {
	if (oldElement!=null) {
	    oldElement.style.display="none";
            deselectArticle(currentShown);
        }

        selectArticle(name);
        newElement.style.display="block";
        currentShown=name;

	// hack for Mozilla bug
        footer.style.display="none";
        footer.style.display="block";

        window.scrollTo(0,0);

	document.cookie="last=" + escape(name) + expiration;
    }
}

//
// Parses cookies
//
function getCookieField(from,cookieName) {
    var pos = from.indexOf(cookieName+"=");
    if (pos>=0) {
      var start = pos + 1 + cookieName.length;
      var end = from.indexOf(";",start);
      if (end==-1) {
         end=from.length;
      }
      var value=from.substring(start,end);
      return unescape(value);
    } else {
      return "";
    }
}

//
// Determines whether the article has changed - if so, decides to go
// to the first page.
//
// If the page has not changed, but the "defaultName" is not the same
// as the first page from the last visit, then we start at the defaultName
//
// Otherwise, we return the last article visited.
//
function doCookieLogic(defaultName) {
    var first=location.search.substring(1);
    if (first=="") {
        first=defaultName;
    }
    var from=document.cookie;
    var oldRevision=getCookieField(from,"revision");
    var oldFirst=getCookieField(from,"first");
    var oldLast=getCookieField(from,"last");

    document.cookie="revision=" + escape(document.lastModified) +
	expiration;
    document.cookie="first=" + escape(first) + expiration;
    if (oldRevision != document.lastModified || first != oldFirst)  {
       return first;
    }

    if (oldLast!="") { return oldLast; }
    return first;
}

function defaultStartArticle(defaultName) {
    name=doCookieLogic(defaultName);
    footer=document.getElementById("articlesfooter");
    openEntry(name);
}
