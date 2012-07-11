//= require rails.validations
//= require_self
clientSideValidations.callbacks.element.fail = function(element, message, callback) {
    callback();
    if (element.data('valid') !== false) {
    //     console.log('invalid');
        var title_msg = element.attr('placeholder') + " " + message;
        element.attr('title', title_msg);
        element.tooltip({ trigger: "focus" }).tooltip('show');
    //     // element.parent().find('.message').hide().show('slide', {direction: "left", easing: "easeOutBounce"}, 500);
    }
};

clientSideValidations.callbacks.element.pass = function(element, callback) {
    // Take note how we're passing the callback to the hide() 
    // method so it is run after the animation is complete.
    callback();
    element.tooltip('disable');
    // element.parent().find('.message').hide('slide', {direction: "left"}, 500, callback);
};

// clientSideValidations.callback.form.pass = function(form, eventData) {
//     $('#submit_application').attr('disabled', 'disabled');
// };
