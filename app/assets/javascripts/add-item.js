var currentSubcategoryName = "";
var swfu;

$(document).ready(function () {
    $("#ItemTopCategory").bind("change",function (event) { mainCategorySelected(this); });
    $("#ItemSecondaryCategory").bind("change",function (event) { secondaryCategorySelected(this); });
    $("#ItemSecondaryCategory").hide();
    $("#ItemThirdCategory").hide();
    $("#after_category_wrapper").hide();
});

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


function mainCategorySelected (obj) {
    var mainid = $(obj).val();
    $("#ItemSecondaryCategory").hide();
    $("#ItemSecondaryCategory").empty();
    $("#ItemSecondaryCategory").append("<option value=\"0\">Choose a " + $("#ItemTopCategory option[value = "+mainid+"]").text() + " sub category</option>");
    $.get($("#get_subcat_list_url").val() + "/" + mainid, function (response) { renderSubcategories(response); }, "json");  
    $.get($("#get_brands_list_url").val() + "/" + mainid, function (response) { renderBrands(response); }, "json");
}
function secondaryCategorySelected (obj) {
    var subid = $(obj).val();
    $("#ItemThirdCategory").hide();
    $("#ItemThirdCategory").empty();
    $("#ItemThirdCategory").append("<option value=\"0\">Choose a " + $("#ItemSecondaryCategory option[value = "+subid+"]").text() + " type</option>");
    $.get($("#get_subcat_list_url").val() + "/" + subid, function (response) { renderItemTypes(response); }, "json");
    $.get($("#get_size_list_url").val() + "/" + subid, function (response) { renderSizes(response); }, "json");
    $("#after_category_wrapper").fadeIn();
}

function renderSubcategories (array) {
    var num = array.length;
    if (num > 0) {      
        for (var i=0; i<num; i++) {
            $("#ItemSecondaryCategory").append("<option value=\"" + array[i].ItemCategory.id + "\">" + array[i].ItemCategory.name + "</option>");
        }
        $("#ItemSecondaryCategory").fadeIn();
    } else {
        $("#ItemSecondaryCategory").empty();
        $("#ItemSecondaryCategory").hide();
    }
}

function renderItemTypes (array) {
    var num = array.length;
    if (num > 0) {
        for (var i=0; i<num; i++) {
            $("#ItemThirdCategory").append("<option value=\"" + array[i].ItemCategory.id + "\">" + array[i].ItemCategory.name + "</option>");
        }
        $("#ItemThirdCategory").fadeIn();
    } else {
        $("#ItemThirdCategory").empty();
        $("#ItemThirdCategory").hide();
    }
}

function renderSizes (array) {
    var num = array.length;
    if (num == 0) {
        $("#ItemSize").empty();
        $("#ItemSize").hide();
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

function validateForm () {
    if ($("#item_id").val() == 0) {
        var errors = new Array();
        if ($("#ItemTitle").val().length < 4) errors.push(["You must enter a title for this item of at least 4 characters long","ItemTitle"]);
        if ($("#ItemItemCondition").val() == "") errors.push(["You must choose the condition of this item","ItemItemCondition"]);
        if ($("#ItemPrice").val() == "") {
            errors.push(["You must enter the price for this item","ItemPrice"]);    
        } else if ($("#ItemPrice").val() < 2) {
            errors.push(["The minumum price for an item is $2","ItemPrice"]);
        }
        if ($("#ItemShippingPrice").val() == "") errors.push(["You must enter a shipping price","ItemShippingPrice"]);
        if ($("#photos").uploadifySettings('queueLength') == 0) errors.push(["You must upload at least one photo!","photos"]);
        //
        if (errors.length == 0) {
            $.post($("#save_item_url").val(), $("#ItemAddForm").serialize(), 
                function (response) {                   
                    if (response.status == "SUCCESS") {
                        $("section.category").slideUp();
                        $("section.size").slideUp();
                        $("section.item-details").slideUp();
                        $("#pre_upload_photos_hint").hide();
                        $("section.price").slideUp();
                        $("input").attr("disabled","disabled");
                        $("select").attr("disabled","disabled");
                        $("textarea").attr("disabled","disabled");
                        $("#submit_btn").hide();
                        $("#item_id").val(response.item_id);
                        $("#photos").uploadifySettings('postData',{item_id: parseInt(response.item_id)});
                        $('#photos').uploadifyUpload();
                        $('.uploadifyProgress').css("visibility","visible");
                        $(window).scrollTop(0);
                    } else {
                        alert(response.message);    
                    }
                }, "json");
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
}
