Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins do
    collection do
      get 'checklogin'
    end
  end
  resources :regions do
    collection do
      get 'getnodes'
      get 'updatenodes'
      get 'shownodes'
      get 'showedit'
    end
  end
  resources :users do
    collection do
      get 'getregion'
    end
  end
  resources :interestversions
end
