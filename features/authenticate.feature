@wip
Feature: user authenticates himself

  As a user
  I want to authenticate myself
  So that I can use the application

  Scenario: initial authentication
    Given I'm not already authenticated
    When I go to the canvas page
    Then I should be an app user
    # Then I should be authenticated

  Scenario: subsequent authentication
    Given I'm already authenticated
    When I click on the Lovers tab
    Then I should see my lovers

  Scenario: deauthorize app
    Given I'm an app user
    When I deauthorize the app
    And I should not be an app user