class Team < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :users
  has_and_belongs_to_many :players

  def team_average_time(test_id)
    sql = "select to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') as average from scores s, players_teams ts where s.test_id = #{test_id} and s.player_id = ts.player_id and ts.team_id = #{id};"
    connection.execute(sql).to_a[0]["average"]
  end

  def team_average_numeric(test_id)
    sql = "select avg(s.value) as average from scores s, players_teams ts where s.test_id = #{test_id} and s.player_id = ts.player_id and ts.team_id = #{id};"
    connection.execute(sql).to_a[0]["average"].to_f.round(2)
  end

  def team_system_rank_time(test_id)
    sql = "select * from (select row_number() OVER (order by to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') ASC) as pos, ts.team_id, to_char(to_timestamp(avg(s.value)) AT TIME ZONE 'UTC','HH24:MI:SS') as average from scores s, players_teams ts where s.test_id = #{test_id} and s.player_id = ts.player_id group by ts.team_id) as h where team_id = #{id}"
    pos = connection.execute(sql)
    if pos.count > 0
      pos.to_a[0]["pos"]
    end
  end

  def team_system_rank_numeric(test_id)
    sql = "select * from (select row_number() OVER (order by avg(value) DESC) as pos, ts.team_id, avg(s.value) from scores s, players_teams ts where s.test_id = #{test_id} and s.player_id = ts.player_id group by ts.team_id) as h where team_id = #{id};"
    pos = connection.execute(sql)
    if pos.count > 0
      pos.to_a[0]["pos"]
    end
  end

end
