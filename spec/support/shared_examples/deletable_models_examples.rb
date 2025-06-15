RSpec.shared_examples 'deletable model' do |model_class|
  let(:model_class_symbolized) { model_class.name.underscore }

  describe '[scopes]' do
    subject { scope.count }

    before do
      create_list model_class_symbolized, 2
      create model_class_symbolized, :deleted
    end

    describe '.deleted' do
      let(:scope) { model_class.deleted }

      it { is_expected.to eq 1 }
    end

    describe '.available' do
      let(:scope) { model_class.available }

      it { is_expected.to eq 2 }
    end
  end

  describe '#deleted?' do
    subject { object.deleted? }

    context 'when not deleted' do
      let(:object) { create model_class_symbolized }

      it { is_expected.to be false }
    end

    context 'when deleted' do
      let(:object) { create model_class_symbolized, :deleted }

      it { is_expected.to be true }
    end
  end

  describe '#available?' do
    subject { object.available? }

    context 'when not deleted' do
      let(:object) { create model_class_symbolized }

      it { is_expected.to be true }
    end

    context 'when deleted' do
      let(:object) { create model_class_symbolized, :deleted }

      it { is_expected.to be false }
    end
  end

  describe '#soft_delete!' do
    subject { object.deleted_at }

    let(:object) { create model_class_symbolized }

    it { expect { object.soft_delete! }.to change { object.deleted_at } }

    context 'without at defines' do
      before { object.soft_delete! }

      it { is_expected.to_not be_nil }
    end

    context 'with at defines' do
      let(:at) { 2.days.ago }

      before do
        freeze_time
        object.soft_delete!(at: at)
      end

      it { is_expected.to eq at }
    end
  end

  describe '#undelete!' do
    subject { object.deleted_at }

    before { object.undelete! }

    let(:object) { create model_class_symbolized, :deleted }

    it { is_expected.to be_nil }
  end
end
