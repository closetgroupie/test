var currentSubcategoryName = "";
var topLevelCategoryIds = new Array();
var swfu;

$(document).ready(function () {
	$("#ItemItemCategoryId").bind("change",function (event) { categorySelected(this); });
	$("#item_photos a").bind("click", function (event) { deleteImage(this); return false; });
	$("#submit_btn").bind("click",function (event) { validateForm(); });
	//$("#ItemSize").hide();
	$('#photos').uploadify({
		'langFile' : '/js/uploadifyLang_en.js',
		'swf'  : '/flash/uploadify3.swf',
		'uploader' : $("#upload_photos_url").val(),
		'checkExisting' : false,
		'buttonCursor'    : 'pointer',
		'buttonText' : '',
		'fileSizeLimit' : 3*1024,
		'fileTypeExts' : '*.jpg;*.png',
		'multi' : true,
		'queueSizeLimit' : 5,
		'width':130,
		'height':40,
		'cancelImage' : '/img/uploadify-cancel.png',
		'auto'      : true,
		'debug'           : false,
		'postData': {item_id: parseInt($("#item_id").val())},
		onUploadSuccess : function(file,data,response) { 
			var r = JSON.parse(data);
			if (r.status == "SUCCESS") {
				var image_id = r.image_id;
				$("#item_photos").append("<li id=\"image_" + image_id + "\"><img src=\""+r.thumbnail+"\" width=\"100\" class=\"img-shadow\" /><a href=\"#\" id=\"delete_image_"+image_id+"\">Delete</a></li>");
				$("#image_"+image_id).hide();
				$("#image_"+image_id).fadeIn();
				$("#delete_image_"+image_id).bind("click", function (event) { deleteImage(this); return false; });
			} else {
				alert(r.message);
			}
		},		
	  });
	  //
	  var tlc = $("#top_level_cat_ids").val();
	  topLevelCategoryIds = tlc.split(",");
	  //
	  $(".sortable").sortable({
		update: function (event, ui) { handleImagesSorted(event,ui); },
		handle: "img"
	});
	$(".sortable").disableSelection();
});


function categorySelected (obj) {
	var catid = $(obj).val();
	$.get($("#get_size_list_url").val() + "/" + catid, function (response) { renderSizes(response); }, "json");
	for (var i=0; i<topLevelCategoryIds.length; i++) {
		if (catid == topLevelCategoryIds[i]) {
			$.get($("#get_brands_list_url").val() + "/" + catid, function (response) { renderBrands(response); }, "json");
			break;	
		}
	}
}


function renderSizes (array) {
	var num = array.length;
	if (num == 0) {
		$("#ItemSize").empty();
		$("#ItemSize").hide();
		$("#ItemSize").val("");
	} else {
		$("#ItemSize").empty();
		$("#ItemSize").append("<option value=\"0\">Choose a size</option>");
		for (var i=0; i<num; i++) {
			var numsizes = array[i].ItemSize.length;
			for (var j=0; j<numsizes; j++) {
				$("#ItemSize").append("<option value=\""+ array[i].ItemSize[j].id +"\">" + array[i].ItemSize[j].name + "</option>");
			}
		}
		$("#ItemSize").fadeIn();
	}
}

function renderBrands (response) {
	$("#ItemItemBrand").empty();
	$("#ItemItemBrand").append("<option value=\"\">Choose one of these brands...</option>");
	var num = response.brands.length;
	for (var i=0; i<num; i++) {
		$("#ItemItemBrand").append("<option value=\"" + response.brands[i].ItemBrand.id + "\">" + response.brands[i].ItemBrand.name + "</option>");
	}	
}

function deleteImage (a) {
	var aid = $(a).attr("id");
	var aida = aid.split("_");
	var imgid = aida[2];
	$.get(
		$("#delete_image_url").val() + "/" + imgid,
		function (response) {
			if (response.status == "SUCCESS") {
				$("#image_"+response.image_id).fadeOut();
			} else {
				alert(response.message);	
			}
		},
		"json"
	);	
}

function validateForm () {
	var errors = new Array();
	if ($("#ItemTitle").val().length < 4) errors.push(["You must enter a title for this item of at least 4 characters long","ItemTitle"]);
	if ($("#ItemItemCondition").val() == "") errors.push(["You must choose the condition of this item","ItemItemCondition"]);
	if ($("#ItemPrice").val() == "") {
		errors.push(["You must enter the price for this item","ItemPrice"]);	
	} else if ($("#ItemPrice").val() < 2) {
		errors.push(["The minumum price for an item is $2","ItemPrice"]);
	}
	if ($("#ItemShippingPrice").val() == "") errors.push(["You must enter a shipping price","ItemShippingPrice"]);
	//
	if (errors.length == 0) {			
		// alert("posting to " + $("#save_item_url").val());
		$("#ItemEditForm").submit();
	} else {
		var message = "";
		for (var i=0; i<errors.length; i++) {
			message += "- " + errors[i][0]+"\n";
		}
		alert(message);
		$("#" + errors[0][1]).focus();
		return false;
	}
}

function handleImagesSorted () {
	var idsa = $("#item_photos li").map(function() { return $(this).attr("id"); }).get();
	var ids = [];
	for (var i=0; i<idsa.length; i++) {
		var id = idsa[i];
		var ida = id.split("_");
		ids.push(ida[1]);
	}
	$.post($("#reorder_photos_url").val(),{ids: ids});
}