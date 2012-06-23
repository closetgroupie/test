var currentSubnavIndex = null;
var subnavTimeout = 0;

function kmqp (arr) {
    if (typeof(_kmq) != 'undefined') {
        _kmq.push(arr);
    }
}

$(document).ready(function(){
    $("input.numeric").numeric();
    $("input.example_populated").each(function (index) { $(this).data("default",$(this).val()); });
    $('textarea').autogrow();

    var menuTimeout = null;
    var hidemenu = function() {
            $('#user-context-menu').hide();
            $('#user-context').removeClass('hovering');
    };

    $("body").delegate('#query', 'keydown', function(event) {
        if (event.which == '13') {
            $(this).closest('form').submit();
            return false;
        }
    }).delegate('#search_submit', 'click', function (event) {
        $(this).closest('form').submit();
    }).delegate('input.example_populated', 'focus blur', function(event) {
        handleExamplePopulatedFocus($(this));
    }).delegate('#user-context', 'mouseover', function (event) {
        clearTimeout(menuTimeout);
        $(this).addClass('hovering');
        $('#user-context-menu').css({
            left: $(this).position().left - 20,
            top: "40px"
        }).slideDown(150);

    }).delegate('#user-context', 'mouseout', function(event) {
        menuTimeout = setTimeout(hidemenu, 250);
    }).delegate('#user-context-menu', 'mouseover mouseout', function(event) {
        if (event.type == 'mouseover') {
            clearTimeout(menuTimeout);
        } else {
            menuTimeout = setTimeout(hidemenu, 250);
        }
    });

    $('.btn-inactive').tooltip();

    // $("body:not(.unregistered)").delegate('.toggle-follow', 'click', function(event) {
    //     toggleFollow($(this).attr("id"));
    //     return false;
    // }).delegate('.follow-user', 'click', function(event) {
    //     followUser($(this).data('user_id'));
    //     return false;
    // }).delegate('.follow-button', 'click', function(event) {
    //     toggleFollowNew($(this).attr("id"));
    //     return false;
    // });

    var navHasSub = [true,true,true,false,false,true];
    for (var i=1; i<=navHasSub.length; i++) {
        var mn = "#topnav_"+i;
        var sn = "#subnav_"+i;
        if (navHasSub[i-1]) {
            $(mn).data("index",i);
            $(mn).bind("mouseover", function () { stopSubnavTimer(); showSubnav($(this).data("index")); });
            $(mn).bind("mouseout", function () { startSubnavTimer(); });
            $(sn).data("index",i);
            $(sn).bind("mouseover", function () { stopSubnavTimer(); });
            $(sn).bind("mouseout", function () { startSubnavTimer(); });
        } else {
            $(mn).bind("mouseover", function () { hideSubnav(null); });
        }
    }
});

function doSearch () {
    window.top.location = $("#search_form").attr("action") + "/" + $("#search_query").val();
}

function toggleFavoriteItem (id_str) {
    var item_ida = id_str.split("_");
    var item_id = item_ida[2];
    $.get("/favorites/toggle_favorite/"+item_id, function (response) { 
        if (response.status == "SUCCESS") {
            if (response.favorited == 1) {
                kmqp(['record', 'added to favorites', {'product id': item_id}]);
                $("#fav_btn_"+response.item_id).html("Un-Favorite")
                                               .removeClass("btn-favorite")
                                               .addClass("btn-unfavorite");
                $("body.favorites #item_result_"+response.item_id).css("opacity",1);
                $("body.item-detail #fav_btn_"+response.item_id).html("Un-Favorite")
                                                                .removeClass("btn-favorite-long")
                                                                .addClass("btn-unfavorite-long");
            } else {
                $("#fav_btn_"+response.item_id).html("Favorite")
                                               .removeClass("btn-unfavorite")
                                               .addClass("btn-favorite");
                $("body.favorites #item_result_"+response.item_id).css("opacity",.3);
                $("body.item-detail #fav_btn_"+response.item_id).html("Favorite")
                                                                .addClass("btn-favorite-long")
                                                                .removeClass("btn-unfavorite-long");
            }
            var c = parseInt($("#nav_favorites_count").html());
            var n = c+response.favorited;
            $("#nav_favorites_count").html(n);
            n == 0 ? $("#nav_favorites_count").fadeOut() : $("#nav_favorites_count").fadeIn();
        } else {
            alert(response.message);
        }
    }, "json");
}

function toggleFollow (id_str) {
    var user_ida = id_str.split("_");   
    var user_id = user_ida[2];
    $.get("/favorites/toggle_follow/"+user_id, function (response) { 
        if (response.status == "SUCCESS") {         
            if (response.following == 1) {
                $("#follow_closet_"+response.user_id).html("Un-Follow");        
                $("#follow_closet_"+response.user_id).removeClass("btn-follow");
                $("#follow_closet_"+response.user_id).addClass("btn-unfollow"); 
                kmqp(['record', 'added friend']);
            } else {
                $("#follow_closet_"+response.user_id).html("Follow");       
                $("#follow_closet_"+response.user_id).addClass("btn-follow");
                $("#follow_closet_"+response.user_id).removeClass("btn-unfollow");
            }
            if ($("div#user_"+response.user_id).length > 0) {
                var current = parseInt(response.num_groupies);
                current == 1 ? $("div#user_"+response.user_id + " p span.groupie_count a.groupie-count").html("<strong>"+current+"</strong> <span>groupie</span>") : $("div#user_"+response.user_id + " p span.groupie_count a.groupie-count").html("<strong>"+current+"</strong> <span>groupies</span>");
            }
            alert(response.message);
        } else {
            alert(response.message);
        }
    }, "json");
}

function toggleFollowNew (id_str) {
    var user_ida = id_str.split("_");
    var user_id = user_ida[2];
    $.get("/favorites/toggle_follow/"+user_id, function (response) { 
        if (response.status == "SUCCESS") {
            if (response.following == 1) {
                $("#follow_closet_"+response.user_id).removeClass("not-following").addClass("following");
                kmqp(['record', 'added friend']);
            } else {
                $("#follow_closet_"+response.user_id).removeClass("following").addClass("not-following");
            }
            if ($("div#user_"+response.user_id).length > 0) {
                var current = parseInt(response.num_groupies);
                current == 1 ? $("div#user_"+response.user_id + " p span.groupie_count a.groupie-count").html("<strong>"+current+"</strong> <span>groupie</span>") : $("div#user_"+response.user_id + " p span.groupie_count a.groupie-count").html("<strong>"+current+"</strong> <span>groupies</span>");
            }
            alert(response.message);
        } else {
            alert(response.message);
        }
    }, "json");
}

function followUser (uid) {
        $.get("/favorites/follow/"+uid, function (response) { 
            alert(response.message);
            kmqp(['record', 'added friend']);
        }, "json");
}

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


function showSubnav (index) {
    if ((currentSubnavIndex != null) && (currentSubnavIndex != index)) {
        hideSubnav(currentSubnavIndex);
    }
    var sn = "#subnav_"+index;
    var mn = "#topnav_"+index;
    $(mn).addClass("hovered");
    $(sn).css("top",$("#top_nav").innerHeight() - 8);
    $(sn).css("left",$(mn).position().left);
    $(sn).slideDown(150);
    currentSubnavIndex = index;
}
function hideSubnav (index) {
    stopSubnavTimer();
    if ((index == null) && (currentSubnavIndex != null)) {
        $("#subnav_"+currentSubnavIndex).slideUp(150);
    } else {
        $("#subnav_"+index).slideUp(150);
    }
    $("li.hovered").removeClass("hovered");
    currentSubnavIndex = null;
}
function startSubnavTimer () {
    subnavTimeout = setTimeout(function () { hideSubnav(currentSubnavIndex); }, 300);
}
function stopSubnavTimer () {
    clearTimeout(subnavTimeout);
}
