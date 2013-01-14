module Singly
  class Client
    include Singly::ApiRequest

    attr_reader :access_token

    def initialize(access_token=nil)
      @access_token = access_token
    end

    def profiles(query={})
      get("/profiles", query)
    end

    def profile
      get("/profile")
    end

    # profile_id like <twitter-id>@twitter to delete one profile
    # profile_id like twitter to delete all twitter profiles
    # profile_id like nil to delete all profiles
    def delete_profiles profile_id
      delete("/profiles/#{profile_id}")
    end

    def foursquare
      @foursquare ||= Singly::Service::Foursquare.new(self)
    end

    def instagram
      @instagram ||= Singly::Service::Instagram.new(self)
    end
  end
end
