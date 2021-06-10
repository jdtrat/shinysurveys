# surveyOutput() works - teaching_r_questions

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
    <script>$(document).on("shiny:connected", function() {
        Shiny.setInputValue('shinysurveysConnected', true);
        var initial_values;
    
      });
    
    $(document).ready(function() {
      console.log('ready!');
      // Whenever a question-input changes, let's
         $('.question-input').on('change', function() {
          console.log($(this).attr('id'));
          console.log('something changed');
        });
    });
    
    Shiny.addCustomMessageHandler("get_default_values", function(inputIds) {
      console.log(inputIds);
      initial_values = inputIds;
    });
    
    
    
    </script>
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
          <h1 id="survey-title">Testing Title</h1>
          <p id="survey-description">Testing Description</p>
        </div>
        <div class="questions" id="age-question">
          <div class="question-input">
            <div class="surveyNumericInput">
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
        <div class="questions dependence" id="self_describe_gender">
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
        <div class="questions dependence" id="first_language_other">
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
        <div class="questions dependence" id="read_language_other">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" id="read_language_other-label" for="read_language_other">In what language do you read most often?</label>
              <input id="read_language_other" type="text" class="form-control" value="" placeholder="Placeholder"/>
            </div>
          </div>
        </div>
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
        <div class="questions dependence" id="years_using_r">
          <div class="question-input">
            <div class="surveyNumericInput">
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
        <div class="questions dependence" id="years_programming_not_r">
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
        <div class="questions dependence" id="number_completed_data_analysis">
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
          <button id="submit" type="button" class="btn btn-default action-button">Submit</button>
        </div>
      </div>
    </div>

