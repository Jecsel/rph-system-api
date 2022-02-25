Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => 'application#home'

  get "ping", to:"application#ping"
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'

  resources :auth, only: [:index] do
    collection do
      post 'sign_in'
      post 'register'
    end
  end

  resources :user, only: [:index] do
    collection do
      post 'update_user'
      post 'deactivate_user'
    end
  end

  resources :list, only: [:index] do
    get 'get_all_doctor'
  end

  resources :profile, only: [:index, :create, :show] do
    post 'has_profile'
    post 'update_profile'
    post 'get_user_profile'
  end

  resources :clinical_record, only: [:index, :create, :show] do
    post 'patient_clinical_records'
    post 'update_clinical_record'
    post 'filter_clinical'
  end

  resources :patient, only: [:index, :create, :show] do
    post 'filter_patient'
    post 'patient_search'
    get 'show_all_nurses'
    get 'show_all_doctors'
    get 'show_all_admins'
    post 'create_nurse'
    post 'create_doctor'
    post 'update_doctor_is_online'
    post 'update_nurse_is_online'
    post 'update_admin_is_online' 
  end

  resources :outpatient_record, only: [:index, :create, :show] do
    post 'update'
    get 'show_patient_outpatient_records'
  end

  resources :dashboard, only: [:index] do

  end
  
end
