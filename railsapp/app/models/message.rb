class Message < ApplicationRecord

  def self.find_by_users(user1,user2,limit=1000)
    where("(sender_id = ? and receiver_id = ?) or (sender_id = ? and receiver_id =?)",user1.id, user2.id, user2.id, user1.id)
      .order("updated_at desc").limit(limit)
  end
end
