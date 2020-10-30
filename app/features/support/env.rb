# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'


# Capybara.register_driver :selenium do |app|
#   browser_options = ::Selenium::WebDriver::Firefox::Options.new()
#   browser_options.args << '--headless'
# 
#   capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(accept_insecure_certs: true)
# 
#   Capybara::Selenium::Driver.new(
#     app,
#     browser: :firefox,
#     options: browser_options,
#     desired_capabilities: capabilities
#   )
# end
# 
# Capybara.register_driver :headless_chrome do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: { args: %w(headless disable-gpu no-sandbox window-size=1420,1080) }
#   )
# 
#   Capybara::Selenium::Driver.new app,
#     browser: :chrome,
#     desired_capabilities: capabilities
# end
# 
# Capybara.javascript_driver = :headless_chrome
# 
# 
# 

# 
# Capybara.register_driver :selenium do |app|
#   browser_options = ::Selenium::WebDriver::Firefox::Options.new()
#   browser_options.args << '--headless'
# 
#   Capybara::Selenium::Driver.new(
#     app,
#     browser: :firefox,
#     options: browser_options
#   )
# end

# # From https://github.com/mattheworiordan/capybara-screenshot/issues/84#issuecomment-41219326
# Capybara::Screenshot.register_driver(:firefox_headless) do |driver, path|
#   driver.browser.save_screenshot(path)
# end

# NOT WORKING - NEED A HEADLESS CHROME OR DOCKER SELENIUM SERVICE
Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
	DatabaseCleaner.clean_with(:truncation) # clean once, now
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { :except => [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation


#TODO refactor owner_union and admin to remove duplication in spec_helper
def owner_union
   Union.find_by_short_name("IUF") || FactoryGirl.create(:owner)
end

def admin(params = {})
  result = owner_union.people.first
  
  if result.blank?
    result = FactoryGirl.build(:admin, {union: owner_union}.merge(params))
    result.authorizer = result # self authorizing?
    result.save
  end

  result
end
  