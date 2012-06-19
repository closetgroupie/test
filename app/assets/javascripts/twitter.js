window.twttr = (function (d,s,id) {
   var t, js, fjs = d.getElementsByTagName(s)[0];
   if (d.getElementById(id)) return; js=d.createElement(s); js.id=id; js.async = true;
   js.src="//platform.twitter.com/widgets.js"; fjs.parentNode.insertBefore(js, fjs);
   return window.twttr || (t = { _e: [], ready: function(f){ t._e.push(f) } });
} (document, "script", "twitter-wjs"));

// TODO: Reimplement sensibly
// window.twttr.ready(function (t) {
//     t.events.bind('tweet', function(e) {
//         var query = e.target.search.replace(/^\?/, ''),
//             beg = query.indexOf('url=', 0),
//             end = query.lastIndexOf('&via=');
//         jQuery.post('/activity/twitter', { data: { 'query': query.substring(beg, end) } });
//     });
// });
