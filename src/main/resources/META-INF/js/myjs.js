// reload page when click back button on browser's navigation
if(!!window.performance && window.performance.navigation.type == 2){
    window.location.reload();
}

function minusQuantity(productId){
	var sendToServer = false;
	var inputId = "#quantityInput";

	if(typeof(productId) != "undefined" && productId != null){
		inputId += productId;
		sendToServer = true;
	} 
	
	var quantity = $(inputId).val();

	if(quantity <=  1){
		alert("Cần mua tối thiểu 1 sản phẩm!!!");
		$(inputId).val(1);
	} else{
		$(inputId).val(--quantity);
	}
	
	//send data to server via ajax
	if(sendToServer){
		var quantity = $(inputId).val();
			
		var data = {
			"productId" : productId,
			"quantity" : quantity,
			"processType": "add"
		};
		
		sendDataToCartController(productId, data);
	}
}

function plusQuantity(maxQuantity, productId){
	
	var sendToServer = false;
	var inputId = "#quantityInput";

	if(typeof(productId) != "undefined" && productId != null){
		inputId += productId;
		sendToServer = true;
	} 
	
	var quantity = $(inputId).val();

	if(quantity >= maxQuantity){
		var msg = "Không được mua quá " + maxQuantity + " sản phẩm!!!";
		alert(msg);
		$(inputId).val(maxQuantity);
	} else{
		$(inputId).val(++quantity);
	}
	
	//send data to server via ajax
	if(sendToServer){
		var quantity = $(inputId).val();
			
		var data = {
			"productId" : productId,
			"quantity" : quantity,
			"processType": "add"
		};
		
		sendDataToCartController(productId, data);
	}
}

function checkQuantity(maxQuantity, productId){
	var sendToServer = false;
	var inputId = "#quantityInput";

	if(typeof(productId) != "undefined" && productId != null){
		inputId += productId;
		sendToServer = true;
	} 
	
	var quantity = $(inputId).val();
	
	if(isNaN(quantity)){
		alert("Cần nhập số lượng cần mua!")
		$(inputId).val(1);
	}
	
	if(quantity > maxQuantity){
		var msg = "Không được mua quá " + maxQuantity + " sản phẩm!!!";
		alert(msg);
		$(inputId).val(maxQuantity);
	}
	
	if(quantity < 1){
		alert("Cần mua tối thiểu 1 sản phẩm!!!");
		$(inputId).val(1);
	}
	
	//send data to server via ajax
	if(sendToServer){
		var quantity = $(inputId).val();
			
		var data = {
			"productId" : productId,
			"quantity" : quantity,
			"processType": "add"
		};
		
		sendDataToCartController(productId, data);
	}
}

function removeItem(productId){
	var data = {
		"productId" : productId,
		"processType": "remove"
	};
	
	sendDataToCartController(productId, data);
}

function sendDataToCartController(productId, data){
	$.ajax({
		url: "/processProductInCart",
		type: "post",
		contentType: "application/json",
		data: JSON.stringify(data),
		dataType: "json",
		beforeSend: function(){
			$(".ajax-spinner").show();
		},
		complete: function(){
			$(".ajax-spinner").fadeOut(500);
		},
		success: function(jsonResult){
			if(jsonResult.statusCode == 200){
				$("#cartAmount").html(jsonResult.quantity);
				$("#totalAmount" + productId).html(jsonResult.itemCost);
				$("#cost").html(jsonResult.cost + "<sup>đ</sup>");
				$("#totalCost").html(jsonResult.totalCost + "<sup>đ</sup>");
				$("#shipFee").html(jsonResult.shipFee);
				if(data['processType'] == "remove"){
					$("#itemLine" + productId).remove();
					if(jsonResult.empty){
						$("#cartContent").html(
							"<h1 class='no-items-cart'>Hiện chưa có sản phầm nào trong giỏ hàng!</h1>"
						);
						$(".cart-pay").remove();
					}
				}
			} else {
				alert("Lỗi thêm hàng vào giỏ!!!");
				// similar behavior as an HTTP redirect
				window.location.replace("/errors");
			}
		},
		error: function(){
			// similar behavior as an HTTP redirect
			window.location.replace("/errors");
		}
	});
}

$(document).ready(function() {
	// set effect when click product image
    var flag = 0;
    $("img.img-nav").click(function() {
       var imageSrc = $(this).attr("src");
       
       $('img#image-main').fadeOut(500, function(){
    	   $('img#image-main').attr("src", imageSrc);
       });
       $('img#image-main').fadeIn(500);
       $(this).attr("src");
       
       $('.slider-nav-img > img').removeClass('nav-active');
       $(this).addClass('nav-active');
    });
    
    // set effect to show user-menu
    $('.login').hover(function() {
		$('.user-menu').slideDown(250);
	});
	$('.login').mouseleave(function() {
		$('.user-menu').slideUp(250).hide(100);
	})
});

var FinalProject = {

	saveContact:function(){
		var fullName = $("#contact-name").val();
		var email = $("#contact-email").val();
		var content = $("#contact-content").val();
		
		var data = {
			"fullName" : fullName,
			"email" : email,
			"message": content
		};
		
		$.ajax({
			url: "/saveContactWithAjax",
			type: "post",
			contentType: "application/json",
			data: JSON.stringify(data),
			dataType: "json",
			success: function(jsonResult){
				if(jsonResult.statusCode == 200){
					$("#error-alert").hide();
					$("#success-alert").html(jsonResult.message);
					$("#success-alert").show();
					$("#success-alert").fadeOut(15000);
				} else {
					$("#success-alert").hide();
					$("#error-alert").html(jsonResult.message);
					$("#error-alert").show();
					$("#error-alert").fadeOut(15000);
				}
			}
		});
	},

	// addToCart function
	addToCartWithQuantity:function(productId, quantity){
		
		var data = {
			"productId" : productId,
			"quantity" : quantity
		};
		
		$.ajax({
			url: "/add-to-cart",
			type: "post",
			contentType: "application/json",
			data: JSON.stringify(data),
			dataType: "json",
			success: function(jsonResult){
				if(jsonResult.statusCode == 200){
					alert("Bạn đã thêm hàng vào giỏ thành công!");
					$("#cartAmount").html(jsonResult.message);
				} else {
					alert("Lỗi thêm hàng vào giỏ!!!");
				}
			}
		});
	},
	
	// add to cart no quantity arg
	addToCart:function(productId){
		
		var quantity = parseInt($('#quantityInput').val());
		var data = {
			"productId" : productId,
			"quantity" : quantity
		};
		
		$.ajax({
			url: "/add-to-cart",
			type: "post",
			contentType: "application/json",
			data: JSON.stringify(data),
			dataType: "json",
			success: function(jsonResult){
				if(jsonResult.statusCode == 200){
					alert("Bạn đã thêm hàng vào giỏ thành công!");
					$("#cartAmount").html(jsonResult.message);
				} else {
					alert("Lỗi thêm hàng vào giỏ!!!");
				}
			}
		});
	}
}


