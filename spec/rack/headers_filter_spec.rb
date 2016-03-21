require 'spec_helper'

class EnvRecordingApp
  attr_reader :last_env
  def call(env)
    @last_env = env
    [200, {}, []]
  end
end

describe Rack::HeadersFilter do
  let(:app) { EnvRecordingApp.new }
  subject { Rack::HeadersFilter.new(app) }
  it 'filters out bad headers' do
    subject.call(
      'HTTP_HOST' => 'myhost.com',
      'HTTP_X_FORWARDED_HOST' => 'fake.com',
    )

    expect(app.last_env).to eq(
      'HTTP_HOST' => 'myhost.com',
    )
  end

  it 'lets other headers through' do
    subject.call(
      'HTTP_FUNIONS' => 'yum'
    )

    expect(app.last_env).to eq(
      'HTTP_FUNIONS' => 'yum',
    )
  end
end
