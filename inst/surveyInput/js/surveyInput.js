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

    // make an array of the length of the options class
    // then we'll use map to create elements for each item in the array

    // TODO now this is an interesting problem:
    //      this is only getting updated when you click the + sign,
    //      Im thinking that's because our subscribe is looking for a click
    //      So I guess we also need to listen for the text to change.... maybe?
    let values = [...Array(($(".options").length)).keys()].map(i => ({
      "question": question,
      // use the index to get the id of each option
      "option": $(el).find('#option_' + i).val(), // work on generalizing for any option
      "input_type": input_type,
      "input_id": input_id,
      "dependence": dependence, // GUI doesn't deal with dependencies now
      "dependence_value": dependence_value, // GUI doesn't deal with dependencies now
      "required": required
    }))

    // this looks way better than in R lol
    // TODO clean this up before returning to R
    //      would be cool to have a list or DF
    console.log(values)

    return(JSON.stringify(values));

  },

  subscribe: function(el, callback) {
    // On any of these actions return the values via the getValue function
    // TODO register the keyup for all inputs... this isn't quite working
    // something like find all the inputs inside options class and listen to them?
    // $(el).find(".options input").on("keyup", function(evt) {callback();})
    $(el).find("#option_1").on("keyup", function(evt) {callback();})

    $(el).find("#question_title").on("keyup", function(evt) {callback();})
    $(el).find("#question_type").change(function(evt) {callback();})
    $(el).find("#question_required").change(function(evt) {callback();})


    // When the add_option button is clicked, insert another input element
    $(el).find("#add_option").on("click", function() {

      // increment the option_number
      option_number++;

      // unbind all Shiny inputs
     Shiny.unbindAll(el);

$('<div class="options"><div class=\"form-group shiny-input-container\" style=\"width:69%;\">' +
        '<label class=\"control-label\" id=\"option_' + option_number + 'label\" for=\"option_' + option_number + '\"></label>' +
        '<input id=\"option_' + option_number + '\" type=\"text\" class=\"form-control\" value=\"Placeholder\"/>' +
        '</div></div>')
.insertAfter($('.options').last());

      // Bind all shiny inputs, including the newly inserted one.
     Shiny.bindAll(el);
    })
  },
  unsubscribe: function(el) {
    $(el).off(".shinySurveyBinding");
  },
  getType: function(el) {
    return "surveyInput.questionDataFrame";
  }
});

Shiny.inputBindings.register(shinySurveyBinding, 'shinysurveys.surveyInput');
