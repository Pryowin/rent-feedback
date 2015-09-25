class Building < ActiveRecord::Base
  default_scope -> { order(state: :asc, city: :asc) }
end
