module Rack
  class HeadersFilter
    @sensitive_headers = []
    class << self
      attr_reader :sensitive_headers

      def header(name)
        const = 'HTTP_' + name.gsub('-', '_').upcase
        @sensitive_headers << const_set(const, const)
      end
    end

    # All the headers used in Rack::Request
    header 'X-Forwarded-For'
    header 'X-Forwarded-Host'
    header 'X-Forwarded-Port'
    header 'X-Forwarded-Proto'
    header 'X-Forwarded-Scheme'
    header 'X-Forwarded-SSL'

    # Some extras
    header 'Client-IP'
    header 'X-Real-IP'

    Config = Struct.new(
      :trusted_headers,
    )

    HEROKU = Config.new.tap do |x|
      # Headers sent by the router
      x.trusted_headers = %w[
        HTTP_CONNECTION
        HTTP_CONNECT_TIME
        HTTP_HOST
        HTTP_TOTAL_ROUTE_TIME
        HTTP_UPGRADE_INSECURE_REQUESTS
        HTTP_VIA
        HTTP_X_FORWARDED_FOR
        HTTP_X_FORWARDED_PROTO
        HTTP_X_FORWARDED_PROTO
        HTTP_X_REQUEST_ID
        HTTP_X_REQUEST_START
      ]
    end

    def initialize(app, config = HEROKU)
      @config = config

      @remove_headers = self.class.sensitive_headers - config.trusted_headers

      @app = app
    end

    def call(env)
      @remove_headers.each(&env.method(:delete))
      @app.call(env)
    end
  end
end
