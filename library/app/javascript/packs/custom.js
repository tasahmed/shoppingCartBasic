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

window.calculatePriceOnQuantity = function(value, id, elem_id) {
	//form ajax request json data
	var data = { productQuantity : value, productId : id}
	initiaAjax('/product/calculateValue', data, elem_id)
	//$('#'+id).html('test').delay( 100 )
}


window.initiaAjax = function(reqUrl, postData, responsDiv) {

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

	    }
  	});
};

window.removeOrder = function(orderId, elemId) {
	event.preventDefault();
	console.log(orderId)
}