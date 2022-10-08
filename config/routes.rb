Rails.application.routes.draw do
  resources :rapportdois
  resources :rapports
  resources :reglements


  root 'pages#home'

  devise_for :users

  # route pour link to action user admin
  resources :users do
    member do
      get :toggle_status
    end
  end


  resources :friends
  resources :saisons

  resources :divisions do
    get 'documentedition', :on => :collection
  end
  
  resources :circuits
  resources :events
  resources :equipes
  resources :pilotes

  resources :resultats do
    get 'documentedition', :on => :collection
    member do
      get :toggle_creerresultats
      get :toggle_supprimerresultats
    end
  end
  
  resources :classecuries  do
    get 'documentedition', :on => :collection
  end
  
  resources :parieurs do
    get 'documentedition', :on => :collection
    member do
      get :toggle_creerparieurs
      get :toggle_supprimerparieurs
      get :toggle_updateparieurs
    end
  end

  resources :classements do
    get 'documentedition', :on => :collection
    
    member do
      get :toggle_creerclassements
      get :toggle_updateclassements
      get :toggle_supprimerclassements
      get :toggle_triclassements
      get :toggle_updateclassementsbis
      get :toggle_trierclassementsbis
    end
  end

  resources :cotes do
    get 'documentedition', :on => :collection
      member do
        get :toggle_creercotes
        get :toggle_updatecotes
        get :toggle_supprimercotes
      end
  end

  resources :paris do
    member do
      get :toggle_calculresultats
      get :toggle_recupEvent
    end
  end


  get 'home/index'
  get 'home/users'
  get 'home/role'


  # test call action
  resources :licences do
    member do
      get :toggle_creerlicences
      get :toggle_supprimerlicences
      get :toggle_calculrecuplicences
      get :toggle_calculrecuplicencesIndiv
  
    end
  end

  resources :synthlicences do
    get 'documentedition', :on => :collection
  end
    

 mount ActiveAnalytics::Engine, at: "analytics"


end
