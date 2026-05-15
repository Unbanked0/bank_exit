module FeatureFlagHelper
  def enable_feature(key)
    allow(FeatureFlag).to receive(:enabled?).with(key.to_sym).and_return(true)
    allow(FeatureFlag).to receive(:disabled?).with(key.to_sym).and_return(false)
  end

  def disable_feature(key)
    allow(FeatureFlag).to receive(:enabled?).with(key.to_sym).and_return(false)
    allow(FeatureFlag).to receive(:disabled?).with(key.to_sym).and_return(true)
  end

  def stub_feature(key, value)
    allow(FeatureFlag).to receive(:enabled?).with(key.to_sym) { value }
    allow(FeatureFlag).to receive(:disabled?).with(key.to_sym) { !value }
  end
end

RSpec.configure do |config|
  config.include FeatureFlagHelper
end
