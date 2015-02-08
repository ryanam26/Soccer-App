class MoveUserDataToPlayers < ActiveRecord::Migration
  def up
    User.all.each do |u|
      if u.is_player? && u.valid?
        if u.email.last.to_i == 0 #If the email is not a duplicate
          p = u.players.new
          
        else
          first_user = User.find_by_email(u.email[0..u.email.length-2])
          if first_user.nil? #If the email ends in a number but is the only one in the system, then make a player on that user.
            p = u.players.new
          elsif first_user.is_player? && first_user.valid?
            p = first_user.players.new #Case for the other email being an admin or coach user
          else
            p = u.players.new #Else make a player on the original user
          end
        end
        
        p.first_name = u.first_name
        p.last_name = u.last_name
        p.teams = u.teams
        p.birthday = u.birthday
        p.save!
      end
    end
  end
  
  def down
    Player.all.each do |p|
      if p.user.players.count == 1 #If this user has more than one player, we'll have to create a separate user for them
        p.user.first_name = p.first_name
        p.user.last_name = p.last_name
        p.user.teams = p.teams
        p.user.birthday = p.birthday
        p.user.save!
      else
        p.user.players.each_with_index do |q,i|
          if i == 0
            next
          else
            u = User.new
            u.email = q.user.email + i.to_s
            u.password = q.user.password
            q.user = u
          end
          q.user.first_name = q.first_name
          q.user.last_name = q.last_name
          q.user.teams = q.teams
          q.user.birthday = q.birthday
          q.user.save!
        end
      end
    end
  end
end
