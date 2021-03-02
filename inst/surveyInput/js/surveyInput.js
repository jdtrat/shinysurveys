// initialize option_number as 1 since we start with one option
var option_number = 1;

var shinySurveyBinding = new Shiny.InputBinding();
$.extend(shinySurveyBinding, {

  // find the dom element with input$id
  // this becomes el downstream
  find: function find(scope) {
    return $(scope).find(".surveyInput")
  },

  // Get the value of the custom input
  getValue: function getValue(el) {

    let question = $(el).find('#question_title').val();
    let input_type = $(el).find('#question_type').val();
    // remove punctuation and replace spaces with underscores and make all lowercase for input_id
    let input_id = question.replace(/[^a-zA-Z0-9_-]/g, '').split(' ').join('_').toLowerCase();
    let dependence = 'NA';
    let dependence_value = 'NA';
    let required = $(el).find('#question_required').prop('checked');

    // return values (data frame in R) of the form used in {shinysurveys}
    var values = [{
      "question": question,
      "option": $(el).find('#option_1').val(), // work on generalizing for any option
      "input_type": input_type,
      "input_id": input_id,
      "dependence": dependence, // GUI doesn't deal with dependencies now
      "dependence_value": dependence_value, // GUI doesn't deal with dependencies now
      "required": required
    }];

    return values

  },

  subscribe: function(el, callback) {
    // On any of these actions return the values via the getValue function
    $(el).find("#question_title").on("keyup", function(evt) {callback();})
    $(el).find("#question_type").change(function(evt) {callback();})
    $(el).find("#question_required").change(function(evt) {callback();})
    $(el).find("#option_1").on("keyup", function(evt) {callback();})


    // When the add_option button is clicked, insert another input element
    $(el).find("#add_option").on("click", function() {

      // unbind all Shiny inputs
      Shiny.unbindAll();

      // increment the option_number
      option_number++;

      // append to the option_placeholder a new input element
      $(el).find('#option_placeholder').append(
        '<div class=\"form-group shiny-input-container\" style=\"width:69%;\">' +
        '<label class=\"control-label\" id=\"option_' + option_number + 'label\" for=\"option_' + option_number + '\"></label>' +
        '<input id=\"option_' + option_number + '\" type=\"text\" class=\"form-control\" value=\"Placeholder\"/>' +
        '</div>'
      );

      // Bind all shiny inputs, including the newly inserted one.
      Shiny.bindAll();
    })
  },
  unsubscribe: function(el) {
    $(el).off(".shinySurveyBinding");
  }
});

Shiny.inputBindings.register(shinySurveyBinding, 'shinysurveys.surveyInput');
