require 'rails_helper'

RSpec.describe CoinWallet do
  it { is_expected.to define_enum_for(:coin).with_values(described_class.coins.keys) }

  context 'when coin is :bitcoin' do
    subject { build_stubbed :coin_wallet, :bitcoin }

    it { is_expected.to allow_values('bc1qw508d6qejxtdg4y5r3zarvary0c5xw7kv8fq5l', '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa', '', nil).for(:public_address) }
    it { is_expected.to_not allow_value('foobar').for(:public_address) }
  end

  context 'when coin is :monero' do
    subject { build_stubbed :coin_wallet, :monero }

    it { is_expected.to allow_values('48dHfnvZ1NYJNTFJzUp3JQkFqSoKZVGkWKUHdMvymCK2Dq7tHnHL5MF9ZGBWzHjz9Xk4h5yDCXg8eYfFsn1zzTfA4BbLfrL', '', nil).for(:public_address) }
    it { is_expected.to_not allow_value('foobar').for(:public_address) }
  end

  context 'when coin is :lightning' do
    subject { build_stubbed :coin_wallet, :lightning }

    it { is_expected.to allow_values('lnbc1pvjluezsp5unf89f6zjvqctj7krs9e0gszgr9v', '', nil).for(:public_address) }
    it { is_expected.to_not allow_value('foobar').for(:public_address) }
  end

  context 'when coin is :june' do
    subject { build_stubbed :coin_wallet, :june }

    it { is_expected.to allow_values('6kUoMgMZzptzKq5VTTK1FhzZkqPVDqZyopbK35aHY7ft', 'FTFfEFSH3GkdsfUeVkRtku4ZbDqUyBCfgzCUepRhVaPv', '', nil).for(:public_address) }
    it { is_expected.to_not allow_value('foobar').for(:public_address) }
  end
end
