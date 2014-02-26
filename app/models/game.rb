class Game < ActiveRecord::Base
  has_many :scores

  def as_json(options={})
    result = super.merge(options)
    result['_id'] = self.id.to_s
    result['scores'] = self.games

    result
  end
end
