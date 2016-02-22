%#
  t.string  :insurance
  t.integer :cotiz_app_id, references :cotiz_app
  t.text    :response
#
class InsuranceResponse < ActiveRecord::Base
  belongs_to :cotiz_app
  belongs_to :corredor
end
