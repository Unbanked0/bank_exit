require 'rails_helper'

RSpec.describe Weblink do
  it { is_expected.to validate_presence_of(:url) }

  it { is_expected.to allow_value('https://foobar.com', 'http://foobar.com', 'foobar.com', 'foobar.com/index.html').for(:url) }
  it { is_expected.to_not allow_values(nil, 'foobar', 'foobar@test.com').for(:url) }
end
