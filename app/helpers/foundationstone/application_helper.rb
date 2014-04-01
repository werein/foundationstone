module Foundationstone
  module ApplicationHelper
    def i css_class
      content_tag :i, class: css_class do
        ''
      end
    end

    def glyphicon css_class
      i "glyphicon glyphicon-#{css_class}"
    end

    def span_icon span_class, icon_class
      content_tag :span, class: span_class do
        i(icon_class)
      end
    end
    alias_method :si, :span_icon

    def icon_text icon_class, text
      content_tag :span, class: 'icon-text' do
        i(icon_class) + text
      end
    end
    alias_method :it, :icon_text

    def glyphicon_text icon_class, text
      icon_text "glyphicon glyphicon-#{icon_class}", text
    end
    alias_method :gt, :glyphicon_text

    def font_awesome_text icon_class, text
      content_tag :span, class: 'icon-text' do
        icon icon_class, text
      end
    end
    alias_method :fat, :font_awesome_text

    def extract text, opt = {}
      if text
        result = strip_tags text
        result = result.truncate(opt[:truncate]) if opt[:truncate]
        result.html_safe
      end
    end

    def true_false_icon true_false
      true_false ? i('glyphicon glyphicon-ok') : i('glyphicon glyphicon-minus')
    end

    def current_date
      Time.zone.now.to_datetime
    end

    def bootstrap_flash
      flash_messages = []
      flash.each do |type, message|
        type = 'alert-success' if type == :notice
        type = 'alert-error alert-danger' if type == :alert
        text = content_tag(:div, link_to("x", "#", class: "close", data: {dismiss: 'alert'}) + message, class: "alert fade in #{type}")
        flash_messages << text if message
      end
      if flash_messages
        content_tag :div, id: 'alerts' do 
          flash_messages.join("\n").html_safe
        end
      end
    end

    def flags resolution
      content_tag :div, class: 'flags' do
        I18n.available_locales.each do |flag|
          concat link_to(image_tag("foundationstone/icons/flags/#{resolution}/#{flag}.png"), defined?(root_path) ? root_path(locale: flag.to_s) : main_app.root_path(locale: flag.to_s))
        end
      end
    end

    def translations object, options = {}
      content_tag :div, class: 'translations' do
        object.translations.each do |translation|
          concat link_to(image_tag("foundationstone/icons/flags/#{options[:resolution]}/#{translation.locale}.png"), url_for(locale: translation.locale.to_s)) if translation.id?
        end
      end
    end

    def localization_bar object
      content_tag :ul, class: 'nav nav-tabs translations' do
        result = ''
        object.translations.each_with_index do |translation, i|
          result += content_tag :li, class: ('active' if i == 0) do
            content_tag :a, href: "#tab-#{i}", data: { toggle: 'tab' } do
              (!translation.to_s or translation.to_s.empty?) ? t('foundationstone.new_translation') : translation.to_s
            end
          end
        end
        result.html_safe
      end
    end

    def rails_admin_switch object
      model_name = object.class.model_name
      path = model_name.i18n_key.to_s.gsub('/', '~')

      action = 'new' if controller.action_name == 'new' or controller.action_name == 'create'
      action = 'edit' if controller.action_name == 'edit' or controller.action_name == 'update'
      if action == 'new'
        link_to t("foundationstone.rails_admin.#{action}", model: model_name.human), rails_admin.new_path(path)
      else
        link_to t("foundationstone.rails_admin.#{action}", model: model_name.human), rails_admin.edit_path(path, object.id)
      end
    end

    def rails_admin_alert object
      content_tag :div, class: 'alert alert-info' do
        result = rails_admin_switch object
        result += content_tag :a, class: 'close', href: '#', data: { dismiss: 'alert' } do 
          'x'
        end
      end
    end

    def google_analytics id = nil
      content_tag :script, type: 'text/javascript' do
        "var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '#{id}']);
        _gaq.push(['_trackPageview']);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();".html_safe
      end unless id.blank?
    end

    def tree engine_name, items, options = {}
      content_tag :ul do
        items.map do |item|
          output = '<li>'
          klass = ( item.children.find{|i| current_page?(polymorphic_path([engine_name, i])) } ? 'active' : nil ) if item.has_children?
          klass = current_page?(polymorphic_path([engine_name, item])) ? 'current' : klass
          output << link_to(item.send(options.fetch(:title, 'title')), polymorphic_path([engine_name, item]), class: klass)
          output << tree(engine_name, item.children, options) if item.has_children?
          output << '</li>'
          output
        end.join.html_safe
      end
    end

    def divisible_by number
      divisible = []
      1.upto(number) do |i|
        divisible << "div-by-#{i}" if number.modulo(i).zero?
      end
      divisible
    end

    def divisible_class number
      divisible_by(number+1).join(' ')
    end

    def body_id
      controller_path.split('/').first
    end

    def body_class
      [controller_name,action_name].join(' ')
    end
  end
end
