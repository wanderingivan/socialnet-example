/**
 * 
 */
$.subscribe('addComment',function(event,data){
	var postId = event.originalEvent.data.postId;
	var result = event.originalEvent.data.result;
	var messageId = result[0];
	var target = $('#wp'+postId+'Comments #last');
	console.log($('#wp'+postId+'Comments .message-form'));
    target.before(getCommentHtml(result));
    $('#commentForm'+postId+'_message').val('');
    $('#message'+messageId).toggle('slide',{direction:'right'},750);
		$('#message'+messageId).effect("highlight", {color:"#b3de1d"}, 1000);
});



$.subscribe('loadComments',function(event,data){
	var postId = event.originalEvent.data.postId;
	var result = event.originalEvent.data.result;
	var target = $('#wp'+postId+'Comments #last');
	console.log(result);
	console.log(result.length);
	console.log(event.originalEvent.data.index);
	console.log(event.originalEvent.data.index + result.length);
	$.each (result,function(index,data){
		console.log(data);
		var messageId = data[0];
	    target.before(getCommentHtml(data));
        $('#message'+messageId).toggle('slide',{direction:'right'},750);
		$('#message'+messageId).effect("highlight", {color:"#b3de1d"}, 1000);
	});
	$('#loadComments'+postId+'_index').val(event.originalEvent.data.index+result.length);
});

$.subscribe('loadPost',function(event,data){
	var result = event.originalEvent.request.responseText;
	var newIndex = (parseInt($('#loadPostForm_index').val()) +1);
    var target = determineWallTarget();
    target.append(result);
	$('#loadPostForm_index').val(newIndex);
	document.getElementById('load').scrollIntoView({block: "top", behavior: "smooth"});
	
});

function determineWallTarget(){
	var left =$('#left');
	var right =$('#right');
	if($('#vpsize').is(':hidden')){
		return right;
	}else if(left.height() > right.height()){
    	return right;
    }else{
    	return left;
    }
}

function getCommentHtml(comment){
	return '<div id="message'+comment[0]+'" class="media comments well well-sm" style="display:none;">'
	        +'<div class="media-left">'
	          +'<img  class="media-object" alt="poster image" src="data:image/jpeg;base64,'+ comment[3] +'" style="width:55px;height:55px;"/>'
	        +'</div>'
	        +'<div class="media-body">'
	          +'<h5 class="media-heading">'+comment[2]+':</h5>'
	          +'<p>'+comment[1]+'</p>'
	        +'</div>'
	       +'</div>';
}

function getPostHtml(postInfo,firstComment){
	var html = '<div class="col-md-offset-1 col-md-5 col-sm-6 col-xs-12">'
           +'<s:div  id="wp'+ postInfo[0]+'Comments" class="wall-post-container">';
	
            
	
}