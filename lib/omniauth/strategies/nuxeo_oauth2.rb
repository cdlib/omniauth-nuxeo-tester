# frozen_string_literal: true

require 'omniauth/strategies/oauth2'
require 'uri'

module omniauth

  module strategies


    # Nuxeo Oauth2 for Rails
    #
    # Documentation for Nuxeo's Oauth2 implementation can be found here:
    #    https://doc.nuxeo.com/910/nxdoc/using-oauth2/#oauth-2-flow
    #
    class NuxeoOauth2 < OmniAuth::Strategies::OAuth2

      option :name = "nuxeo"

      CLIENT_OPTIONS = [
        :site
      ]

      AUTHORIZATION_OPTIONS = [
        :response_type,
        :redirect_uri,
        :state,
        :code_challenge,
        :code_challenge_method
      ]

      TOKEN_OPTIONS = [
        :grant_type,
        :code,
        :redirect_uri,
        :code_verifier
      ]

      option :authorization_options = AUTHORIZATION_OPTIONS
      option :token_options = TOKEN_OPTIONS

      args [:client_id, :client_secret]

      def initialize(app, *args, &block)
        super
        @options.client_options.site = site
      end

      uid { raw_info["code"] }

      info do
        {
          name: raw_info["name"],
          email: raw_info["email"]
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/me").parsed
      end

      def authorize_url
        "#{root_url}/nuxeo/oauth2/authorize"
      end

      def token_url
        "#{root_url}/token"
      end

=begin
      def authorize_params
        super.tap do |params|
          params[:response_type] = "code"

          AUTHORIZATION_OPTIONS.each do |opt|
            params[opt] = request.params[opt] if request.params[opt].present?
          end

          session['omniauth.state'] = params[:state] if params['state']
        end
      end
=end

    end

  end

end
