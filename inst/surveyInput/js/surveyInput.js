var shinySurveyBinding = new Shiny.InputBinding();
$.extend(shinySurveyBinding, {

  // find the dom element with input$id
  // this becomes el downstream
  find: function find(scope) {
    return $(scope).find(".surveyInput")
  },

  // get the data-anatomy of the element with class selected
  // use this as the input's value
  // SEE subscribe
  getValue: function getValue(el) {
    var title = $(el).find('#question_title').val()
    return title
  },

  // on click, remove any previous selected classes
  // then add the selected class to the clicked limb
  // this is used in getValue
  subscribe: function(el, callback) {

    $(el).find("#question_title").on("keyup", function(evt) {

   // $(el).on("click.shinySurveyInput", function(evt) {
      // remove all of the selected classes inside our element
      // $(el).find(".selected").removeClass("selected");
      // set the selected class to the closest clicked part
      //console.log($(evt.target).attr('id'))
      // $(evt.target).addClass('selected');
      callback();
    })
  },
  unsubscribe: function(el) {
    $(el).off(".shinySurveyBinding");
  }
});

Shiny.inputBindings.register(shinySurveyBinding, 'shinysurveys.surveyInput');
