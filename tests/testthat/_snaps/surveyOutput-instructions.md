# surveyOutput() works - instructions added

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
    
        $('#submit').on('click', getHiddenInputs);
    
        $('.question-input').on('click', log_hidden_inputs);
      });</script>
      <div class="survey">
        <div id="sass" class="shiny-html-output"></div>
        <div style="display: none !important;">
          <div class="form-group shiny-input-container">
            <label class="control-label" id="userID-label" for="userID">Enter your username.</label>
            <input id="userID" type="text" class="form-control" value="NO_USER_ID"/>
          </div>
        </div>
        <div class="title-description">
          <h1 id="survey-title">Testing Instructions</h1>
        </div>
        <div class="questions" id="age-question">
          <div class="question-input">
            <div class="question-instructions">In the following thing, please do this thing.</div>
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
          <button id="submit" type="button" class="btn btn-default action-button">Submit</button>
        </div>
      </div>
    </div>

# surveyOutput() works - instructions with matrix

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
    
        $('#submit').on('click', getHiddenInputs);
    
        $('.question-input').on('click', log_hidden_inputs);
      });</script>
      <div class="survey">
        <div id="sass" class="shiny-html-output"></div>
        <div style="display: none !important;">
          <div class="form-group shiny-input-container">
            <label class="control-label" id="userID-label" for="userID">Enter your username.</label>
            <input id="userID" type="text" class="form-control" value="NO_USER_ID"/>
          </div>
        </div>
        <div class="title-description">
          <h1 id="survey-title">Testing Instructions - Matrix</h1>
        </div>
        <div class="questions" id="matId_1-question">
          <div class="question-input">
            <div class="question-instructions">Please indicate how much you agree or disagree with the following statements:</div>
            <div class="radioMatrixInput" id="matId_1">
              <table>
                <tr>
                  <td></td>
                  <th>Strongly Disagree</th>
                  <th>Disagree</th>
                  <th>Neither Agree or Disagree</th>
                  <th>Agree</th>
                  <th>Strongly Agree</th>
                </tr>
                <tbody>
                  <tr class="radio-matrix-buttons" id="tr-my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences">
                    <td id="td-my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences">My team members can depend upon me as a 'safe space' when they are experiencing stressful workplace experiences.</td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-i_feel_competent_in_my_role_as_a_leader">
                    <td id="td-i_feel_competent_in_my_role_as_a_leader">I feel competent in my role as a leader</td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends">
                    <td id="td-i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends">I have a different identity as a leader than I do when I am with family or friends.</td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance">
                    <td id="td-the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance">The best way to get my team members to work independently is to keep them at a distance</td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-in_the_past_3_months_i_have_used_breathing_exercises">
                    <td id="td-in_the_past_3_months_i_have_used_breathing_exercises">In the past 3 months, I have used breathing exercises</td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-in_the_past_3_months_i_have_practiced_silencing_my_mind">
                    <td id="td-in_the_past_3_months_i_have_practiced_silencing_my_mind">In the past 3 months, I have practiced silencing my mind.</td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-i_communicate_the_emotions_i_am_feeling_to_my_team_members">
                    <td id="td-i_communicate_the_emotions_i_am_feeling_to_my_team_members">I communicate the emotions I am feeling to my team members.</td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings">
                    <td id="td-to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings">To check the words I use to express emotions with my body to see if the words are right for the feelings.</td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Strongly Agree"/>
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

# surveyOutput() works - instructions with matrix and teaching-r-questions

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
    
        $('#submit').on('click', getHiddenInputs);
    
        $('.question-input').on('click', log_hidden_inputs);
      });</script>
      <div class="survey">
        <div id="sass" class="shiny-html-output"></div>
        <div style="display: none !important;">
          <div class="form-group shiny-input-container">
            <label class="control-label" id="userID-label" for="userID">Enter your username.</label>
            <input id="userID" type="text" class="form-control" value="NO_USER_ID"/>
          </div>
        </div>
        <div class="title-description">
          <h1 id="survey-title">Testing Instructions - Matrix &amp; Teaching R Questions</h1>
        </div>
        <div class="questions" id="age-question">
          <div class="question-input">
            <div class="question-instructions">In the following thing, please do this thing.</div>
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
        <div class="questions" id="matId_1-question">
          <div class="question-input">
            <div class="question-instructions">Please indicate how much you agree or disagree with the following statements:</div>
            <div class="radioMatrixInput" id="matId_1">
              <table>
                <tr>
                  <td></td>
                  <th>Strongly Disagree</th>
                  <th>Disagree</th>
                  <th>Neither Agree or Disagree</th>
                  <th>Agree</th>
                  <th>Strongly Agree</th>
                </tr>
                <tbody>
                  <tr class="radio-matrix-buttons" id="tr-my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences">
                    <td id="td-my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences">My team members can depend upon me as a 'safe space' when they are experiencing stressful workplace experiences.</td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="my_team_members_can_depend_upon_me_as_a_safe_space_when_they_are_experiencing_stressful_workplace_experiences" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-i_feel_competent_in_my_role_as_a_leader">
                    <td id="td-i_feel_competent_in_my_role_as_a_leader">I feel competent in my role as a leader</td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_feel_competent_in_my_role_as_a_leader" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends">
                    <td id="td-i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends">I have a different identity as a leader than I do when I am with family or friends.</td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_have_a_different_identity_as_a_leader_than_i_do_when_i_am_with_family_or_friends" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance">
                    <td id="td-the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance">The best way to get my team members to work independently is to keep them at a distance</td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="the_best_way_to_get_my_team_members_to_work_independently_is_to_keep_them_at_a_distance" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-in_the_past_3_months_i_have_used_breathing_exercises">
                    <td id="td-in_the_past_3_months_i_have_used_breathing_exercises">In the past 3 months, I have used breathing exercises</td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_used_breathing_exercises" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-in_the_past_3_months_i_have_practiced_silencing_my_mind">
                    <td id="td-in_the_past_3_months_i_have_practiced_silencing_my_mind">In the past 3 months, I have practiced silencing my mind.</td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="in_the_past_3_months_i_have_practiced_silencing_my_mind" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-i_communicate_the_emotions_i_am_feeling_to_my_team_members">
                    <td id="td-i_communicate_the_emotions_i_am_feeling_to_my_team_members">I communicate the emotions I am feeling to my team members.</td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="i_communicate_the_emotions_i_am_feeling_to_my_team_members" value="Strongly Agree"/>
                    </td>
                  </tr>
                  <tr class="radio-matrix-buttons" id="tr-to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings">
                    <td id="td-to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings">To check the words I use to express emotions with my body to see if the words are right for the feelings.</td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Strongly Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Neither Agree or Disagree"/>
                    </td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Agree"/>
                    </td>
                    <td>
                      <input type="radio" name="to_check_the_words_i_use_to_express_emotions_with_my_body_to_see_if_the_words_are_right_for_the_feelings" value="Strongly Agree"/>
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

