
module Generic::GroupAbility
  extend ActiveSupport::Concern
  included do
    on(Group) do
      permission(:any).may(:'index_event/campaigns').all
    end
  end
end

