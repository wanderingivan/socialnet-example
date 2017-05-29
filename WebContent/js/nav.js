/**
 * 
 */
function populateUnreadMessages(){
  	if($("#userMessagesDropdown li").length === 0){
  		var target = $("#userMessagesDropdown");
  		$.ajax({url:'/SocialNet/message/unread-messages',
  				dataType:'html'
  		}).done(function(html){target.html(html);});
  	}
}
	


function populateFriendRequests(){
	console.log($("#friendRequestsDropdown li").length)
  	if($("#friendRequestsDropdown li").length === 0){
  		console.log($("#friendRequestsDropdown li").length === 0);
  		console.log($("#friendRequestsDropdown li").length)
  		var target = $("#friendRequestsDropdown");
  		$.ajax({url:'/SocialNet/user/friend-requests',
  				dataType:'html'
  		   	  }).done(function(html){target.html(html);});
  	}
}
	
$.subscribe("addFriendRequestCount",
		    function(event,data){
				var jd = JSON.parse(event.originalEvent.data);
				$("#friendRequests").html(jd.result);
			}
);

$.subscribe("addUnreadMessages",
		    function(event,data){
				var jd = JSON.parse(event.originalEvent.data);
				$("#userMessages").html(jd.message);
			}
);
	
$.subscribe("clearButtons",
			function(event,data){
				var jd = JSON.parse(event.originalEvent.data);
				var buttonsDiv = $("#frButtons"+jd.friendRequestId)
			    buttonsDiv.empty();
				buttonsDiv.html('<p style="color:#b3de1d;">'+jd.message+'</p>');
			}
);

$.subscribe("relationSuccess",
			function(event,data){
				var jd = JSON.parse(event.originalEvent.data);
				$(".modal-title").html(jd.message);
				$("#relationModal").modal();
				$("#friendRequestButton").remove();
				$("#removeFriendshipButton").remove();
			}
);
$(document).ready(function(){
	$("#dropdownMenuMessage").click(populateUnreadMessages);
	$("#dropdownMenuFriendRequests").click(populateFriendRequests);
});