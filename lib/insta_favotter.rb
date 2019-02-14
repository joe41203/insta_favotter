require 'insta_favotter/version'
require 'selenium-webdriver'

module InstaFavotter
  class Error < StandardError; end

  class Client
    LOGIN_SUBMIT_NUMBER = 1.freeze

    attr_reader :username, :password, :driver

    def initialize(username, password)
      @username = username
      @password = password
      caps = Selenium::WebDriver::Remote::Capabilities.chrome(
        'chromeOptions' => {
            'args' => ['--user-data-dir=./profile']
              })
      @driver = Selenium::WebDriver.for :chrome , desired_capabilities: caps
    end

    def login
      driver.get 'https://www.instagram.com/accounts/login/?source=auth_switcher'

      Selenium::WebDriver::Wait.new(timeout: 100)

      return if logined?

      driver.find_element(:name, 'username').send_keys(username)
      driver.find_element(:name, 'password').send_keys(password)

      Selenium::WebDriver::Wait.new(timeout: 100)

      driver.find_elements(:tag_name, 'button')[LOGIN_SUBMIT_NUMBER].click
      
      self
    end

    def search(tag_name)
      driver.get "https://www.instagram.com/explore/tags/#{tag_name}/"
    end

    def first_el_click
      driver.find_element(:xpath, "//*[@id='react-root']/section/main/article/div[2]/div/div[1]/div[1]/a/div/div[2]").click
    end

    def fav
      driver.find_element(:xpath, "/html/body/div[2]/div[2]/div/article/div[2]/section[1]/span[1]/button/span").click
    end

    def next_pic
      driver.find_element(:xpath, "/html/body/div[2]/div[1]/div/div/a[2]").click
    end

    private

    def logined?
      driver.current_url == 'https://www.instagram.com/'
    end
  end
end
