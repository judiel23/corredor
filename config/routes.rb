Rails.application.routes.draw do
  
  resources :insurance_brokers
  # You can have the root of your site routed with "root"
  root 'welcome#index'
  devise_for :users
  
  resources :makes do
      collection {post :import}
  end
  
  resources :vehicles do
      collection {post :import}
  end
  
  resources :versions do
    collection {post :import}
  end
 
  resources :corredors do
      collection {get ':corredor/:id', to: 'corredors#consulta', as: 'consulta'}
      collection {post  :modelo, :year, :version, :placa, :features, :zona,:poliza,:cedula,:nombre,:sexo,:estado,:fnacimiento,:tfijo,:tcelular, :ibero_sum, :informacion,:email, :add_versionList, :add_actualCoti }
     
  end

  resources :form_uni_seguros do
    get :get_marcas_by_anio,   on: :collection
    get :get_modelo_vehicle,   on: :collection
    get :get_version_automv,   on: :collection
    get :integrador,           on: :collection
  end
  
  resources :integrators do
    post :generic_quotation,   on: :collection
  end
  
  resources :cotiz_apps
end
