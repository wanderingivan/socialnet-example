/**
 * 
 */

$(document).ready(function(){
		$("#card").flip({trigger:'manual'});
		$("#formToggleCreate").click(function(){
			$('#card').flip('toggle');
		});
		$("#formToggleLogin").click(function(){
            if($('#createback').css('visibility') == 'hidden'){
                $('#createback').css('visibility','visible');
            }
			$('#card').flip('toggle');
		});
});