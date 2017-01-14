class User < ApplicationRecord
  before_save :downcase_name

  private

  def downcase_name
    name.downcase!
  end

end
