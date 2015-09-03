class User < ActiveRecord::Base
has_many :badges , :through => :levels 
has_many :levels  

def change_points(options)
  if Gioco::Core::KINDS
    points = options[:points]
    kind   = Kind.find(options[:kind])
  else
    points = options
    kind   = false
  end

  if Gioco::Core::KINDS
    raise "Missing Kind Identifier argument" if !kind
    old_pontuation = self.points.where(:kind_id => kind.id).sum(:value)
  else
    old_pontuation = self.points.to_i
  end
  new_pontuation = old_pontuation + points
  Gioco::Core.sync_resource_by_points(self, new_pontuation, kind)
end

def next_badge?(kind_id = false)
  if Gioco::Core::KINDS
    raise "Missing Kind Identifier argument" if !kind_id
    old_pontuation = self.points.where(:kind_id => kind_id).sum(:value)
  else
    old_pontuation = self.points.to_i
  end
  next_badge       = Badge.where("points > #{old_pontuation}").order("points ASC").first
  last_badge_point = self.badges.last.try('points')
  last_badge_point ||= 0

  if next_badge
    percentage      = (old_pontuation - last_badge_point)*100/(next_badge.points - last_badge_point)
    points          = next_badge.points - old_pontuation
    next_badge_info = {
                        :badge      => next_badge,
                        :points     => points,
                        :percentage => percentage
                      }
  end
end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :authentication_keys => [:login] 
    
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

  # recommends :books

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
