Feature: Merge articles
  As a blog administrator
  In order to keep my blog organized
  I want to be able to merge articles on my blog

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And the following articles exist:
     | type    | title | author | body            |
     | Article | Foo   | Me     | blah blah blah  |
     | Article | Bar   | You    | stuff goes here |
     | Article | Baz   | Me     | more stuff      |

  Scenario: Successfully merge articles
    Given I am on the "Foo" edit page
    And I fill in "merge_with" with the id of "Bar"
    And I press "Merge"
    Then I should be on the admin content page
    When I go to the home page
    Then I should see "Foo"
    And I should see "Baz"
    And I should not see "Bar"
 
  Scenario: Unsuccessfully merge articles (sad path)
    Given I am logged into the non-admin panel
    And I am on the "Foo" edit page
    Then I should not see "Merge" button
  
  Scenario: Merged articles have correct content
    Given "Foo" and "Bar" have been merged
    When I follow "Foo"
    Then the title should be "Foo"
    And the author should be "Me"
    And I should see "blah blah blah"
    And I should see "stuff goes here" 
    And I should not see "Bar"
    
    
