class Player < ActiveRecord::Base
  
  has_and_belongs_to_many :teams
  belongs_to :user
  has_many :scores
  has_many :tests, :through => :scores
  
  validates_presence_of :user, :first_name, :last_name, :birthday, :teams
  
  
  def full_name
    "#{first_name} #{last_name}".titleize
  end

  def age
    ((DateTime.now - birthday) / 365.25).to_i
  end

  def year_of_birth
    birthday.year
  end

  def list_teams
    str = ""
    teams.each do |team|
      str += team.name + ", "
    end
    return str[0..str.length-3]
  end
  
  def high_time_score(test_id, date)
    # sql = "select min(to_char(to_timestamp(value) AT TIME ZONE 'UTC','HH24:MI:SS')) as time from scores where player_id = #{id} and test_id = #{test_id}"
    # self.connection.execute(sql).to_a[0]["time"]
    if date.eql? 'Today'
      date = 24.hours.ago
    elsif date.eql? 'This Month'
      date = (Time.now().day - 1).days.ago
    else
      date = 100.years.ago
    end

    Time.at(get_score_test(test_id).where('updated_at > ? ', date).minimum("value")).strftime("%H:%M:%S")
  end
  
   def low_time_score(test_id, date)
    # sql = "select min(to_char(to_timestamp(value) AT TIME ZONE 'UTC','HH24:MI:SS')) as time from scores where player_id = #{id} and test_id = #{test_id}"
    # self.connection.execute(sql).to_a[0]["time"]
    if date.eql? 'Today'
      date = 24.hours.ago
    elsif date.eql? 'This Month'
      date = (Time.now().day - 1).days.ago
    else
      date = 100.years.ago
    end

    Time.at(get_score_test(test_id).where('updated_at > ? ', date).maximum("value")).strftime("%H:%M:%S")
  end 

  def high_numeric_score(test_id, date)
    if date.eql? 'Today'
      time = 24.hours.ago
    elsif date.eql? 'This Month'
      time = (Time.now().day - 1).days.ago
    else
      time = 100.years.ago
    end

    scores = get_score_test(test_id).where('updated_at > ?', time)
    if scores.empty?
      nil
    else
      scores.maximum("value").to_f
    end
  end
  
    def low_numeric_score(test_id, date)
    if date.eql? 'Today'
      time = 24.hours.ago
    elsif date.eql? 'This Month'
      time = (Time.now().day - 1).days.ago
    else
      time = 100.years.ago
    end

    scores = get_score_test(test_id).where('updated_at > ?', time)
    if scores.empty?
      nil
    else
      scores.minimum("value").to_f
    end
  end
  
#Todo
  def pos_age_rank_numeric(test_id, age)
    sql = "select * from (SELECT row_number() OVER (order by avg(s.value) DESC) as pos, EXTRACT(year from AGE(NOW(), u.birthday)) as age, u.first_name as name, avg(s.value) as average, t.id as test_id, u.id as player_id from players u, scores s, tests t where s.player_id = u.id and s.test_id = t.id and t.id = #{test_id} and EXTRACT(year from AGE(NOW(), u.birthday)) = #{age} group by u.birthday, u.first_name, t.id, u.id) as h where player_id = #{id};"
    connection.execute(sql).to_a[0]["pos"]
  end

#Todo
  def pos_age_rank_time(test_id, age)
    sql = "select * from (SELECT row_number() OVER (order by to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') ASC) as pos, EXTRACT(year from AGE(NOW(), u.birthday)) as age, u.first_name as name, to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') as average, t.id as test_id, u.id as player_id from players u, scores s, tests t where s.player_id = u.id and s.test_id = t.id and t.id = #{test_id} and EXTRACT(year from AGE(NOW(), u.birthday)) = #{age} group by u.birthday, u.first_name, t.id, u.id) as h where player_id = #{id};"
    result = connection.execute(sql).to_a[0]["pos"]
  end

#Todo
  def pos_overall_time_rank(test_id)
    sql = "SELECT * from (SELECT row_number() OVER (order by to_char(to_timestamp(avg(value)) AT TIME ZONE 'UTC','HH24:MI:SS') ASC) as pos, to_char(to_timestamp(avg(value)) AT TIME ZONE 'UTC +4:30','HH24:MI:SS'), player_id from scores where test_id = #{test_id} group by player_id) as h where player_id = #{id};"
    connection.execute(sql).to_a[0]["pos"]
    
  end

#Todo
  def pos_overall_numeric_rank(test_id)
    sql = "SELECT * FROM (SELECT row_number() OVER (order by avg(value) DESC) as pos, avg(value), player_id from scores where test_id = #{test_id} group by player_id) as h where player_id = #{id};"
    connection.execute(sql).to_a[0]["pos"]
  end

  def has_scores?(test_id)
    get_score_test(test_id).count > 0
  end

  def get_score_test(test_id)
    scores.where("test_id = ?", test_id)
  end

  def average_scores(test_id)
    get_score_test(test_id).average(:value)
  end

#Todo
  def user_for_age
    #sql = "SELECT * FROM (SELECT EXTRACT(year from AGE(NOW(), birthday)) as age from players) as h where age = #{age}"
    sql = "SELECT * FROM players p WHERE EXTRACT(YEAR FROM p.birthday) = #{year_of_birth}"
    connection.execute(sql).to_a
  end

  def age_average_numeric(test_id)
    sql = "SELECT avg(s.value) as average from scores s, players p where s.test_id = #{test_id} and s.player_id = p.id and EXTRACT(year from AGE(NOW(), p.birthday)) = #{age}"
    connection.execute(sql).to_a[0]["average"].to_f.round(2)
  end

  def age_average_time(test_id)
    sql = "SELECT to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') as average from scores s, players p where s.test_id = #{test_id} and s.player_id = p.id and EXTRACT(year from AGE(NOW(), p.birthday)) = #{age}"
    connection.execute(sql).to_a[0]["average"]
  end

end
