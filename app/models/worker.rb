class Worker < ActiveRecord::Base
  attr_accessor :password
  EMAIL_REGEX = /\A(\S+)@(.+)\.(\S+)\z/
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true, length: {minimum: 5, maximum: 120}, on: :create, presence: true
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true
  validates :admin, :inclusion => {:in => [0,1]}

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_encrypted = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password_encrypted = nil
  end

  def self.authenticate(username_or_email="", login_password="")
    if  EMAIL_REGEX.match(username_or_email)
      worker = Worker.find_by_email(username_or_email)
    else
      worker = Worker.find_by_username(username_or_email)
    end
    if worker && worker.match_password(login_password)
      worker
    else
      false
    end
  end

  def match_password(login_password="")
    password_encrypted == BCrypt::Engine.hash_secret(login_password, salt)
  end

end
