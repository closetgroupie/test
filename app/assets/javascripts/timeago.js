;(function($) {
    // timeago settings
    $.timeago.settings.strings = {
        prefixAgo: null,
        suffixAgo: null,
        seconds: "few seconds ago",
        minute: "a minute ago",
        minutes: "%d minutes ago",
        hour: "an hour ago",
        hours: "%d hours ago",
        day: "yesterday",
        days: "%d days ago",
        month: "last month",
        months: "%d months ago",
        year: "a year ago",
        years: "%d years ago"
    };
    // call timeago
    $("abbr.timeago").timeago();
})(jQuery)
