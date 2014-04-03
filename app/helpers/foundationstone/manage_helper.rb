module Foundationstone
  module ManageHelper
    def manage_create_button klass, options = {}
      link_to gt('pencil', t('foundationstone.helper.manage.create', model: klass.model_name.human.downcase)), new_polymorphic_path(klass), style: ('display:none' unless manage?), class: "manage manage-hor btn btn-info btn-text", 'data-no-turbolink' => true if can? :create, klass
    end

    def manage_icons object, options = {}
      if object.kind_of?(Array)
        klass = object.last.class
        path = object.map(&:class)
      else
        klass, path = object.class, object.class
      end
      if (can? :create, klass) || (can? :edit, klass) || (can? :delete, klass)
        except = options.fetch(:except, [])
        content_tag :div, class: "manage manage-ver btn-group-vertical #{options[:class]}", style: ('display:none' unless manage?) do
          res = ''
          res += link_to glyphicon('pencil'), new_polymorphic_path(path),
              'data-no-turbolink' => true, class: "btn btn-default" unless except.include?(:new)
          res += link_to glyphicon('edit'), edit_polymorphic_path(object), 
              'data-no-turbolink' => true, class: "btn btn-default" if can? :edit, klass and !except.include?(:edit)
          res += link_to glyphicon('remove'), object, data: { confirm: t('foundationstone.helper.manage.confirm') }, method: :delete, remote: (true if options[:remote]),
              class: "btn btn-danger" if can? :delete, klass and !except.include?(:delete)
          res += link_to glyphicon('list'), polymorphic_path(path), 
              class: "btn btn-info " if can? :show, klass and !except.include?(:list)
          res.html_safe
        end
      end
    end

    def manage_buttons object, options = {}
      if object.kind_of?(Array)
        klass = object.last.class
        path = object.map(&:class)
      else
        klass, path = object.class, object.class
      end
      if (can? :create, klass) ||(can? :edit, klass) || (can? :delete, klass)
        content_tag :div, class: "manage manage-hor btn-group #{options[:class]}", style: ('display:none' unless manage?) do
          res = ''
          res += link_to gt('pencil', t('foundationstone.helper.manage.create', model: klass.model_name.human.downcase)), new_polymorphic_path(path),
              'data-no-turbolink' => true, class: "btn btn-default btn-text" unless options[:new]
          res += link_to gt('edit', t('foundationstone.helper.manage.edit', model: klass.model_name.human.downcase)), edit_polymorphic_path(object), 
              'data-no-turbolink' => true, class: "btn btn-default btn-text" if can? :edit, klass and !options[:edit]
          res += link_to gt('remove', t('foundationstone.helper.manage.destroy', model: klass.model_name.human.downcase)), object, data: { confirm: t('foundationstone.helper.manage.confirm') }, method: :delete, remote: (true if options[:remote]),
              class: "btn btn-danger btn-text" if can? :delete, klass and !options[:delete]
          res += link_to gt('list-alt', t('foundationstone.helper.manage.view', model: klass.model_name.human.downcase)), polymorphic_path(path), 
              class: "btn btn-info btn-text" if (can? :edit, klass) and !options[:list]
          res.html_safe
        end
      end
    end
  end
end