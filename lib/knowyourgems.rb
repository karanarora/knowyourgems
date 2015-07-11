require "knowyourgems/version"
require "net/http"
require 'json'
require 'time'
require 'hash_multi_tool'
require 'pry'

module Knowyourgems
  class << self
    def name_of_your_gems user_handle
      response, valid = gems_api_common user_handle
      if valid
        response.collect!{|r| r['name']}
      else
        response
      end
    end

    def your_total_gems user_handle
      response, valid = gems_api_common user_handle
      if valid
        response.count
      else
        response
      end
    end

    def http_response service
      uri = URI(service)
      response = Net::HTTP.get_response(uri)
    end

    def gems_api_common user_handle
      url = gem_api user_handle
      response = http_response url
      response, valid = valid_response? response
      return response,valid
    end

    def last_updated gem
      response, valid = versions_detail gem
      if valid
        date_diff = (DateTime.now - DateTime.parse(response.first['built_at'])).to_i
        if date_diff < 40
          "Awesome work you updated your gem #{date_diff} days before."
        elsif (40 < date_diff && date_diff < 100)
          "Your gem would like an update, it was updated #{date_diff} days ago."
        elsif date_diff > 100
          "Ohh man your gem is lagging behind. Was last updated #{date_diff} days back."
        end
      else
        response
      end
    end

    def gem_api user_handle
      "https://rubygems.org/api/v1/owners/#{user_handle}/gems.json"
    end

    def top_version gem
      response, valid = versions_detail gem
      if valid
        sort_versions = HashMultiTool.sort_by_order response, [:downloads_count]
        decorate_version_detail sort_versions
      else
        response
      end
    end

    def versions_api gem
      "https://rubygems.org/api/v1/versions/#{gem}.json"
    end

    def valid_response? response
      case response
        when Net::HTTPSuccess || Net::HTTPOK
          return (JSON.parse response.body), true
        when Net::HTTPNotFound
          {'error' => "#{response.message}: Invalid user handle"}
        when Net::HTTPUnauthorized
          {'error' => "#{response.message}: username and password set and correct?"}
        when Net::HTTPServerError
          {'error' => "#{response.message}: try again later?"}
        else
          {'error' => response.message}
      end
    end

    private 
    def versions_detail gem
      url = versions_api gem
      response = http_response url
      return valid_response? response
    end

    def decorate_version_detail versions = []
      return [] if versions.count == 0
      
      {
        version: versions[0]['number'],
        authors: versions[0]['authors'],
        created_at: versions[0]['built_at'],
        downloads_count: versions[0]['downloads_count']
      }
    end

  end

end
