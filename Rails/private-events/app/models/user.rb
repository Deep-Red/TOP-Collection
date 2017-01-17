class User < ApplicationRecord
  has_many :events, foreign_key: "creator_id"
  before_save :downcase_name

  private

  def downcase_name
    name.downcase!
  end

end
