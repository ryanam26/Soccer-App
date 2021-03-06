class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

validates_presence_of :first_name, :last_name, :email, :type_user

  has_and_belongs_to_many :accounts
  # has_and_belongs_to_many :teams
  # has_many :scores
  # has_many :tests, :through => :scores
  has_many :players

  extend EnumerateIt
  has_enumeration_for :type_user, :with => Role, :create_helpers => true

  scope :coach, lambda{where(:type_user => Role::COACH)}
  scope :standard, lambda{where(:type_user => Role::STANDARD)}
  scope :admin, lambda{where(:type_user => Role::ADMIN)}
#  scope :scores_time, lambda{where("users.id not in (select user_id from accounts_users)")}
  scope :can_see_session_plans, lambda{where(:session_plans_visible => true)}
 
  def full_name
    "#{first_name} #{last_name}".titleize
  end
  
  def has_players?
    players.count > 0
  end
  
  def is_player?
    type_user == 2
  end

  # def age
    # ((DateTime.now - birthday) / 365.25).to_i
  # end
# 
  # def high_time_score(test_id)
    # sql = "select min(to_char(to_timestamp(value) AT TIME ZONE 'UTC','HH24:MI:SS')) as time from scores where user_id = #{id} and test_id = #{test_id}"
    # self.connection.execute(sql).to_a[0]["time"]
  # end
# 
  # def high_numeric_score(test_id)
    # get_score_test(test_id).maximum("value").to_f
  # end
# 
  # def pos_age_rank_numeric(test_id, age)
    # sql = "select * from (SELECT row_number() OVER (order by avg(s.value) DESC) as pos, EXTRACT(year from AGE(NOW(), u.birthday)) as age, u.first_name as name, avg(s.value) as average, t.id as test_id, u.id as user_id from users u, scores s, tests t where s.user_id = u.id and s.test_id = t.id and t.id = #{test_id} and EXTRACT(year from AGE(NOW(), u.birthday)) = #{age} group by u.birthday, u.first_name, t.id, u.id) as h where user_id = #{id};"
    # connection.execute(sql).to_a[0]["pos"]
  # end
# 
  # def pos_age_rank_time(test_id, age)
    # sql = "select * from (SELECT row_number() OVER (order by to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') ASC) as pos, EXTRACT(year from AGE(NOW(), u.birthday)) as age, u.first_name as name, to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') as average, t.id as test_id, u.id as user_id from users u, scores s, tests t where s.user_id = u.id and s.test_id = t.id and t.id = #{test_id} and EXTRACT(year from AGE(NOW(), u.birthday)) = #{age} group by u.birthday, u.first_name, t.id, u.id) as h where user_id = #{id};"
    # result = connection.execute(sql).to_a[0]["pos"]
  # end
# 
  # def pos_overall_time_rank(test_id)
    # sql = "SELECT * from (SELECT row_number() OVER (order by to_char(to_timestamp(avg(value)) AT TIME ZONE 'UTC','HH24:MI:SS') ASC) as pos, to_char(to_timestamp(avg(value)) AT TIME ZONE 'UTC +4:30','HH24:MI:SS'), user_id from scores where test_id = #{test_id} group by user_id) as h where user_id = #{id};"
    # connection.execute(sql).to_a[0]["pos"]
  # end
# 
  # def pos_overall_numeric_rank(test_id)
    # sql = "SELECT * FROM (SELECT row_number() OVER (order by avg(value) DESC) as pos, avg(value), user_id from scores where test_id = #{test_id} group by user_id) as h where user_id = #{id};"
    # connection.execute(sql).to_a[0]["pos"]
  # end
# 
  # def has_scores?(test_id)
    # get_score_test(test_id).count > 0
  # end
# 
  # def get_score_test(test_id)
    # scores.where("test_id = ?", test_id)
  # end
# 
  # def average_scores(test_id)
    # get_score_test(test_id).average(:value)
  # end
# 
  # def user_for_age
    # sql = "SELECT * FROM (SELECT EXTRACT(year from AGE(NOW(), birthday)) as age from users) as h where age = #{age}"
    # connection.execute(sql).to_a
  # end

end
