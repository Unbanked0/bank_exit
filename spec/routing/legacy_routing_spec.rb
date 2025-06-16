require 'rails_helper'

RSpec.describe 'Legacy', type: :request do
  describe '/map.html' do
    subject! { get('/map.html') }

    it { is_expected.to redirect_to(map_en_path) }
  end

  describe '/cheque' do
    subject! { get('/cheque') }

    it { is_expected.to redirect_to('https://monero-map.org/cheque/') }
  end

  describe '/crypto_box' do
    subject! { get('/crypto_box') }

    it { is_expected.to redirect_to('https://monero-map.org/crypto_box/') }
  end

  describe '/epicerie' do
    subject! { get('/epicerie') }

    it { is_expected.to redirect_to('https://monero-map.org/epicerie/') }
  end

  describe '/les-marchands/:id' do
    subject! { get('/les-marchands/1234-foobar') }

    it { is_expected.to redirect_to('/commercants/1234-foobar') }
  end

  describe '/les-groupes-locaux' do
    subject! { get('/les-groupes-locaux') }

    it { is_expected.to redirect_to('/groupes-locaux') }
  end

  describe '/les-projets' do
    subject! { get('/les-projets') }

    it { is_expected.to redirect_to('/projets') }
  end

  describe '/les-projets/:id' do
    subject! { get('/les-projets/1234-foobar') }

    it { is_expected.to redirect_to('/projets/1234-foobar') }
  end

  describe '/comptabilite' do
    subject! { get('/comptabilite') }

    it { is_expected.to redirect_to('/tutoriels/accounting') }
  end

  describe '/commercants/new' do
    subject! { get('/commercants/new') }

    it { is_expected.to redirect_to('/merchant_proposals/new') }
  end

  describe '/en/accounting' do
    subject! { get('/en/accounting') }

    it { is_expected.to redirect_to('/en/tutorials/accounting') }
  end

  describe '/en/merchants/new' do
    subject! { get('/en/merchants/new') }

    it { is_expected.to redirect_to('/en/merchant_proposals/new') }
  end

  describe '/frequently-asked-questions' do
    subject! { get('/frequently-asked-questions') }

    it { is_expected.to redirect_to('/en/frequently-asked-questions') }
  end

  describe '/glossary' do
    subject! { get('/glossary') }

    it { is_expected.to redirect_to('/en/glossary') }
  end

  describe '/stats' do
    subject! { get('/stats') }

    it { is_expected.to redirect_to('/en/stats') }
  end

  describe '/map/embed' do
    context 'without query parameters' do
      subject! { get('/map/embed') }

      it { is_expected.to redirect_to('/en/map/embed') }
    end

    context 'with query parameters' do
      subject! { get('/map/embed?coins[]=june') }

      it { is_expected.to redirect_to('/en/map/embed?coins[]=june') }
    end
  end

  describe '/es/los-comerciantes/:id' do
    subject! { get('/es/los-comerciantes/1234-foobar') }

    it { is_expected.to redirect_to('/es/comerciantes/1234-foobar') }
  end

  describe '/es/los-grupos-locales' do
    subject! { get('/es/los-grupos-locales') }

    it { is_expected.to redirect_to('/es/grupos-locales') }
  end

  describe '/es/los-proyectos' do
    subject! { get('/es/los-proyectos') }

    it { is_expected.to redirect_to('/es/proyectos') }
  end

  describe '/es/los-proyectos/:id' do
    subject! { get('/es/los-proyectos/1234-foobar') }

    it { is_expected.to redirect_to('/es/proyectos/1234-foobar') }
  end

  describe '/es/contabilidad' do
    subject! { get('/es/contabilidad') }

    it { is_expected.to redirect_to('/es/tutoriales/accounting') }
  end

  describe '/es/comerciantes/new' do
    subject! { get('/es/comerciantes/new') }

    it { is_expected.to redirect_to('/es/merchant_proposals/new') }
  end

  describe '/c' do
    context 'when /c does not have get params' do
      subject! { get('/c') }

      it { is_expected.to redirect_to('https://monero-map.org/c/') }
    end

    context 'when /c have get params' do
      subject! { get('/c/?foo=bar') }

      it { is_expected.to redirect_to('https://monero-map.org/c/?foo=bar') }
    end
  end
end
