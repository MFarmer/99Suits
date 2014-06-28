class User < ActiveRecord::Base

  include PgSearch
  multisearchable :against => [:fname, :lname, :username, :email]

  # Attributes
  attr_reader :password

  # Relationships
  has_many :items
  has_many :likes
  has_many :comments
  has_many :orders
  has_many(
      :feedbacks,
      :through => :orders,
      :source => :feedback
  )

  # Validations
  if Rails.env.development?
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  else
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                      :default_url => "/images/:style/missing.png",
                      :path => ":style/:id_:filename"
  end

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  before_validation :ensure_session_token

  validates :fname, :lname, :username, :email, :password_digest, :token, :presence => true
  validates :password, :length => { :minimum => 8, :allow_nil => true }
  validates :token, :username, :uniqueness => true

  def reset_token!
    self.token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.token
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(username: user_name)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def is_password?(unencrypted_password)
    BCrypt::Password
    .new(self.password_digest)
    .is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest =
          BCrypt::Password.create(unencrypted_password)
    end
  end

  private

  def ensure_session_token
    self.token ||= SecureRandom.urlsafe_base64(16)
  end

end