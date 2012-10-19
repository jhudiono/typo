Feature: Create new categories

  As a blog administrator
  In order to keep my blog organized
  I want to be able to edit and create blogging categories
 
  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Successfully add a new category
    When I follow "Categories"
    And I create category "New Test Category" with permalink "newtestcategory"
    Then its name should be "New Test Category"
    And its permalink should be "newtestcategory"

  Scenario: Successfully edit an existing category
    Given the category "Test" exists 
    And I am on the edit page for the "Test" category
    And I change its name to "Foo" and its permalink to "Bar"
    Then its name should be "Foo"
    And its permalink should be "Bar"
    And I should not see "Test"
    
    
