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

    def last_updated gem_name
      response, valid = versions_detail gem_name
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

    def popular_versions gem_name, count = 1
      response, valid = versions_detail gem_name
      if valid
        sort_versions = HashMultiTool.sort_by_order response, ['downloads_count'], "DESC"
        decorate_version_detail sort_versions, count
      else
        response
      end
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
    def versions_detail gem_name
      url = versions_api gem_name
      response = http_response url
      return valid_response? response
    end

    def gem_api user_handle
      "https://rubygems.org/api/v1/owners/#{user_handle}/gems.json"
    end

    def versions_api gem_name
      "https://rubygems.org/api/v1/versions/#{gem_name}.json"
    end

    def decorate_version_detail versions = [], count = 1
      count = count.to_i
      if (versions.count != 0 || count > 0)
        popular_versions = []
        0.upto(count -1) do |i|
          popular_versions << {
            version: versions[i]['number'],
            authors: versions[i]['authors'],
            created_at: versions[i]['built_at'],
            downloads_count: versions[i]['downloads_count']
          } unless versions[i].nil?
        end
        popular_versions
      else
        []
      end
    end
  end
end
