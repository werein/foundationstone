require 'rails_i18n'
require 'meta_tags'
require 'route_translator'

module Foundationstone
  class Engine < ::Rails::Engine
    isolate_namespace Foundationstone

    initializer :append_views do
      ActionView::Base.send :include, ApplicationHelper
    end
  end
end
