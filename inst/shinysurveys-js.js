
Shiny.addCustomMessageHandler("add_class", function(params) {
  $("#" + params.input_id).addClass(params.class_name);
});

Shiny.addCustomMessageHandler("remove_class", function(params) {
  $("#" + params.input_id).removeClass(params.class_name);
});

Shiny.addCustomMessageHandler("disable", function(params) {
  $el = $("#" + params.input_id);
  $el.prop("disabled", true);
  $el.addClass("disabled");
});

Shiny.addCustomMessageHandler("enable", function(params) {
  $el = $("#" + params.input_id);
  $el.prop("disabled", false);
  $el.removeClass("disabled");
});

Shiny.addCustomMessageHandler('hideSurvey', function(_) {
  $('.survey').hide();
});


$(document).ready(function() {
  // When one of the buttons are clicked, get the current page
  // from the button ID.
  $('.survey-buttons .btn').on('click', function(e) {
    console.log("Hello");
    current_id = $(e.target).attr('id');
    current_page = parseInt(current_id.split('-')[1]);

    // If the button is a "next" button, hide current page and show the next one
    if ($(e.target).attr('page-action') === 'next') {

      next_page = current_page + 1;

      $('#page-' + current_page).addClass('page-hidden');
      $('#page-' + current_page).removeClass('page-visible');
      $('#page-' + next_page).removeClass('page-hidden');
      $('#page-' + next_page).addClass('page-visible');

    // If the button is a "previous" button, hide current page and show the previous one

    } else if ($(e.target).attr('page-action') === 'previous') {

      previous_page = current_page - 1;

      $('#page-' + current_page).addClass('page-hidden');
      $('#page-' + current_page).removeClass('page-visible');
      $('#page-' + previous_page).removeClass('page-hidden');
      $('#page-' + previous_page).addClass('page-visible');

    }

  });

});
