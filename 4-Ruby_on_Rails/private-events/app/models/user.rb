class User < ApplicationRecord
  has_many :events, foreign_key: "creator_id"
  has_many :invitations
  has_many :users, through: :invitations
  before_save :downcase_name

  def upcoming_events(events)
    events.select { |e| e.event.date > Time.now }
  end

  def prev_events(events)
    events.select { |e| e.event.date <= Time.now }
  end


  private

  def downcase_name
    name.downcase!
  end

end
