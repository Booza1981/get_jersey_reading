class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :authentication_keys => [:login] 
    
  recommends :books

  has_many :books
  has_one :profile

  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  has_attached_file :logo
  do_not_validate_attachment_file_type :logo

  attr_accessor :login

  # Create an identicon for the user when they sign up
  after_create :add_identicon

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

    # Adds identicons for all users
  #  eg: go to console and run: 
  #  $ User.add_identicons
  def self.add_identicons
    User.all.each do |user|
      user.add_identicon
    end
  end

  # Creates an identicon for a user given their email address and saves it as their logo
  def add_identicon
    base64_identicon = RubyIdenticon.create_base64(email)
    StringIO.open(Base64.decode64(base64_identicon)) do |data|
      data.class.class_eval { attr_accessor :filename, :content_type }
      data.filename = 'logo.jpg'
      data.content_type = 'image/jpeg'
      self.logo = data
    end
    save(validate: false)
  end


  def self.find_for_database_authentication(warden_conditions)
	conditions = warden_conditions.dup
   if login = conditions.delete(:login)
	  where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
   else
	  where(conditions.to_h).first
   end
  end


end
