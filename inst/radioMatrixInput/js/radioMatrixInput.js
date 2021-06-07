var matrixRadioBinding = new Shiny.InputBinding();
$.extend(matrixRadioBinding, {

  find: function find(scope) {
    return $(scope).find(".matrix-radio-buttons")
  },

  getValue: function getValue(el) {

    var value = $(el).find('input:checked').attr('value')

    return value
  },

  // on click, uncheck the previously selected input and check the new one.
  subscribe: function(el, callback) {
    $(el).on("click.matrixRadioBinding", function(evt) {

      // uncheck the currently checked button
      $(el).find('input:checked').prop('checked', false);

      // check the radio button that was clicked on
      $(evt.target).prop("checked", true);
      callback();
    })
  },
  unsubscribe: function(el) {
    $(el).off(".matrixRadioBinding");
  }
});

Shiny.inputBindings.register(matrixRadioBinding);

