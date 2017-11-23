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
      get 'getregionparent'
      get 'in'
      get 'getregionall'
    end
    resources :deposits do
      member do
        get 'redto'
      end
    end
    resources :takeouts do
      member do
        get 'redto'
      end
    end
    resources :cards
    resources :srelations
    resources :finterests do
      collection do
        get 'hasinterest'
        get 'nointerest'
      end
    end
  end
  resources :interestversions
  resources :deposittypedefs
  resources :relationdefs
  resources :usercounts
  resources :regioncounts do
    collection do
      get 'getuser'
    end
  end
  resources :flogs
  resources :logins
  resources :settings do
    collection do
      get 'savemonthday'
    end
  end
  resources :modifypwds
  resources :depositdayreports do
    collection do
      get 'getvalue'
    end
  end
  resources :depositmonthreports do
    collection do
      get 'getvalue'
    end
  end
end
