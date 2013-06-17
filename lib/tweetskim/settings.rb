# -*- encoding: utf-8 -*-

module Tweetskim

  class Settings
    SETTINGS_TEMPLATE = {:token => nil,
      :secret => nil,
      :last_read_status_id => "111111"}

    SETTINGS_FILE_PATH = File.expand_path "~/.tweetskim/default-account"

    require "fileutils"

    def initialize
      FileUtils.mkdir_p(File.expand_path("~/.tweetskim"))
      FileUtils.touch SETTINGS_FILE_PATH
    end

    require "yaml"

    def load
      File.open SETTINGS_FILE_PATH, "r" do |filebody|
        YAML::load(filebody) || SETTINGS_TEMPLATE
      end
    end

    def save(settings)
      yml_str = YAML::dump(settings)
      File.open SETTINGS_FILE_PATH, "w" do |filebody|
        filebody.write yml_str
      end
    end

    def user_credentials_stored?
      if File.exists? SETTINGS_FILE_PATH
        settings = load
        return (settings[:token] && !settings[:token].empty? &&
                settings[:secret] && !settings[:secret].empty?)
      else
        false
      end
    end

    def save_credentials(token, secret)
      settings = load
      settings[:token] = token
      settings[:secret] = secret
      save settings
    end

    def load_credentials
      settings = load
      return settings[:token], settings[:secret]
    end

    def load_last_read_status_id
      settings = load
      return settings[:last_read_status_id]
    end

    def save_last_read_status_id(id)
      settings = load
      settings[:last_read_status_id] = id
      save settings
    end

  end

end
