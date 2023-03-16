Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :courses
  resources :authors
  resources :course_authors
  resources :learning_paths do
    member do
      post 'add_course/:course_id', to: 'learning_paths#add_course'
    end
  end
  resources :talents do
  	put '/courses/:course_id/mark_completed', to: 'talents#mark_course_completed', on: :member
    post '/assign_learning_path/:learning_path_id', to: 'talents#assign_learning_path', on: :member
  end

  match '*path', to: 'application#not_found', via: :all
end
