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
        <div class="questions">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" id="age-label" for="age">
                What's your age?
                <span class="required">*</span>
              </label>
              <input id="age" type="number" class="form-control" value="25"/>
            </div>
          </div>
        </div>
        <div class="questions">
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
        <div class="questions">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" id="education_attained-label" for="education_attained">What is the highest level of education you have attained?</label>
              <div>
                <select id="education_attained"><option value="Did not attend high school" selected>Did not attend high school</option>
    <option value="Some high school">Some high school</option>
    <option value="High school graduate">High school graduate</option>
    <option value="Some college">Some college</option>
    <option value="College">College</option>
    <option value="Graduate Work">Graduate Work</option></select>
                <script type="application/json" data-for="education_attained" data-nonempty="">{"plugins":["selectize-plugin-a11y"]}</script>
              </div>
            </div>
          </div>
        </div>
        <div class="questions">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" id="first_language-label" for="first_language">What was your first language?</label>
              <div>
                <select id="first_language"><option value="Arabic" selected>Arabic</option>
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
                <script type="application/json" data-for="first_language" data-nonempty="">{"plugins":["selectize-plugin-a11y"]}</script>
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
        <div class="questions">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" id="read_language-label" for="read_language">In what language do you read most often?</label>
              <div>
                <select id="read_language"><option value="Arabic" selected>Arabic</option>
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
                <script type="application/json" data-for="read_language" data-nonempty="">{"plugins":["selectize-plugin-a11y"]}</script>
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
        <div class="questions">
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
            <div class="form-group shiny-input-container">
              <label class="control-label" id="years_using_r-label" for="years_using_r">If yes, how many years have you been using R?</label>
              <input id="years_using_r" type="number" class="form-control" value="5"/>
            </div>
          </div>
        </div>
        <div class="questions">
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
        <div class="questions">
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
        <button id="submit" type="button" class="btn btn-default action-button">Submit</button>
      </div>
    </div>

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
          <div class="questions">
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
          <div class="questions">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="interests-label" for="interests">What are your research interests?</label>
                <input id="interests" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="goals-label" for="goals">What are your long term career goals?</label>
                <input id="goals" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions">
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
          <div class="questions">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="current_understanding-label" for="current_understanding">How would you rate your current understanding of the topics in this course (data science, exploratory data analysis, graphical data analysis)?</label>
                <input id="current_understanding" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions">
            <div class="question-input">
              <div class="form-group shiny-input-container">
                <label class="control-label" id="experience_with_r-label" for="experience_with_r">How much experience have you already had with R?</label>
                <input id="experience_with_r" type="text" class="form-control" value="" placeholder="Your Answer"/>
              </div>
            </div>
          </div>
          <div class="questions">
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
          <button id="submit" type="button" class="btn btn-default action-button">Submit</button>
        </div>
      </div>
    </div>

# surveyOutput() works - ranking_questions

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
            <h1 id="survey-title">Rank your favorite sushi rolls</h1>
          </div>
          <div class="questions">
            <div class="question-input">
              <div class="ranking">
                <div class="ranking-title">Please rank your favorite sushi rolls.</div>
                <div id="california" class="form-group shiny-input-radiogroup shiny-input-container shiny-input-container-inline" role="radiogroup" aria-labelledby="california-label">
                  <label class="control-label" id="california-label" for="california">California</label>
                  <div class="shiny-options-group">
                    <label class="radio-inline">
                      <input type="radio" name="california" value="1"/>
                      <span>1</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="california" value="2"/>
                      <span>2</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="california" value="3"/>
                      <span>3</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="california" value="4"/>
                      <span>4</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="california" value="5"/>
                      <span>5</span>
                    </label>
                  </div>
                </div>
                <div id="double_salmon" class="form-group shiny-input-radiogroup shiny-input-container shiny-input-container-inline" role="radiogroup" aria-labelledby="double_salmon-label">
                  <label class="control-label" id="double_salmon-label" for="double_salmon">Double Salmon</label>
                  <div class="shiny-options-group">
                    <label class="radio-inline">
                      <input type="radio" name="double_salmon" value="1"/>
                      <span>1</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="double_salmon" value="2"/>
                      <span>2</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="double_salmon" value="3"/>
                      <span>3</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="double_salmon" value="4"/>
                      <span>4</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="double_salmon" value="5"/>
                      <span>5</span>
                    </label>
                  </div>
                </div>
                <div id="florida" class="form-group shiny-input-radiogroup shiny-input-container shiny-input-container-inline" role="radiogroup" aria-labelledby="florida-label">
                  <label class="control-label" id="florida-label" for="florida">Florida</label>
                  <div class="shiny-options-group">
                    <label class="radio-inline">
                      <input type="radio" name="florida" value="1"/>
                      <span>1</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="florida" value="2"/>
                      <span>2</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="florida" value="3"/>
                      <span>3</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="florida" value="4"/>
                      <span>4</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="florida" value="5"/>
                      <span>5</span>
                    </label>
                  </div>
                </div>
                <div id="rainbow" class="form-group shiny-input-radiogroup shiny-input-container shiny-input-container-inline" role="radiogroup" aria-labelledby="rainbow-label">
                  <label class="control-label" id="rainbow-label" for="rainbow">Rainbow</label>
                  <div class="shiny-options-group">
                    <label class="radio-inline">
                      <input type="radio" name="rainbow" value="1"/>
                      <span>1</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="rainbow" value="2"/>
                      <span>2</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="rainbow" value="3"/>
                      <span>3</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="rainbow" value="4"/>
                      <span>4</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="rainbow" value="5"/>
                      <span>5</span>
                    </label>
                  </div>
                </div>
                <div id="volcano" class="form-group shiny-input-radiogroup shiny-input-container shiny-input-container-inline" role="radiogroup" aria-labelledby="volcano-label">
                  <label class="control-label" id="volcano-label" for="volcano">Volcano</label>
                  <div class="shiny-options-group">
                    <label class="radio-inline">
                      <input type="radio" name="volcano" value="1"/>
                      <span>1</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="volcano" value="2"/>
                      <span>2</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="volcano" value="3"/>
                      <span>3</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="volcano" value="4"/>
                      <span>4</span>
                    </label>
                    <label class="radio-inline">
                      <input type="radio" name="volcano" value="5"/>
                      <span>5</span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <button id="submit" type="button" class="btn btn-default action-button">Submit</button>
        </div>
      </div>
    </div>

