Rails.application.routes.draw do
  get 'inquiries/new'
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  
  get "/admin/top" => "users#top"

  devise_scope :admins do
    get '/admins/sign_in', to: 'admins/sessions#new'
    get '/admins/sign_out', to: 'admins/sessions#destroy'
  end
  
  get 'customers/show'
  devise_for :customers
  root to: 'homes#top'
  
  resources :items, only: [:new, :create, :index,:edit,:show,:update,:destroy]do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  
  resources :customers, only: [:show,:edit,:update]
  
  
  get 'inquiries/new', as: 'inquiry'
  post 'inquiries' => 'inquiries#create'
  
  get 'thanks'=> 'inquiries#thanks', as: 'thanks'
  
end
