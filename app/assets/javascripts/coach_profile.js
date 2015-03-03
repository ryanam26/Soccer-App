// Append the function to the "document ready" chain 
$(function(){
	// when the #search field changes 
	$("#category").change(function() { 
		// make a POST call and replace the content 
		$.post( test_get_tests_path, function( data ) {
  			$( "#tests" ).html( data );
		});
	}); 
});
