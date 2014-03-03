class Game < ActiveRecord::Base
  belongs_to :user
  has_many :scores

  def as_json(options={})
    result = super.merge(options)
    result['_id'] = self.id.to_s
    result['scores'] = self.scores

    result
  end
end
