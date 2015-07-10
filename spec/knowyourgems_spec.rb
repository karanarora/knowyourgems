require 'spec_helper'
require 'webmock/rspec'

describe Knowyourgems do
  it 'has a version number' do
    expect(Knowyourgems::VERSION).not_to be nil
  end

  describe ".name_of_your_gems" do
    context "for correct user" do
      it "should return an array of gem names written by the user" do
        stub_request(:get, "https://rubygems.org/api/v1/owners/karanarora/gems.json").to_return(body: "[{\"name\":\"hash_multi_tool\",\"downloads\":1021,\"version\":\"0.1.5\",\"version_downloads\":149,\"platform\":\"ruby\",\"authors\":\"Prabhat Thapa\",\"info\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"licenses\":[\"MIT\"],\"metadata\":{},\"sha\":\"55e595b4c9534168421952e3a804e6cbda6d1818ee8f799040e049c91102fec4\",\"project_uri\":\"http://rubygems.org/gems/hash_multi_tool\",\"gem_uri\":\"http://rubygems.org/gems/hash_multi_tool-0.1.5.gem\",\"homepage_uri\":\"https://github.com/prabhat4ever/hash_multi_tool/\",\"wiki_uri\":null,\"documentation_uri\":\"http://www.rubydoc.info/gems/hash_multi_tool/0.1.5\",\"mailing_list_uri\":null,\"source_code_uri\":null,\"bug_tracker_uri\":null,\"dependencies\":{\"development\":[{\"name\":\"bundler\",\"requirements\":\"~\\u003e 1.9\"},{\"name\":\"rake\",\"requirements\":\"~\\u003e 10.0\"},{\"name\":\"rspec\",\"requirements\":\"\\u003e= 0\"}],\"runtime\":[]}}]")
        expect(Knowyourgems.name_of_your_gems 'karanarora').to eq(['hash_multi_tool'])
      end
    end

    context "for user that does not exist" do
      it "should do something" do
        stub_request(:get, "https://rubygems.org/api/v1/owners/userthatdoesnotexist/gems.json").to_return(body: "Not found!", status: ["404", "Not Found"])
        expect(Knowyourgems.name_of_your_gems 'userthatdoesnotexist').to eq(nil)
      end
    end
  end

  describe ".your_total_gems" do
    context "for correct user" do
      it "should return an array of gem names written by the user" do
        stub_request(:get, "https://rubygems.org/api/v1/owners/karanarora/gems.json").to_return(body: "[{\"name\":\"hash_multi_tool\",\"downloads\":1021,\"version\":\"0.1.5\",\"version_downloads\":149,\"platform\":\"ruby\",\"authors\":\"Prabhat Thapa\",\"info\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"licenses\":[\"MIT\"],\"metadata\":{},\"sha\":\"55e595b4c9534168421952e3a804e6cbda6d1818ee8f799040e049c91102fec4\",\"project_uri\":\"http://rubygems.org/gems/hash_multi_tool\",\"gem_uri\":\"http://rubygems.org/gems/hash_multi_tool-0.1.5.gem\",\"homepage_uri\":\"https://github.com/prabhat4ever/hash_multi_tool/\",\"wiki_uri\":null,\"documentation_uri\":\"http://www.rubydoc.info/gems/hash_multi_tool/0.1.5\",\"mailing_list_uri\":null,\"source_code_uri\":null,\"bug_tracker_uri\":null,\"dependencies\":{\"development\":[{\"name\":\"bundler\",\"requirements\":\"~\\u003e 1.9\"},{\"name\":\"rake\",\"requirements\":\"~\\u003e 10.0\"},{\"name\":\"rspec\",\"requirements\":\"\\u003e= 0\"}],\"runtime\":[]}}]")
        expect(Knowyourgems.your_total_gems 'karanarora').to eq(1)
      end
    end

    context "for user that does not exist" do
      it "should do something" do
        stub_request(:get, "https://rubygems.org/api/v1/owners/userthatdoesnotexist/gems.json").to_return(body: "Not found!", status: ["404", "Not Found"])
        expect(Knowyourgems.your_total_gems 'userthatdoesnotexist').to eq(nil)
      end
    end
  end

  describe ".http_response" do
    it "should return valid Net::HTTP class " do
      stub_request(:get, "http://google.com/").to_return(body: "Success!")
      expect(Knowyourgems.http_response('http://google.com').class).to eq(Net::HTTPOK)
    end
  end

  describe ".gem_api" do
    it "should return a url string as per user_handle" do
      expect(Knowyourgems.gem_api 'karanarora').to eq("https://rubygems.org/api/v1/owners/karanarora/gems.json")
    end
  end

end
