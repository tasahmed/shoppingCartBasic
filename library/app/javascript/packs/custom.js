window.searchProducts = function() {

	$.ajax({
	    type:'POST',
	    url:'/product/search',
	    dataType: "JSON",
	    data: { 
	    	search_val : $('#search_product').val()
	    },
	    success:function(data){
	      //$(this).addClass('done');
	      console.log('Success!');
	      console.log(data.html_content)
	      $('#product_list').html(data.html_content);

	    }
  	});

	return false;
}

window.calculatePriceOnQuantity = function(value, id, elem_id, secondary_field) {
	//form ajax request json data
	var data = { productQuantity : value, productId : id}
	initiaAjax('/product/calculateValue', data, elem_id, secondary_field)
	//$('#'+id).html('test').delay( 100 )
	//update the cumulative total field as well

}


window.initiaAjax = function(reqUrl, postData, responsDiv, secondary_field) {

	$.ajax({
	    type 	 :'POST',
	    url 	 : reqUrl,
	    dataType : "JSON",
	    data 	 : postData,
	    success:function(data){
	      //$(this).addClass('done');
	      console.log('Success!');
	      console.log(data.html_content)
	      $('#'+responsDiv).html(data.html_content).delay(100);
	      console.log(typeof(secondary_field))
	      if (typeof(secondary_field) !='undefined') {
	      	console.log(secondary_field);
					$('#'+secondary_field).html(data.cumulativeTotal).delay(150);	      	
	      }

	    }
  	});
};

window.removeOrder = function(orderId, elemId) {
	event.preventDefault();
	console.log(orderId)
	console.log(elemId)
}

/*window.validatelogin = function() {

	let username = $('#username').val();
	let pwd			 = $('#password').val();

	console.log('username'+username);
	console.log('password'+pwd);

	let returnValue = false;
	
	if (username !='' && pwd !='') {
		returnvalue = true;
	} else {
		$('#login_msg').html = 'Please enter username and password!'
		$(".alert").show();
		//return false;
	}


	return returnValue; 
}*/