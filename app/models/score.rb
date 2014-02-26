class Score < ActiveRecord::Base
  belongs_to :game

  def as_json
  end
end
