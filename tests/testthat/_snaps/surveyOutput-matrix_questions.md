# surveyOutput() works - matrix questions

    <div class="container-fluid">
      <script>
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
    
    });</script>
      <script>
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
    
        // RETURN ALL DIVS WITH A DEPENDENCE AND OR A RADIO MATRIX INPUT
        // SINCE DATA SAVED WILL NEED TO IGNORE THE ALREADY PROCESSED OUTPUT
        // OF RADIO MATRIX INPUTS, WE WANT TO IGNORE THEM HERE.
        hiddenDivs = $('.dependence, .radioMatrixInput');
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
    
    
        // $('.questions:not(.dependence)').last().on('change', getHiddenInputs);
    
        $('#submit').on('click', getHiddenInputs);
    
        $('.question-input').on('click', log_hidden_inputs);
      });</script>
      <div class="grid">
        <div class="survey">
          <div id="sass" class="shiny-html-output"></div>
          <div style="display: none !important;">
            <div class="form-group shiny-input-container">
              <label class="control-label" id="userID-label" for="userID">Enter your username.</label>
              <input id="userID" type="text" class="form-control" value="NO_USER_ID"/>
            </div>
          </div>
          <div class="title-description">
            <h1 id="survey-title">Testing Matrix Questions</h1>
          </div>
          <div class="questions" id="matId-question">
            <div class="question-input">
              <div class="radioMatrixInput" id="matId">
                <table>
                  <tr>
                    <td></td>
                    <th>Disagree</th>
                    <th>Neutral</th>
                    <th>Agree</th>
                  </tr>
                  <tbody>
                    <tr class="radio-matrix-buttons" id="tr-i_love_sushi">
                      <td id="td-i_love_sushi">I love sushi.</td>
                      <td>
                        <input type="radio" name="i_love_sushi" value="Disagree"/>
                      </td>
                      <td>
                        <input type="radio" name="i_love_sushi" value="Neutral"/>
                      </td>
                      <td>
                        <input type="radio" name="i_love_sushi" value="Agree"/>
                      </td>
                    </tr>
                    <tr class="radio-matrix-buttons" id="tr-i_love_chocolate">
                      <td id="td-i_love_chocolate">I love chocolate.</td>
                      <td>
                        <input type="radio" name="i_love_chocolate" value="Disagree"/>
                      </td>
                      <td>
                        <input type="radio" name="i_love_chocolate" value="Neutral"/>
                      </td>
                      <td>
                        <input type="radio" name="i_love_chocolate" value="Agree"/>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="questions" id="favorite_food-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="favorite_food-label" for="favorite_food">What's your favorite food?</label>
                <input id="favorite_food" type="text" class="form-control" value="" placeholder="text"/>
              </div>
            </div>
          </div>
          <div class="questions" id="matId2-question">
            <div class="question-input">
              <div class="radioMatrixInput" id="matId2">
                <table>
                  <tr>
                    <td></td>
                    <th>Strongly Disagree</th>
                    <th>Disagree</th>
                    <th>Neutral</th>
                    <th>Agree</th>
                    <th>Strongly Agree</th>
                  </tr>
                  <tbody>
                    <tr class="radio-matrix-buttons" id="tr-goat_cheese_is_the_goat">
                      <td id="td-goat_cheese_is_the_goat">Goat cheese is the GOAT.</td>
                      <td>
                        <input type="radio" name="goat_cheese_is_the_goat" value="Strongly Disagree"/>
                      </td>
                      <td>
                        <input type="radio" name="goat_cheese_is_the_goat" value="Disagree"/>
                      </td>
                      <td>
                        <input type="radio" name="goat_cheese_is_the_goat" value="Neutral"/>
                      </td>
                      <td>
                        <input type="radio" name="goat_cheese_is_the_goat" value="Agree"/>
                      </td>
                      <td>
                        <input type="radio" name="goat_cheese_is_the_goat" value="Strongly Agree"/>
                      </td>
                    </tr>
                    <tr class="radio-matrix-buttons" id="tr-yogurt_and_berries_are_a_great_snack">
                      <td id="td-yogurt_and_berries_are_a_great_snack">Yogurt and berries are a great snack.</td>
                      <td>
                        <input type="radio" name="yogurt_and_berries_are_a_great_snack" value="Strongly Disagree"/>
                      </td>
                      <td>
                        <input type="radio" name="yogurt_and_berries_are_a_great_snack" value="Disagree"/>
                      </td>
                      <td>
                        <input type="radio" name="yogurt_and_berries_are_a_great_snack" value="Neutral"/>
                      </td>
                      <td>
                        <input type="radio" name="yogurt_and_berries_are_a_great_snack" value="Agree"/>
                      </td>
                      <td>
                        <input type="radio" name="yogurt_and_berries_are_a_great_snack" value="Strongly Agree"/>
                      </td>
                    </tr>
                    <tr class="radio-matrix-buttons" id="tr-sunbutter_is_a_fantastic_alternative_to_peanut_butter">
                      <td id="td-sunbutter_is_a_fantastic_alternative_to_peanut_butter">SunButter® is a fantastic alternative to peanut butter.</td>
                      <td>
                        <input type="radio" name="sunbutter_is_a_fantastic_alternative_to_peanut_butter" value="Strongly Disagree"/>
                      </td>
                      <td>
                        <input type="radio" name="sunbutter_is_a_fantastic_alternative_to_peanut_butter" value="Disagree"/>
                      </td>
                      <td>
                        <input type="radio" name="sunbutter_is_a_fantastic_alternative_to_peanut_butter" value="Neutral"/>
                      </td>
                      <td>
                        <input type="radio" name="sunbutter_is_a_fantastic_alternative_to_peanut_butter" value="Agree"/>
                      </td>
                      <td>
                        <input type="radio" name="sunbutter_is_a_fantastic_alternative_to_peanut_butter" value="Strongly Agree"/>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="survey-buttons">
            <button id="submit" type="button" class="btn btn-default action-button">Submit</button>
          </div>
        </div>
      </div>
    </div>

