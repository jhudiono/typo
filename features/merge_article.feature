Feature: Merge articles
  As a blog administrator
  In order to keep my blog organized
  I want to be able to merge articles on my blog

  Background:
    Given the blog is set up
    And the following articles exist:
     | type    | title | author | body            |
     | Article | Foo   | Me     | blah blah blah  |
     | Article | Bar   | You    | stuff goes here |
     | Article | Baz   | Me     | more stuff      |
    And the following comments exist:
     | article | author | body       |
     | Foo     | Bob    | I like pie |
     | Bar     | Harry  | Go Bears   |

  Scenario: Successfully merge articles
    Given I am logged into the admin panel
    And I am on the edit page for "Foo"
    And I fill in "merge_with" with the id of "Bar"
    And I press "Merge"
    Then I should be on the admin content page
    Then I should see "Foo"
    And I should see "Baz"
    And I should not see "Bar"
 
  Scenario: A non-admin cannot merge two articles (sad path)
    Given I am not logged into the admin panel
    And I am on the edit page for "Foo"
    Then I should not see "Merge Articles"
  
  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel
    Given "Foo" and "Bar" have been merged
    And I am on the admin content page
    Then I should see "Foo"
    When I follow "Foo"
    Then the title should be "Foo"
    And the author of "Foo" should be "Me"
    And the comments of "Foo" should contain "I like pie"
    And the comments of "Foo" should contain "Go Bears"
    And I should see "blah blah blah"
    And I should see "stuff goes here" 
    And I should not see "Bar"
    
    
