
Given /^I am not logged into the admin panel$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'batman'
  fill_in 'user_password', :with => 'batword'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Given /^the following articles exist/ do |article_table|
  visit '/accounts/login'
  fill_in 'user_login', :with => 'admin'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  article_table.hashes.each do |article|
    visit path_to("the new article page")
    fill_in "article_title", :with => article["title"]
    fill_in "article__body_and_extended_editor", :with => article["body"]
    click_button("Publish")
    Article.find_by_title(article["title"]).update_attributes!(:author => article["author"])
  end
  visit '/accounts/logout'
end

Given /^the following comments exist/ do |comment_table|
  comment_table.hashes.each do |comment|
    @article = Article.find_by_title(comment["article"])
    @comment = Comment.create!(:article_id => @article.id, :author => comment["author"], :body => comment["body"], :published => true)
    @article.published_comments << @comment
  end
end

Then /^the title should be "(.*)"$/ do |title|
  assert find_field('article_title').value.should == title
end

Then /^the author of "(.*)" should be "(.*)"$/ do |title, author|
  assert Article.find_by_title(title).author.should == author
end

Then /^the comments of "(.*)" should contain "(.*)"$/ do |title, comment|
  if Article.find_by_title(title).published_comments.find_by_body(comment) == nil
    assert false
  else 
    assert true
  end
end

Then /^print content/ do 
   puts page.body
end

Given /^I fill in "([^"]*)" with the id of "(.*?)"$/ do |field, article|
  value = Article.find_by_title(article).id
  fill_in(field, :with => value)
end

Given /^"(.*?)" and "(.*?)" have been merged$/ do |article1, article2|
  visit path_to('the edit page for "' + article1 + '"')
  id = Article.find_by_title(article2).id
  fill_in('merge_with', :with => id)
  click_button("Merge")
end

