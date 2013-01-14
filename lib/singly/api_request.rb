require "httparty"

module Singly
  API_BASE = "api.singly.com"
  API_PROTOCOL = "https://"

  module ApiRequest
    def api_base
      @api_base || API_BASE
    end

    def api_url(path)
      API_PROTOCOL + api_base + path
    end

    def get(path, query={})
      args = prepare_httparty_call(path, query)
      httparty = HTTParty.get(*args)
      handle_httparty_response(httparty)
    end

    def delete(path, query={})
      args = prepare_httparty_call(path, query)
      httparty = HTTParty.delete(*args)
      handle_httparty_response(httparty)
    end

    private

    def prepare_httparty_call path, query={}, body={}
      query = query.merge(:access_token => @access_token) if @access_token
      options = {}
      options[:query] = query if query.any?
      options[:body] = body if body.any?
      return [api_url(path), options]
    end

    def handle_httparty_response httparty
      return JSON.parse(httparty.body) if httparty.success?
      raise Net::HTTPError.new(httparty.response.message, httparty.response)
    end
  end
end
