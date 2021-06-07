var radioMatrixBinding = new Shiny.InputBinding();

$.extend(radioMatrixBinding, {

  find: function(scope) {
    return $(scope).find(".radio-matrix-buttons");
  },

  getValue: function(el) {

    var value = $(el).find('input:checked').attr('value')
    console.log(value);
    return value;

  },

  // on click, uncheck the previously selected input and check the new one.
  subscribe: function(el, callback) {

    $(el).on("change.radioMatrixBinding", function(evt) {
      // uncheck the currently checked button
      $(el).find('input:checked').prop('checked', false);
      // check the radio button that was clicked on
      $(evt.target).prop("checked", true);

      callback();

    });
  },
  unsubscribe: function(el) {
    $(el).off(".radio-matrix-buttons");
  }
});

Shiny.inputBindings.register(radioMatrixBinding);

