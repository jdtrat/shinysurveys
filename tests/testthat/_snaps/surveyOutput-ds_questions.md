# surveyOutput() works - ds_questions

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
            <h1 id="survey-title">Getting To Know You</h1>
            <p id="survey-description">Welcome! This is a quick survey for us to become familiar with each other's backgrounds in this class.</p>
          </div>
          <div class="questions" id="name-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="name-label" for="name">
                  What is your name?
                  <span class="required">*</span>
                </label>
                <input id="name" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions dependence" id="advisor">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="advisor-label" for="advisor">Who's your advisor?</label>
                <input id="advisor" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions" id="interests-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="interests-label" for="interests">What are your research interests?</label>
                <input id="interests" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions" id="goals-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="goals-label" for="goals">What are your long term career goals?</label>
                <input id="goals" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions" id="other_courses-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="other_courses-label" for="other_courses">
                  What other courses are you taking / other big commitments?
                  <span class="required">*</span>
                </label>
                <input id="other_courses" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions" id="current_understanding-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="current_understanding-label" for="current_understanding">How would you rate your current understanding of the topics in this course (data science, exploratory data analysis, graphical data analysis)?</label>
                <input id="current_understanding" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions" id="experience_with_r-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="experience_with_r-label" for="experience_with_r">How much experience have you already had with R?</label>
                <input id="experience_with_r" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions" id="programming_experience-question">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="programming_experience-label" for="programming_experience">
                  In general, how much programming experience have you had?
                  <span class="required">*</span>
                </label>
                <input id="programming_experience" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="survey-buttons">
            <button id="submit" type="button" class="btn btn-default action-button">Submit</button>
          </div>
        </div>
      </div>
    </div>

