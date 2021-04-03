
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

Shiny.addCustomMessageHandler("get_title", function(params) {

  let title = $("#survey-title").html();

  if (typeof(title) !== "undefined") {
    message = title;
  } else {
    message = "NA";
  }

  Shiny.onInputChange("surveyTitle", message);

});
