module Rack
  class HeadersFilter
    SENSITIVE_HEADERS = %w[
      HTTP_X_FORWARDED_FOR
      HTTP_X_FORWARDED_HOST
      HTTP_X_FORWARDED_PORT
      HTTP_X_FORWARDED_PROTO
      HTTP_X_FORWARDED_SCHEME
      HTTP_X_FORWARDED_SSL
    ]

    # Headers sent by the Heroku router
    HEROKU_HEADERS = %w[
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

    attr_reader :remove_headers

    def initialize(app, trusted_headers: HEROKU_HEADERS)
      @remove_headers = SENSITIVE_HEADERS - trusted_headers
      @app = app
    end

    def call(env)
      @remove_headers.each(&env.method(:delete))
      @app.call(env)
    end
  end
end
