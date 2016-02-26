class Promise < ActiveRecord::Base

  belongs_to :user
  has_many :bets

  validates :content, presence: true
  validates :expires_at, presence:true

  validate :expiration_date_cannot_be_in_the_past, if: :expires_at

  def hours_until_expired
    hours = ((expires_at.to_time - (DateTime.now - 8.hours)) / 1.hours).ceil
    if hours > 0
      "Expires in #{hours} hours!"
    else
      "Expired!"
    end
  end

  private
    def expiration_date_cannot_be_in_the_past
      if expires_at < (DateTime.now - 8.hours)
        errors.add(:expires_at, "can't be in the past")
      end
    end
end