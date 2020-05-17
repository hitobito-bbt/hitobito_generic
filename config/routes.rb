# encoding: utf-8

#  Copyright (c) 2012-2013, Puzzle ITC GmbH. This file is part of
#  hitobito_generic and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_generic.

Rails.application.routes.draw do
  extend LanguageRouteScope
  language_scope do
    resources :groups do
      resources :events, only: [] do # do not redefine events actions, only add new ones
        collection do
          get 'campaign' => 'events#index', type: 'Event::Campaign'
        end
      end
    end
  end
end
