
function submit_form (event){
	event.preventDefault();
	alert("Good choice!")
	$("form").submit();
}


$(document).ready(function(){
	$(":submit").on("click", submit_form)
})