require "insta_favotter/version"
require 'selenium-webdriver'

module InstaFavotter
  class Error < StandardError; end

  class Client
    attr_reader :username, :password, :driver

    def initialize(username, password)
      @username = username
      @password = password
      @driver = Selenium::WebDriver.for(:chrome)
    end

    def login
      driver.get "https://www.instagram.com/accounts/login/?source=auth_switcher"

      Selenium::WebDriver::Wait.new(timeout: 10)

      driver.find_element(:name, 'username').send_keys(username)
      driver.find_element(:name, 'password').send_keys(password)

      driver.find_elements(:tag_name, 'button').each{ |el| el.click }
    end
  end
end
