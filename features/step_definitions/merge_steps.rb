

Given /^(.*) articles exist$/ do |how_many|
  #Stub out how_many articles
end

Given /^the following articles exist/ do |article_table|
  article_table.hashes.each do |article|
    Article.create!(:type => article["type"], :title => article["title"], :author => article["author"], :body => article["body"])
  end
end

Then /^the title should be (.*)$/ do |title|
  #Find the title
end

Then /^I should (not)? see "(.*)" button/ do |not_see, button_name|
  #Find the button
end
