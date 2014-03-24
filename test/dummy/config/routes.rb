Rails.application.routes.draw do

  root 'welcome#index'
  mount Foundationstone::Engine => '/foundationstone'
end
