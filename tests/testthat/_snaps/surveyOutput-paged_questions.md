# surveyOutput() works - paged_questions

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
        <div class="page page-visible" id="page-1">
          <div class="title-description">
            <h1 id="survey-title">Test This MultiPaged Survey</h1>
            <p id="survey-description">Welcome! This is a quick survey for us to become familiar with each other's backgrounds in this class.</p>
          </div>
          <div class="questions" id="age-question">
            <div class="question-input">
              <div class="surveyNumericInput form-group shiny-input-container">
                <label class="control-label" id="age-label" for="age">
                  What's your age?
                  <span class="required">*</span>
                </label>
                <input id="age" type="number" class="form-control" placeholder="25"/>
              </div>
            </div>
          </div>
          <div class="questions" id="gender-question">
            <div class="question-input">
              <div id="gender" class="form-group shiny-input-radiogroup shiny-input-container" role="radiogroup" aria-labelledby="gender-label">
                <label class="control-label" id="gender-label" for="gender">
                  Which best describes your gender?
                  <span class="required">*</span>
                </label>
                <div class="shiny-options-group">
                  <div class="radio">
                    <label>
                      <input type="radio" name="gender" value="Female"/>
                      <span>Female</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="gender" value="Male"/>
                      <span>Male</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="gender" value="Prefer not to say"/>
                      <span>Prefer not to say</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="gender" value="Prefer to self describe"/>
                      <span>Prefer to self describe</span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="questions dependence" id="self_describe_gender-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="self_describe_gender-label" for="self_describe_gender">Which best describes your gender?</label>
                <input id="self_describe_gender" type="text" class="form-control" value="" placeholder="Placeholder"/>
              </div>
            </div>
          </div>
          <div class="questions" id="education_attained-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="education_attained-label" for="education_attained">What is the highest level of education you have attained?</label>
                <div>
                  <select id="education_attained" class="form-control"><option value="Did not attend high school" selected>Did not attend high school</option>
    <option value="Some high school">Some high school</option>
    <option value="High school graduate">High school graduate</option>
    <option value="Some college">Some college</option>
    <option value="College">College</option>
    <option value="Graduate Work">Graduate Work</option></select>
                  <script type="application/json" data-for="education_attained" data-eval="[&quot;onInitialize&quot;]">{"placeholder":"","onInitialize":"function() { this.setValue(\"\"); }","plugins":["selectize-plugin-a11y"]}</script>
                </div>
              </div>
            </div>
          </div>
          <div class="survey-buttons">
            <button id="next-1" type="button" class="btn btn-default action-button" page-action="next">Next</button>
          </div>
        </div>
        <div class="page page-hidden" id="page-2">
          <div class="questions" id="first_language-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="first_language-label" for="first_language">What was your first language?</label>
                <div>
                  <select id="first_language" class="form-control"><option value="Arabic" selected>Arabic</option>
    <option value="Armenian">Armenian</option>
    <option value="Chinese">Chinese</option>
    <option value="English">English</option>
    <option value="French">French</option>
    <option value="Creole">Creole</option>
    <option value="German">German</option>
    <option value="Greek">Greek</option>
    <option value="Gujarati">Gujarati</option>
    <option value="Hebrew">Hebrew</option>
    <option value="Hindi">Hindi</option>
    <option value="Italian">Italian</option>
    <option value="Japanese">Japanese</option>
    <option value="Other">Other</option></select>
                  <script type="application/json" data-for="first_language" data-eval="[&quot;onInitialize&quot;]">{"placeholder":"","onInitialize":"function() { this.setValue(\"\"); }","plugins":["selectize-plugin-a11y"]}</script>
                </div>
              </div>
            </div>
          </div>
          <div class="questions dependence" id="first_language_other-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="first_language_other-label" for="first_language_other">What was your first language?</label>
                <input id="first_language_other" type="text" class="form-control" value="" placeholder="Placeholder"/>
              </div>
            </div>
          </div>
          <div class="questions" id="read_language-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="read_language-label" for="read_language">In what language do you read most often?</label>
                <div>
                  <select id="read_language" class="form-control"><option value="Arabic" selected>Arabic</option>
    <option value="Armenian">Armenian</option>
    <option value="Chinese">Chinese</option>
    <option value="English">English</option>
    <option value="French">French</option>
    <option value="Creole">Creole</option>
    <option value="German">German</option>
    <option value="Greek">Greek</option>
    <option value="Gujarati">Gujarati</option>
    <option value="Hebrew">Hebrew</option>
    <option value="Hindi">Hindi</option>
    <option value="Italian">Italian</option>
    <option value="Japanese">Japanese</option>
    <option value="Other">Other</option></select>
                  <script type="application/json" data-for="read_language" data-eval="[&quot;onInitialize&quot;]">{"placeholder":"","onInitialize":"function() { this.setValue(\"\"); }","plugins":["selectize-plugin-a11y"]}</script>
                </div>
              </div>
            </div>
          </div>
          <div class="questions dependence" id="read_language_other-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="read_language_other-label" for="read_language_other">In what language do you read most often?</label>
                <input id="read_language_other" type="text" class="form-control" value="" placeholder="Placeholder"/>
              </div>
            </div>
          </div>
          <div class="survey-buttons">
            <button id="previous-2" type="button" class="btn btn-default action-button" page-action="previous">Previous</button>
            <button id="next-2" type="button" class="btn btn-default action-button" page-action="next">Next</button>
          </div>
        </div>
        <div class="page page-hidden" id="page-3">
          <div class="questions" id="learned_r-question">
            <div class="question-input">
              <div id="learned_r" class="form-group shiny-input-radiogroup shiny-input-container" role="radiogroup" aria-labelledby="learned_r-label">
                <label class="control-label" id="learned_r-label" for="learned_r">
                  Have you ever learned to program in R?
                  <span class="required">*</span>
                </label>
                <div class="shiny-options-group">
                  <div class="radio">
                    <label>
                      <input type="radio" name="learned_r" value="Yes"/>
                      <span>Yes</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="learned_r" value="No"/>
                      <span>No</span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="questions dependence" id="years_using_r-question">
            <div class="question-input">
              <div class="surveyNumericInput form-group shiny-input-container">
                <label class="control-label" id="years_using_r-label" for="years_using_r">If yes, how many years have you been using R?</label>
                <input id="years_using_r" type="number" class="form-control" placeholder="5"/>
              </div>
            </div>
          </div>
          <div class="questions" id="learned_programming_not_r-question">
            <div class="question-input">
              <div id="learned_programming_not_r" class="form-group shiny-input-radiogroup shiny-input-container" role="radiogroup" aria-labelledby="learned_programming_not_r-label">
                <label class="control-label" id="learned_programming_not_r-label" for="learned_programming_not_r">
                  Have you ever learned a programming language (other than R)?
                  <span class="required">*</span>
                </label>
                <div class="shiny-options-group">
                  <div class="radio">
                    <label>
                      <input type="radio" name="learned_programming_not_r" value="Yes"/>
                      <span>Yes</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="learned_programming_not_r" value="No"/>
                      <span>No</span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="questions dependence" id="years_programming_not_r-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="years_programming_not_r-label" for="years_programming_not_r">If yes, which language(s) and how many years have you been using each language?</label>
                <input id="years_programming_not_r" type="text" class="form-control" value="" placeholder="Placeholder"/>
              </div>
            </div>
          </div>
          <div class="questions" id="completed_data_analysis-question">
            <div class="question-input">
              <div id="completed_data_analysis" class="form-group shiny-input-radiogroup shiny-input-container" role="radiogroup" aria-labelledby="completed_data_analysis-label">
                <label class="control-label" id="completed_data_analysis-label" for="completed_data_analysis">
                  Have you ever completed a data analysis?
                  <span class="required">*</span>
                </label>
                <div class="shiny-options-group">
                  <div class="radio">
                    <label>
                      <input type="radio" name="completed_data_analysis" value="Yes"/>
                      <span>Yes</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="completed_data_analysis" value="No"/>
                      <span>No</span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="questions dependence" id="number_completed_data_analysis-question">
            <div class="question-input">
              <div id="number_completed_data_analysis" class="form-group shiny-input-radiogroup shiny-input-container" role="radiogroup" aria-labelledby="number_completed_data_analysis-label">
                <label class="control-label" id="number_completed_data_analysis-label" for="number_completed_data_analysis">If yes, approximately how many data analyses have you completed?</label>
                <div class="shiny-options-group">
                  <div class="radio">
                    <label>
                      <input type="radio" name="number_completed_data_analysis" value="0 to 5"/>
                      <span>0 to 5</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="number_completed_data_analysis" value="5 to 10"/>
                      <span>5 to 10</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="number_completed_data_analysis" value="10 to 15"/>
                      <span>10 to 15</span>
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="number_completed_data_analysis" value="15+"/>
                      <span>15+</span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="survey-buttons">
            <button id="previous-3" type="button" class="btn btn-default action-button" page-action="previous">Previous</button>
            <button id="submit" type="button" class="btn btn-default action-button">Submit</button>
          </div>
        </div>
      </div>
    </div>

