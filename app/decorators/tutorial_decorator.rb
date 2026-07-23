class TutorialDecorator < ArticleDecorator
  def author?
    author.present?
  end

  def level?
    model[:level].present?
  end

  def time
    @time ||= model[:time]
  end

  def time?
    time.present?
  end

  def might_be_outdated?
    return false unless created_at

    created_at.before?(2.years.ago)
  end

  def cryptopayment_for_business?
    identifier == 'cryptopayment-for-business'
  end

  def accounting?
    identifier == 'accounting'
  end

  def bitcoin_nokyc?
    identifier == 'bitcoin-nokyc'
  end

  def monero_nokyc?
    identifier == 'monero-nokyc'
  end
end
