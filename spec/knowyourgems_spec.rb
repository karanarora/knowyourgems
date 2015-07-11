require 'spec_helper'
require 'webmock/rspec'
require 'timecop'

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
        expect(Knowyourgems.name_of_your_gems 'userthatdoesnotexist').to eq({"error"=>"Not Found: Invalid user handle"})
      end
    end
  end
  #
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
        expect(Knowyourgems.your_total_gems 'userthatdoesnotexist').to eq({"error"=>"Not Found: Invalid user handle"})
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

  describe ".versions_api" do
    it "should return a url string as per user_handle" do
      expect(Knowyourgems.versions_api 'hash_multi_tool').to eq("https://rubygems.org/api/v1/versions/hash_multi_tool.json")
    end
  end

  describe ".versions" do
    it "should return a url string as per user_handle" do
      stub_request(:get, "https://rubygems.org/api/v1/versions/hash_multi_tool.json").to_return(body: "[{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"downloads_count\":195,\"metadata\":{},\"number\":\"0.1.5\",\"summary\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"55e595b4c9534168421952e3a804e6cbda6d1818ee8f799040e049c91102fec4\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":168,\"metadata\":{},\"number\":\"0.1.4\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"dc06d869ff9aef132debf549c96c6e64aaccfcf82f34ec6680f6b06bd4b0c33f\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":99,\"metadata\":{\"allowed_push_host\":\"http://mygemserver.com\"},\"number\":\"0.1.3\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"800407abc72597fba4f475b61c6e84c9dff24e518fe5391daaf4155df36fe633\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-06-03T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":146,\"metadata\":{},\"number\":\"0.1.2\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"6ae54ab73a38374eaa99b017556f5fab12e438c07440c8e11a470c22b2ae9fa8\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-04-23T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":254,\"metadata\":{},\"number\":\"0.1.1\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"02b3b47c6f5b0a9cc230920745aab3ae17912467c5e6518a56558ba74fac9b24\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-04-22T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":226,\"metadata\":{},\"number\":\"0.1.0\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"3a73d8fdb6a7762d5da36d20e6b113ab313f1e973e20101380a519e9f89e481b\"}]")
      expect(Knowyourgems.top_version 'hash_multi_tool').to eq({:version=>"0.1.5", :authors=>"Prabhat Thapa", :created_at=>"2015-07-08T00:00:00.000Z", :downloads_count=>195})
    end
  end

  describe ".last_updated" do
    context "when gem by the provided name does not exists" do
      it "should return when gem was last updated" do
        stub_request(:get, "https://rubygems.org/api/v1/versions/gemthatdoesnotexist.json").to_return(body:  "Not found!", status: ["404", "Not Found"])
        Timecop.freeze(Time.local(2015, 07, 11))
        expect(Knowyourgems.last_updated 'gemthatdoesnotexist').to eq({"error"=>"Not Found: Invalid user handle"})
      end
    end

    context "when gem by the provided name exists" do
      it "should appreciate author for active participation" do
        stub_request(:get, "https://rubygems.org/api/v1/versions/hash_multi_tool.json").to_return(body: "[{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"downloads_count\":168,\"metadata\":{},\"number\":\"0.1.5\",\"summary\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"55e595b4c9534168421952e3a804e6cbda6d1818ee8f799040e049c91102fec4\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":168,\"metadata\":{},\"number\":\"0.1.4\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"dc06d869ff9aef132debf549c96c6e64aaccfcf82f34ec6680f6b06bd4b0c33f\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":99,\"metadata\":{\"allowed_push_host\":\"http://mygemserver.com\"},\"number\":\"0.1.3\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"800407abc72597fba4f475b61c6e84c9dff24e518fe5391daaf4155df36fe633\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-06-03T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":146,\"metadata\":{},\"number\":\"0.1.2\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"6ae54ab73a38374eaa99b017556f5fab12e438c07440c8e11a470c22b2ae9fa8\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-04-23T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":254,\"metadata\":{},\"number\":\"0.1.1\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"02b3b47c6f5b0a9cc230920745aab3ae17912467c5e6518a56558ba74fac9b24\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-04-22T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":226,\"metadata\":{},\"number\":\"0.1.0\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"3a73d8fdb6a7762d5da36d20e6b113ab313f1e973e20101380a519e9f89e481b\"}]")
        Timecop.freeze(Time.local(2015, 07, 11))
        expect(Knowyourgems.last_updated 'hash_multi_tool').to eq("Awesome work you updated your gem 2 days before.")
      end

      it "should alert author if he/she is not activly updating the gem from last 40 days" do
        stub_request(:get, "https://rubygems.org/api/v1/versions/hash_multi_tool.json").to_return(body: "[{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-05-11T00:00:00.000Z\",\"description\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"downloads_count\":168,\"metadata\":{},\"number\":\"0.1.5\",\"summary\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"55e595b4c9534168421952e3a804e6cbda6d1818ee8f799040e049c91102fec4\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":168,\"metadata\":{},\"number\":\"0.1.4\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"dc06d869ff9aef132debf549c96c6e64aaccfcf82f34ec6680f6b06bd4b0c33f\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":99,\"metadata\":{\"allowed_push_host\":\"http://mygemserver.com\"},\"number\":\"0.1.3\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"800407abc72597fba4f475b61c6e84c9dff24e518fe5391daaf4155df36fe633\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-06-03T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":146,\"metadata\":{},\"number\":\"0.1.2\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"6ae54ab73a38374eaa99b017556f5fab12e438c07440c8e11a470c22b2ae9fa8\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-04-23T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":254,\"metadata\":{},\"number\":\"0.1.1\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"02b3b47c6f5b0a9cc230920745aab3ae17912467c5e6518a56558ba74fac9b24\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-04-22T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":226,\"metadata\":{},\"number\":\"0.1.0\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"3a73d8fdb6a7762d5da36d20e6b113ab313f1e973e20101380a519e9f89e481b\"}]")
        Timecop.freeze(Time.local(2015, 07, 11))
        expect(Knowyourgems.last_updated 'hash_multi_tool').to eq("Your gem would like an update, it was updated 60 days ago.")
      end

      it "should alert author if he/she is not activly updating the gem from last 100 days" do
        stub_request(:get, "https://rubygems.org/api/v1/versions/hash_multi_tool.json").to_return(body: "[{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-01-11T00:00:00.000Z\",\"description\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"downloads_count\":168,\"metadata\":{},\"number\":\"0.1.5\",\"summary\":\"A swiss army knife for collection of hashes. Play with it to know its strength.\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"55e595b4c9534168421952e3a804e6cbda6d1818ee8f799040e049c91102fec4\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":168,\"metadata\":{},\"number\":\"0.1.4\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"dc06d869ff9aef132debf549c96c6e64aaccfcf82f34ec6680f6b06bd4b0c33f\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-07-08T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":99,\"metadata\":{\"allowed_push_host\":\"http://mygemserver.com\"},\"number\":\"0.1.3\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"800407abc72597fba4f475b61c6e84c9dff24e518fe5391daaf4155df36fe633\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-06-03T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":146,\"metadata\":{},\"number\":\"0.1.2\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"6ae54ab73a38374eaa99b017556f5fab12e438c07440c8e11a470c22b2ae9fa8\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-04-23T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":254,\"metadata\":{},\"number\":\"0.1.1\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"02b3b47c6f5b0a9cc230920745aab3ae17912467c5e6518a56558ba74fac9b24\"},{\"authors\":\"Prabhat Thapa\",\"built_at\":\"2015-04-22T00:00:00.000Z\",\"description\":\"Sort a array of hashes with one or multiple values\",\"downloads_count\":226,\"metadata\":{},\"number\":\"0.1.0\",\"summary\":\"Sort a array of hashes with one or multiple values\",\"platform\":\"ruby\",\"ruby_version\":\"\\u003e= 0\",\"prerelease\":false,\"licenses\":[\"MIT\"],\"requirements\":[],\"sha\":\"3a73d8fdb6a7762d5da36d20e6b113ab313f1e973e20101380a519e9f89e481b\"}]")
        Timecop.freeze(Time.local(2015, 07, 11))
        expect(Knowyourgems.last_updated 'hash_multi_tool').to eq("Ohh man your gem is lagging behind. Was last updated 180 days back.")
      end
    end
  end

end
