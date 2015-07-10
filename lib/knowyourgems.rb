require "knowyourgems/version"
require "net/http"
require 'json'
require 'time'

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
      url = versions_api gem
      response = http_response url
      response, valid = valid_response? response
      if valid
        ((DateTime.now - DateTime.parse(response.first['built_at'])).to_i).to_s + ' days'
      else
        response
      end
    end

    def gem_api user_handle
      "https://rubygems.org/api/v1/owners/#{user_handle}/gems.json"
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

  end

end
