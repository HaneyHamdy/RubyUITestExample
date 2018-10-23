require 'selenium-webdriver'
driver = Selenium::WebDriver.for :firefox

Given(/^We navigate to Google$/) do
  driver.navigate.to "http://www.google.com/"
end

When(/^We search for the word cheese$/) do
  driver.find_element(:id, 'tsf').send_keys("cheese")
  driver.find_element(:id, 'gbqfbb').click
end

Then(/^the results for the search will be displayed$/) do
  wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
  begin
    element = wait.until { driver.find_element(:id => "resultStats") }
    expect(element.text).to eq('About 587,000,000 results (0.55 seconds)')
  ensure
    driver.quit
  end
end
