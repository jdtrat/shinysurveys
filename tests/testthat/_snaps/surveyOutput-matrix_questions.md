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
      });</script>
      <style>@import url("https://fonts.googleapis.com/css?family=Source+Code+Pro|Montserrat|Raleway");
    body {
      font-family: 'Raleway', sans-serif;
      background-color: #b0dbff;
    }
    
    h1, h2, h3, h4, h5, h6 {
      color: #333;
      font-family: 'Montserrat', sans-serif;
    }
    
    h1, h2, h3 {
      text-transform: uppercase;
      text-align: left;
      letter-spacing: .1em;
      line-height: 1.2;
    }
    
    h1 {
      font-size: 3rem;
      margin: 36px 0;
    }
    
    h1.title {
      color: #416983;
    }
    
    h3 {
      font-style: italic;
      font-family: 'Montserrat', sans-serif;
    }
    
    p {
      color: #333;
      margin: 35px;
      margin-bottom: 10px;
      font-family: 'Raleway', sans-serif;
    }
    
    li.l {
      margin-left: 40px;
      margin-right: 35px;
    }
    
    input[type=text]:focus {
      border-bottom: 1.5px solid #4aacff;
      -webkit-box-shadow: none;
    }
    
    input[type=text] {
      font-size: 1.5rem;
      border: none;
      box-shadow: none;
      border-radius: 0;
      border-bottom: 1px dashed rgba(0, 0, 0, 0.12);
      padding: 15px 0;
      outline: none;
      color: #3A506B;
      background-color: transparent;
    }
    
    label {
      margin-bottom: 10px;
      font-size: 1.5rem;
    }
    
    .required {
      color: red;
    }
    
    .container-fluid .survey {
      padding: 20px;
      padding-left: 20%;
      padding-right: 20%;
    }
    
    @media (max-width: 1195px) {
      .container-fluid .survey {
        padding-left: 15%;
        padding-right: 15%;
      }
    }
    
    @media (max-width: 992px) {
      .container-fluid .survey {
        padding-left: 12.5%;
        padding-right: 12.5%;
      }
    }
    
    @media (max-width: 767px) {
      .container-fluid .survey {
        padding-left: 10%;
        padding-right: 10%;
      }
    }
    
    @media (max-width: 575px) {
      .container-fluid .survey {
        padding-left: 7.5%;
        padding-right: 7.5%;
      }
    }
    
    .container-fluid .survey .title-description {
      background-color: white;
      border-radius: 20px;
      border-top: 20px solid #30a1ff;
      padding-left: 5%;
      padding-right: 5%;
      padding-bottom: 10px;
      margin-bottom: 12px;
    }
    
    .container-fluid .survey .title-description #survey-description {
      text-align: center;
      margin: 2px;
      font-size: 1.8rem;
    }
    
    .container-fluid .survey .title-description #survey-title {
      text-align: center;
      margin-top: 20px;
      margin-bottom: 12px;
    }
    
    .container-fluid .survey .page-hidden {
      display: none;
    }
    
    .container-fluid .survey .questions {
      display: grid;
      background-color: white;
      border: 0.5px solid #CCCCCC;
      border-radius: 10px;
      margin-bottom: 12px;
      padding: 10px;
      min-height: 138px;
      font-size: 1.4rem;
    }
    
    .container-fluid .survey .questions.dependence {
      padding: 0;
      display: none;
    }
    
    .container-fluid .survey .questions .question-input {
      margin: auto;
      width: 100%;
    }
    
    .container-fluid .survey .questions .question-input .shiny-input-container {
      width: 100%;
      padding: 0;
    }
    </style>
      <div class="survey">
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
                  <th></th>
                  <th>Disagree</th>
                  <th>Neutral</th>
                  <th>Agree</th>
                </tr>
                <tbody>
                  <tr class="radio-matrix-buttons" id="tr-i_love_sushi">
                    <td class="radio-matrix-buttons-label" id="td-i_love_sushi">I love sushi.</td>
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
                    <td class="radio-matrix-buttons-label" id="td-i_love_chocolate">I love chocolate.</td>
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
                  <th></th>
                  <th>Strongly Disagree</th>
                  <th>Disagree</th>
                  <th>Neutral</th>
                  <th>Agree</th>
                  <th>Strongly Agree</th>
                </tr>
                <tbody>
                  <tr class="radio-matrix-buttons" id="tr-goat_cheese_is_the_goat">
                    <td class="radio-matrix-buttons-label" id="td-goat_cheese_is_the_goat">Goat cheese is the GOAT.</td>
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
                    <td class="radio-matrix-buttons-label" id="td-yogurt_and_berries_are_a_great_snack">Yogurt and berries are a great snack.</td>
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
                    <td class="radio-matrix-buttons-label" id="td-sunbutter_is_a_fantastic_alternative_to_peanut_butter">SunButter® is a fantastic alternative to peanut butter.</td>
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

# surveyOutput() works - required matrix questions

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
      });</script>
      <style>@import url("https://fonts.googleapis.com/css?family=Source+Code+Pro|Montserrat|Raleway");
    body {
      font-family: 'Raleway', sans-serif;
      background-color: #b0dbff;
    }
    
    h1, h2, h3, h4, h5, h6 {
      color: #333;
      font-family: 'Montserrat', sans-serif;
    }
    
    h1, h2, h3 {
      text-transform: uppercase;
      text-align: left;
      letter-spacing: .1em;
      line-height: 1.2;
    }
    
    h1 {
      font-size: 3rem;
      margin: 36px 0;
    }
    
    h1.title {
      color: #416983;
    }
    
    h3 {
      font-style: italic;
      font-family: 'Montserrat', sans-serif;
    }
    
    p {
      color: #333;
      margin: 35px;
      margin-bottom: 10px;
      font-family: 'Raleway', sans-serif;
    }
    
    li.l {
      margin-left: 40px;
      margin-right: 35px;
    }
    
    input[type=text]:focus {
      border-bottom: 1.5px solid #4aacff;
      -webkit-box-shadow: none;
    }
    
    input[type=text] {
      font-size: 1.5rem;
      border: none;
      box-shadow: none;
      border-radius: 0;
      border-bottom: 1px dashed rgba(0, 0, 0, 0.12);
      padding: 15px 0;
      outline: none;
      color: #3A506B;
      background-color: transparent;
    }
    
    label {
      margin-bottom: 10px;
      font-size: 1.5rem;
    }
    
    .required {
      color: red;
    }
    
    .container-fluid .survey {
      padding: 20px;
      padding-left: 20%;
      padding-right: 20%;
    }
    
    @media (max-width: 1195px) {
      .container-fluid .survey {
        padding-left: 15%;
        padding-right: 15%;
      }
    }
    
    @media (max-width: 992px) {
      .container-fluid .survey {
        padding-left: 12.5%;
        padding-right: 12.5%;
      }
    }
    
    @media (max-width: 767px) {
      .container-fluid .survey {
        padding-left: 10%;
        padding-right: 10%;
      }
    }
    
    @media (max-width: 575px) {
      .container-fluid .survey {
        padding-left: 7.5%;
        padding-right: 7.5%;
      }
    }
    
    .container-fluid .survey .title-description {
      background-color: white;
      border-radius: 20px;
      border-top: 20px solid #30a1ff;
      padding-left: 5%;
      padding-right: 5%;
      padding-bottom: 10px;
      margin-bottom: 12px;
    }
    
    .container-fluid .survey .title-description #survey-description {
      text-align: center;
      margin: 2px;
      font-size: 1.8rem;
    }
    
    .container-fluid .survey .title-description #survey-title {
      text-align: center;
      margin-top: 20px;
      margin-bottom: 12px;
    }
    
    .container-fluid .survey .page-hidden {
      display: none;
    }
    
    .container-fluid .survey .questions {
      display: grid;
      background-color: white;
      border: 0.5px solid #CCCCCC;
      border-radius: 10px;
      margin-bottom: 12px;
      padding: 10px;
      min-height: 138px;
      font-size: 1.4rem;
    }
    
    .container-fluid .survey .questions.dependence {
      padding: 0;
      display: none;
    }
    
    .container-fluid .survey .questions .question-input {
      margin: auto;
      width: 100%;
    }
    
    .container-fluid .survey .questions .question-input .shiny-input-container {
      width: 100%;
      padding: 0;
    }
    </style>
      <div class="survey">
        <div style="display: none !important;">
          <div class="form-group shiny-input-container">
            <label class="control-label" id="userID-label" for="userID">Enter your username.</label>
            <input id="userID" type="text" class="form-control" value="NO_USER_ID"/>
          </div>
        </div>
        <div class="title-description">
          <h1 id="survey-title">Testing Matrix Questions - Required</h1>
        </div>
        <div class="questions" id="matId-question">
          <div class="question-input">
            <div class="radioMatrixInput" id="matId">
              <table>
                <tr>
                  <th class="required" style="font-size: 18px;">*</th>
                  <th>Disagree</th>
                  <th>Neutral</th>
                  <th>Agree</th>
                </tr>
                <tbody>
                  <tr class="radio-matrix-buttons" id="tr-i_love_sushi">
                    <td class="radio-matrix-buttons-label" id="td-i_love_sushi">I love sushi.</td>
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
                    <td class="radio-matrix-buttons-label" id="td-i_love_chocolate">I love chocolate.</td>
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
              <label class="control-label" id="favorite_food-label" for="favorite_food">
                What's your favorite food?
                <span class="required">*</span>
              </label>
              <input id="favorite_food" type="text" class="form-control" value="" placeholder="text"/>
            </div>
          </div>
        </div>
        <div class="questions" id="matId2-question">
          <div class="question-input">
            <div class="radioMatrixInput" id="matId2">
              <table>
                <tr>
                  <th class="required" style="font-size: 18px;">*</th>
                  <th>Strongly Disagree</th>
                  <th>Disagree</th>
                  <th>Neutral</th>
                  <th>Agree</th>
                  <th>Strongly Agree</th>
                </tr>
                <tbody>
                  <tr class="radio-matrix-buttons" id="tr-goat_cheese_is_the_goat">
                    <td class="radio-matrix-buttons-label" id="td-goat_cheese_is_the_goat">Goat cheese is the GOAT.</td>
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
                    <td class="radio-matrix-buttons-label" id="td-yogurt_and_berries_are_a_great_snack">Yogurt and berries are a great snack.</td>
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
                    <td class="radio-matrix-buttons-label" id="td-sunbutter_is_a_fantastic_alternative_to_peanut_butter">SunButter® is a fantastic alternative to peanut butter.</td>
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

