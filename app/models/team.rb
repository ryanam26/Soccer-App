class Team < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :users

  def team_average_time(test_id)
    sql = "select to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') as average from scores s, teams_users ts where s.test_id = #{test_id} and s.user_id = ts.user_id and ts.team_id = #{id};"
    self.connection.execute(sql).to_a[0]["average"]
  end

  def team_average_numeric(test_id)
    sql = "select avg(s.value) as average from scores s, teams_users ts where s.test_id = #{test_id} and s.user_id = ts.user_id and ts.team_id = #{id};"
    self.connection.execute(sql).to_a[0]["average"].to_f.round(2)
  end
end
