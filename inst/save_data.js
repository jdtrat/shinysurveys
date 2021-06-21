
// define debounce function
const debounce = function(func, delay) {
  let timeout;

  return function executed(...args) {
    const later = function() {
      clearTimeout(timeout);
      func(...args);
    };

    clearTimeout(timeout);
    timeout = setTimeout(later, delay);

  };

};

$(document).on("shiny:connected", function() {
    Shiny.setInputValue('shinysurveysConnected', true);
    var initial_values;

    function getHiddenInputs() {

    hiddenDivs = $('.dependence');
    var hiddenInputIds = [];
    var i;

    for (i = 0; i < hiddenDivs.length; i++) {
      hiddenInputIds[i] = $(hiddenDivs[i]).attr('id').split('-question')[0];
    }
      Shiny.setInputValue('shinysurveysHiddenInputs', hiddenInputIds);

    }

    var log_hidden_inputs = debounce(function() {
      getHiddenInputs();
     }, 1000)

    $('#submit').on('click', getHiddenInputs);

    $('.question-input').on('click', log_hidden_inputs);
  });
