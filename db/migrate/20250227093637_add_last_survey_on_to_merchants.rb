class AddLastSurveyOnToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :last_survey_on, :date
  end
end
