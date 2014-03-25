Foundationstone::Engine.routes.draw do
  scope '(:locale)', locale: Regexp.new(I18n.available_locales.join('|')) do
    mount Sidekiq::Web => '/sidekiq' if defined? Sidekiq::Web
    mount Ckeditor::Engine => '/ckeditor' if defined? Ckeditor
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin' if defined? RailsAdmin
  end
end
