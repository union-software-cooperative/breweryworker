Feature: Home Page
  Scenario: View application's home page
  Given I am a new, authenticated person
  Given there's a "wombat" division
  Given there's an agreement titled "UFCW LOCAL 700/ConAgra Foods - Indianapolis, Indiana, USA" expiring "4 March 2017"
    When I am on the homepage
      Then I should see the link "divisions"
      Then I should see application branding
      Then I should see the link "people"
      When I click the "people" link 
        Then I see a list of "People"
    When I click the "divisions" link
      Then I see a list of "Divisions"
    When I click the "wombat" link
      #Then I should see the link "chat"
      Then I should see the link "agreements"
      Then I should see the link "unions"
      Then I should see the link "companies"
      Then I should see "wombat" branding
    When I click the "agreements" link 
      Then I see a list of "Agreements"
    When I click the "unions" link
      Then I see a list of "Unions"
    When I click the "companies" link
      Then I see a list of "Companies"
