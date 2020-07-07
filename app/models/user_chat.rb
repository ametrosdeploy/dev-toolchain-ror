# == Schema Information
#
# Table name: user_chats
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :integer
#  assistant_sessionid    :string
#  assistant_session_json :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class UserChat < ApplicationRecord
    belongs_to  :user_learn_obj
end
