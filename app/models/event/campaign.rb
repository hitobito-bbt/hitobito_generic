class Event::Campaign < Event

  self.role_types = [Event::Campaign::Role::AssistantLeader,
                     Event::Campaign::Role::Helper,
                     Event::Campaign::Role::Participant]


  module Role
    class Leader  < ::Event::Role
      self.permissions = [:event_full, :participations_full]

      self.kind = nil
    end

    class AssitantLeader  < ::Event::Role
      self.permissions = [:event_full, :participations_full]

      self.kind = nil
    end

     class Helper < ::Event::Role
       self.permissions = [:participations_read]

       self.kind = :helper
     end
  end
end
