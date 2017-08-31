class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :friends, -> { where(friendships: { status: "accepted"}) }, through: :friendships
  has_many :requested_friends, -> { where(friendships: { status: "requested"}) }, :through => :friendships, :source => :friend
  has_many :pending_friends, -> { where(friendships: { status: "pending"}) }, :through => :friendships, :source => :friend
  has_many :friendships, :dependent => :destroy

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", :allow_blank => true
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment :avatar, content_type: {content_type: ["image/jpeg", "image/gif", "image/png"] }
  validate  :avatar_size


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      name = auth.info.name.split(" ")
      user.first_name = name[0]
      user.last_name = name[-1]
    end
  end

  def feed
    friend_ids = "SELECT friend_id FROM friendships
                     WHERE  user_id = :user_id AND status = 'accepted'"
    Post.where("user_id IN (#{friend_ids})
                      OR user_id = :user_id", user_id: id).order("created_at DESC")
  end

  private
  def avatar_size
    if avatar.exists? && avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end


end
