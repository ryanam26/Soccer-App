class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :birthday,
                        :teams, if: :is_player?

  has_and_belongs_to_many :accounts
  has_and_belongs_to_many :teams
  has_many :scores
  has_many :tests, :through => :scores

  scope :coach, lambda{where(:type_user => Role::COACH)}
  scope :free, lambda{where("users.id not in (select user_id from accounts_users)")}

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def is_player?
    type_user == Role::PLAYER
  end

  def age
    ((DateTime.now - birthday) / 365.25).to_i
  end
end
