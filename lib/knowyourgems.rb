require "knowyourgems/version"
require "net/http"
require 'json'

module Knowyourgems
  class << self
    def name_of_your_gems user_handle
      response, valid = gems_api_common user_handle
      response.collect!{|r| r['name']} if valid
    end

    def your_total_gems user_handle
      response, valid = gems_api_common user_handle
      response.count if valid
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

    def gem_api user_handle
      "https://rubygems.org/api/v1/owners/#{user_handle}/gems.json"
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
