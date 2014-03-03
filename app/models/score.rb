require 'sanitize'

class Score < ActiveRecord::Base
  belongs_to :game
  before_save :strip_html_from_name

  def as_json(options={})
    result = super.merge(options)
    result['_id'] = self.id.to_s

    result
  end

  private

  def strip_html_from_name
    self.name = Sanitize.clean(self.name)
  end

end
