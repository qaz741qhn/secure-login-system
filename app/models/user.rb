class User < ApplicationRecord
  has_one :session, dependent: :destroy
  has_many :diaries, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, presence: true
  has_secure_password

  def login_streak_count!
    if self.session.updated_at.between?(1.day.ago.beginning_of_day, 1.day.ago.end_of_day)
      self.session.login_streak += 1
    elsif self.session.updated_at <= 2.days.ago.end_of_day || self.session.updated_at.to_date == self.session.created_at.to_date
      self.session.login_streak = 1
    end
    self.save
  end

end
