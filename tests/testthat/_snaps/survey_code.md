# surveyOutput() works

    <div class="grid">
      <div class="survey">
        <div id="sass" class="shiny-html-output"></div>
        <div class="form-group shiny-input-container shinyjs-hide">
          <label class="control-label" for="userID">Enter your username.</label>
          <input id="userID" type="text" class="form-control" value="NO_USER_ID"/>
        </div>
        <div class="title-description">
          <h1 id="survey-title">Testing Title</h1>
          <p id="survey-description">Testing Description</p>
        </div>
        <div class="questions">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="age">
                What's your age?
                <span class="required">*</span>
              </label>
              <input id="age" type="number" class="form-control" value="25"/>
            </div>
          </div>
        </div>
        <div class="questions">
          <div class="question-input">
            <div id="gender" class="form-group shiny-input-radiogroup shiny-input-container">
              <label class="control-label" for="gender">
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
        <div class="questions dependence shinyjs-hide" id="self_describe_gender">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="self_describe_gender">Which best describes your gender?</label>
              <input id="self_describe_gender" type="text" class="form-control" value="Placeholder"/>
            </div>
          </div>
        </div>
        <div class="questions">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="education_attained">What is the highest level of education you have attained?</label>
              <div>
                <select id="education_attained"><option value="Did not attend high school" selected>Did not attend high school</option>
    <option value="Some high school">Some high school</option>
    <option value="High school graduate">High school graduate</option>
    <option value="Some college">Some college</option>
    <option value="College">College</option>
    <option value="Graduate Work">Graduate Work</option></select>
                <script type="application/json" data-for="education_attained" data-nonempty="">{}</script>
              </div>
            </div>
          </div>
        </div>
        <div class="questions">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="first_language">What was your first language?</label>
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
                <script type="application/json" data-for="first_language" data-nonempty="">{}</script>
              </div>
            </div>
          </div>
        </div>
        <div class="questions dependence shinyjs-hide" id="first_language_other">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="first_language_other">What was your first language?</label>
              <input id="first_language_other" type="text" class="form-control" value="Placeholder"/>
            </div>
          </div>
        </div>
        <div class="questions">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="read_language">In what language do you read most often?</label>
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
                <script type="application/json" data-for="read_language" data-nonempty="">{}</script>
              </div>
            </div>
          </div>
        </div>
        <div class="questions dependence shinyjs-hide" id="read_language_other">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="read_language_other">In what language do you read most often?</label>
              <input id="read_language_other" type="text" class="form-control" value="Placeholder"/>
            </div>
          </div>
        </div>
        <div class="questions">
          <div class="question-input">
            <div id="learned_r" class="form-group shiny-input-radiogroup shiny-input-container">
              <label class="control-label" for="learned_r">
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
        <div class="questions dependence shinyjs-hide" id="years_using_r">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="years_using_r">If yes, how many years have you been using R?</label>
              <input id="years_using_r" type="number" class="form-control" value="5"/>
            </div>
          </div>
        </div>
        <div class="questions">
          <div class="question-input">
            <div id="learned_programming_not_r" class="form-group shiny-input-radiogroup shiny-input-container">
              <label class="control-label" for="learned_programming_not_r">
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
        <div class="questions dependence shinyjs-hide" id="years_programming_not_r">
          <div class="question-input">
            <div class="form-group shiny-input-container">
              <label class="control-label" for="years_programming_not_r">If yes, which language(s) and how many years have you been using each language?</label>
              <input id="years_programming_not_r" type="text" class="form-control" value="Placeholder"/>
            </div>
          </div>
        </div>
        <div class="questions">
          <div class="question-input">
            <div id="completed_data_analysis" class="form-group shiny-input-radiogroup shiny-input-container">
              <label class="control-label" for="completed_data_analysis">
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
        <div class="questions dependence shinyjs-hide" id="number_completed_data_analysis">
          <div class="question-input">
            <div id="number_completed_data_analysis" class="form-group shiny-input-radiogroup shiny-input-container">
              <label class="control-label" for="number_completed_data_analysis">If yes, approximately how many data analyses have you completed?</label>
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

