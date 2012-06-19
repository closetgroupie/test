$(document).ready(function () {
	$("input.numeric").numeric();
	$("input.example_populated").each(function (index) { $(this).data("default",$(this).val()); });
	$("input.example_populated").bind("focus",function () { handleExamplePopulatedFocus($(this)); });
	$("input.example_populated").bind("blur",function () { handleExamplePopulatedBlur($(this)); });
	$('textarea').autogrow();
});

function toggleItemSubcategories (which) {
	$(".subcategories").slideUp();
	$("#subcategories_"+which).slideDown();	
}

function handleExamplePopulatedFocus (obj) {
	if ($(obj).val() == $(obj).data("default")) { 
		$(obj).val("");
	}	
}
function handleExamplePopulatedBlur (obj) {
	var d = $(obj).data("default");
	var c = $(obj).val().replace(/^\s+|\s+$/g, '');
	if (c.length == 0) { 
		$(obj).val(d);
	}
}

function fbshare(url, title) {
    window.open('http://www.facebook.com/sharer.php?u='+url+'&t='+encodeURIComponent(title),'sharer','toolbar=0,status=0,width=626,height=436');
    return false;
}
