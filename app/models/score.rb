class Score < ActiveRecord::Base
  belongs_to :game

  def as_json(options={})
    result = super.merge(options)
    result['_id'] = self.id.to_s

    result
  end

end
