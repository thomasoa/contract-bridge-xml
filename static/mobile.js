$(function(){
	$('#bookinfopopup').enhanceWithin().popup();
	$('#toc li a').attr('data-transition','slideup');
	function swipeHandler( event ){
	    if ($(event.target).hasClass('testcode')) {
		return;
	    }
	    var $page = $(event.currentTarget);
	    var $next = $page.data('next');
	    var $prev = $page.data('prev');
	    var diff = event.swipestop.coords[0]-event.swipestart.coords[0];
	    var goto = $next;
	    var options = {'transition':'slide'}
	    if (diff>0) {
		goto = $prev;
		options['reverse']=true;
	    }
            if (goto!=undefined && goto!=null && goto!='') {
		$.mobile.changePage('#'+goto,options);
		console.log(goto);
	    }

	}
	$( ".articlePage" ).on( "swipe", swipeHandler );
 
	// Callback function references the event target and adds the 'swipe' class to it
    });