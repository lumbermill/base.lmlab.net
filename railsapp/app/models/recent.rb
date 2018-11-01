class Recent < ApplicationRecord
  belongs_to :product
  belongs_to :user

  # Add recent record avoiding duplicate.
  def self.append(user,product)
    recents = Recent.where(user_id: user.id, product_id: product.id)
    if recents.exists?
      recent = recents.first
      recent.viewed_time= Time.now
      recent.save
    else
      Recent.create(product_id: product.id, viewed_time: Time.now, user_id: user.id)
    end
  end
end
