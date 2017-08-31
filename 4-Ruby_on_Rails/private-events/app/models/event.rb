class Event < ApplicationRecord
  belongs_to :user, :class_name => 'User', :foreign_key => 'creator_id', dependent: :destroy
  has_many :invitations
  has_many :users, through: :invitations

  scope :past, -> { where("date < ?", Time.now) }

end
