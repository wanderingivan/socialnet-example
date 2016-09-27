/**
 * 
 */

$(document).ready(function(){
		$("#card").flip({trigger:'manual'});
		$("#formToggleCreate").click(function(){
			console.log("Create Toggle Clicked");
            console.log("flipping a card");
			$('#card').flip('toggle');
		});
		$("#formToggleLogin").click(function(){
			console.log("Login Toggle Clicked");
            console.log("flipping a card");
			$('#card').flip('toggle');
		});
});