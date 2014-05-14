class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :accounts

  scope :coach, lambda{where(:type_user => Role::COACH)}
  scope :free, lambda{where("users.id not in (select user_id from accounts_users)")}

  def full_name
    "#{first_name} #{last_name}"
  end
end
