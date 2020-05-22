# encoding: utf-8

#  Copyright (c) 2012-2013, Puzzle ITC GmbH. This file is part of
#  hitobito_generic and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_generic.

module HitobitoGeneric
  class Wagon < Rails::Engine
    include Wagons::Wagon

    # Set the required application version.
    app_requirement '>= 0'

    # Add a load path for this specific wagon
    # config.autoload_paths += %W( #{config.root}/lib )

    config.to_prepare do
      # extend application classes here
      Group.send  :include, Group::Generic
      Person.send :include, Generic::Person
      GroupAbility.send :include, Generic::GroupAbility

      Ability.store.register DonationAbility


      PeopleController.send :include, Generic::PeopleController

      Sheet::Group.tabs.insert 4,
        Sheet::Tab.new('activerecord.models.event/campaign.other',
                       :campaign_group_events_path,
                       params: { returning: true },
                       if: (lambda do |view, group|
                         group.event_types.include?(::Event) && view.can?(:index_events, group)
                       end))

      Sheet::Person.tabs.insert 5,
        Sheet::Tab.new('activerecord.models.donation.other',
                       :group_person_donations_path,
                       params: { returning: true },
                       if: (lambda do |view, group, person|
                         view.can?(:manage, person.donations.build)
                       end))
    end

    initializer 'hitobito_generic.add_settings' do |_app|
      Settings.add_source!(File.join(paths['config'].existent, 'settings.yml'))
      Settings.reload!
    end

    def seed_fixtures
      fixtures = root.join('db', 'seeds')
      ENV['NO_ENV'] ? [fixtures] : [fixtures, File.join(fixtures, Rails.env)]
    end
  end
end
