class Tag < ApplicationRecord
    belongs_to :user

    enum title: [
        :member,
        :shige,
        :developer,
        :pog,
        :verified
    ]
end
