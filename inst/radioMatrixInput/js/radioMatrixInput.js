var radioMatrixBinding = new Shiny.InputBinding();

$.extend(radioMatrixBinding, {

  find: function(scope) {
    return $(scope).find(".radioMatrixInput");
  },

  getValue: function(el) {

    checked = $(el).find('input:checked');

    var values = [...Array(checked.length).keys()].map(i => ({
      "question_id": $(checked[i]).attr('name'),
      "response": $(checked[i]).attr('value')
    }));

    console.log(values);
    return(JSON.stringify(values));

  },

  // on click, uncheck the previously selected input and check the new one.
  subscribe: function(el, callback) {

    $(el).on("change.radioMatrixBinding", function(evt) {

      $(evt.target).prop("checked", true);

      callback();

    });
  },
  unsubscribe: function(el) {
    $(el).off(".radioMatrixInput");
  },

  getType: function(el) {
    return "radioMatrixInput.dataframe";
  }


});

Shiny.inputBindings.register(radioMatrixBinding);

