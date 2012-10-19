Given /^the category "(.*)" exists/ do |name|
  Category.create!(:name => name, :permalink => name)
end

Given /^I create category "(.*)" with permalink "(.*)"/ do |name, permalink|
  fill_in('category_name', :with => name)
  fill_in('category_permalink', :with => permalink)
  click_button('Save')
end

Given /^I change its name to "(.*)" and its permalink to "(.*)"/ do |name, permalink|
  fill_in('category_name', :with => name)
  fill_in('category_permalink', :with => permalink)
  click_button('Save')
end

Then /^its name should be "([^"]*)"$/ do |name|
  if page.respond_to? :should
    page.should have_content(name)
  else
    assert page.has_content?(name)
  end
end

Then /^its permalink should be "([^"]*)"$/ do |permalink|
  if page.respond_to? :should
    page.should have_content(permalink)
  else
    assert page.has_content?(permalink)
  end
end
