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
        <div class="questions dependence" id="advisor-question">
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

