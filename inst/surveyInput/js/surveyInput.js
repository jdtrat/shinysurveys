var shinySurveyBinding = new Shiny.InputBinding();
$.extend(shinySurveyBinding, {

  // find the dom element with input$id
  // this becomes el downstream
  find: function find(scope) {
    return $(scope).find(".surveyInput")
  },

  // Get the value of the custom input
  getValue: function getValue(el) {

    title = $(el).find('#question_title').val();

    // remove punctuation and replace spaces with underscores and make all lowercase for input_id
    identifier = title.replace(/[.,?'"\/#!$%\^&\*;:{}=\-_`~()]/g, '').split(' ').join('_').toLowerCase();

    // return values (data frame in R) of the form used in {shinysurveys}
    var values = [{
      "question": title,
      "option": $(el).find('#option_1').val(),
      "input_type": $(el).find('#question_type').val(),
      "input_id": identifier,
      "dependence": 'NA', // GUI doesn't deal with dependencies now
      "dependence_value": 'NA', // GUI doesn't deal with dependencies now
      "question_required": $(el).find('#question_required').prop('checked')
    }];

    return values
  },

  subscribe: function(el, callback) {
    // On any of these actions return the values via the getValue function
    $(el).find("#question_title").on("keyup", function(evt) {callback();})
    $(el).find("#question_type").change(function(evt) {callback();})
    $(el).find("#question_required").change(function(evt) {callback();})
    $(el).find("#option_1").on("keyup", function(evt) {callback();})

  },
  unsubscribe: function(el) {
    $(el).off(".shinySurveyBinding");
  }
});

Shiny.inputBindings.register(shinySurveyBinding, 'shinysurveys.surveyInput');
