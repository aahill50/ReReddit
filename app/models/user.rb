class User < ActiveRecord::Base

  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many(
    :subs,
    foreign_key: :moderator_id,
    dependent: :destroy
  )

  has_many(
    :posts,
    foreign_key: :author_id
  )

  has_many(
    :comments,
    foreign_key: :author_id,
    inverse_of: :author
  )

  after_initialize do
    ensure_session_token
  end

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end


  def generate_session_token
    SecureRandom.base64(16)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end


  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

end
