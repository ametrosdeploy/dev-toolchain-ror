<<<<<<< HEAD
# == Schema Information
#
# Table name: learning_objects
#
#  id                   :bigint           not null, primary key
#  learning_module_id   :bigint           not null
#  objectable_type      :string
#  objectable_id        :bigint
#  learning_object_type :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
=======
>>>>>>> d317ec6a9e82443a98e3e1b3c09e03e8477e483f
require 'rails_helper'

RSpec.describe LearningObject, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
