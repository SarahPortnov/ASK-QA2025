@Show-Stopper @regression
Feature: Textual-Show Stopper
#    This test performs the following:
#    Pre - req: Login as a Teacher
#    1.  Verifies happy path question with 1000 characters and Show-Stopper checked; and then deletes the quiz
#    2.  Verifies happy path question to verify only one Show-Stopper per quiz can be created with show stopper checked; and then deletes it
#    This test does not include Student's login and it's functionality

  Background:
    Given I open url "http://ask-qa.portnov.com/#/login"
    Then I should see page title contains "Assessment Control"
    When I type "ask_instr@aol.com" into element with xpath "//input[@placeholder='Email *']"
    And I type "ABC123" into element with xpath "//input[@placeholder='Password *']"
    Then I click on element using JavaScript with xpath "//*[contains(text(), 'Sign In')]"
    And I wait for element with xpath "//mat-icon[contains(text(),'home')]" to be present
    Then element with xpath "//*[@class='info']" should contain text "TEACHER"
    When I click on element using JavaScript with xpath "//*[contains(text(),'Quizzes')]"
    And I wait for element with xpath "//*[contains(text(),'Create New Quiz')]" to be present
    Then I click on element using JavaScript with xpath "//*[contains(text(),'Create New Quiz')]"
    And I wait for element with xpath "//*[@placeholder = 'Title Of The Quiz *']" to be present
    When I type "Sarah Quiz1" into element with xpath "//*[@placeholder = 'Title Of The Quiz *']"
    Then I click on element using JavaScript with xpath "//*[text() = 'add_circle']"
    When I click on element using JavaScript with xpath "//*[contains(text(),'Q1')]/../../..//*[contains(text(),'Textual')]"
    And I wait for element with xpath "//textarea[@formcontrolname='question']" to be present


  @Textual-ShowStopper @deleteQuiz
  Scenario: Textual - Verify that quiz can be created with Textual question and Show-Stopper checked
    And I wait for 1 sec
    When I type "Question 1" into element with xpath "//textarea[@formcontrolname='question']"
    When I click on element using JavaScript with xpath "//div[@class='mat-checkbox-inner-container']"
    And I wait for 2 sec
    And element with xpath "//*[contains(text(),'Q1')]" should contain text "*"
    When I click on element using JavaScript with xpath "//span[normalize-space()='Save']"
    And I wait for element with xpath "//*[@class='controls']" to be present
    And I wait for 1 sec
    Then element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]" should be displayed
    When I click on element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]"
    And I wait for 1 sec
#      number of questions in a quiz
    Then element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../..//*[@class='mat-expansion-panel-body']" should contain text "1"
      #      number of maximum points possible in a quiz
    Then element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../..//*[@class='mat-expansion-panel-body']" should contain text "5"
      #      passing rate in a quiz
    Then element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../..//*[@class='mat-expansion-panel-body']" should contain text "75"
#    Preview shows 1 question with Show-Stopper
    When I click on element using JavaScript with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../.././/*[contains(@class, 'mat-expansion-panel-content')]//span[contains(text(), 'Preview')]"
    And I wait for 2 sec
    Then element with xpath "//*[contains(text(), 'Question 1')]/..//*[contains(text(), 'Show-Stopper')]" should be displayed
    And I wait for 2 sec
    When I click on element with xpath "//button/span[contains(text(), 'Close')]"


      #Delete the quiz
    When I click on element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../..//*[text()='Delete']"
    And I wait for element with xpath "//ac-modal-confirmation" to be present
    And I click on element with xpath "//ac-modal-confirmation/..//*[text()='Delete']"

  @Textual-ShowStopper-oneOnly @deleteQuiz
  Scenario: Textual - Verify that only one show stopper can be added per quiz
    And I wait for 1 sec
    When I type "Question 1" into element with xpath "//textarea[@formcontrolname='question']"
    And I wait for 2 sec
    Then element with xpath "//*[contains(text(),'Q1')]/../../.././/*[contains(text(), 'Show-Stopper')]" should be displayed
    When I click on element using JavaScript with xpath "//div[@class='mat-checkbox-inner-container']"
    And element with xpath "//*[contains(text(),'Q1')]" should contain text "*"
    And I wait for 2 sec
    When I click on element using JavaScript with xpath "//*[text() = 'add_circle']"
    When I click on element using JavaScript with xpath "//*[contains(text(),'Q2')]/../../..//*[contains(text(), 'Textual')]"
    And I wait for 1 sec
    And I type "Question 2" into element with xpath "//*[contains(text(),'Q2')]/../../.././/*[@placeholder='Question *']"
    And I wait for 2 sec
    Then element with xpath "//*[contains(text(),'Q2')]/../../.././/*[contains(text(), 'Show-Stopper')]" should be displayed
    And I click on element with xpath "//*[contains(text(),'Q2')]/../../.././/*[contains(text(), 'Show-Stopper')]"
    And I wait for 1 sec
#  Verify that Question 1 doesn't display Show-Stopper checked.  Currently this functionality can only be verified with
#  asterisk (*) by the Q; for example Q1 will not show Q1* if Show-Stopper if Q2 is checked
    When I click on element using JavaScript with xpath "//*[contains(text(),'Q1')]"
    And I wait for 1 sec
    And element with xpath "//*[contains(text(),'Q1')]" should not contain text "*"
    And I wait for 2 sec
    When I click on element using JavaScript with xpath "//span[normalize-space()='Save']"
    And I wait for element with xpath "//*[@class='controls']" to be present
    And I wait for 1 sec
    Then element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]" should be displayed
    When I click on element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]"
    And I wait for 1 sec
#      number of questions in a quiz
    Then element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../..//*[@class='mat-expansion-panel-body']" should contain text "1"
      #      number of maximum points possible in a quiz
    Then element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../..//*[@class='mat-expansion-panel-body']" should contain text "5"
      #      passing rate in a quiz
    # Preview shows 2 questions but only one Show-Stopper
    Then element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../..//*[@class='mat-expansion-panel-body']" should contain text "75"
    When I click on element using JavaScript with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../.././/*[contains(@class, 'mat-expansion-panel-content')]//span[contains(text(), 'Preview')]"
    And I wait for 2 sec
    Then element with xpath "//*[contains(text(), 'Question 1')]/..//*[contains(text(), 'Show-Stopper')]" should be displayed
    And I wait for 2 sec
    When I click on element with xpath "//button/span[contains(text(), 'Close')]"

      #Delete the quiz
    When I click on element with xpath "//mat-panel-title[contains(text(),'Sarah Quiz1')]/../../..//*[text()='Delete']"
    And I wait for element with xpath "//ac-modal-confirmation" to be present
    And I click on element with xpath "//ac-modal-confirmation/..//*[text()='Delete']"