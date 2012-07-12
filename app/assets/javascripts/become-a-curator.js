//= require rails.validations
//= require_self

var validation_elements = $('#new_curator_application').children('[data-validate="true"]').map(function(idx, el) {
        return $(el);
    }),
    $submit = $('#submit_application');

clientSideValidations.callbacks.element.fail = function(element, message, callback) {
    callback();

    if (element.data('valid') !== false) {
        if (element.data('tooltip') && element.data('tooltip').enabled == false) {
            element.tooltip('enable').tooltip('show');
        } else if (element.data('tooltip')) {
            element.tooltip('show');
        } else {
            var title_msg = element.attr('placeholder') + " " + message;
            element.tooltip({
                trigger: "focus",
                title: title_msg
            });
        }
    }
};

clientSideValidations.callbacks.form.fail = function(form, eventData) {
    $('#submit_application').tooltip({ title: "Please correct the errors in the fields marked with red border before submitting" }).tooltip('show');
};
