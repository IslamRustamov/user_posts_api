class User < ApplicationRecord
  before_create { self.token = generate_token }
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  private

    def generate_token
      loop do
        token = SecureRandom.hex
        return token unless User.exists?({ token: token })
      end
    end
end
