Rails.application.routes.draw do
  resources :review_houses
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", confirmations: "users/confirmations", passwords: "users/passwords", :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    post "users/confirm" => "users/registrations#confirm"
    post "users/confirm_nick" => "users/registrations#confirm_nick"
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root "main#index"
  # root "index#index"
  # root "main#g_timestamper"
  get "review_map" => "main#review_map"
  get "user_info" => "user_info#change_info"
  post "update_user_info" => "user_info#update_info"
  post "update_password" => "user_info#update_password"

  get "index" => "index#index"

  get "link_to/:id" => "main#link_to"

  post "get_reviews_in_bound" => "main#reviews_in_bound"

  post "update_review_houses/:id" => "review_houses#update"

  get "review_lives" => "review_life#index"
  get "review_lives/:id" => "review_life#show"
  post "review_lifes" => "review_life#create"
  post "review_lifes/:id" => "review_life#edit"
  post "upvote_H/:id" => "review_houses#upvote"
  post "scrap_H/:id" => "review_houses#scrap"
  post "upvote_L/:id" => "review_life#upvote"
  post "scrap_L/:id" => "review_life#scrap"
  post "new_comment_H" => "review_houses#submit_comment"
  post "new_subcomment_H" => "review_houses#submit_subcomment"
  post "new_comment_L" => "review_life#submit_comment"
  post "new_subcomment_L" => "review_life#submit_subcomment"
  post "upvote_comment_H/:id" => "review_houses#upvote_comment"
  post "upvote_comment_L/:id" => "review_life#upvote_comment"
  get "get_comments_H/:id" => "review_houses#get_comments"
  get "get_comments_L/:id" => "review_life#get_comments"

  post "delete_H/:id" => "review_houses#destroy"
  post "delete_L/:id" => "review_life#destroy"

  post "delete_subcomment_H" => "review_houses#delete_subcomment"
  post "delete_subcomment_L" => "review_life#delete_subcomment"

  post "delete_comment_H" => "review_houses#delete_comment"
  post "delete_comment_L" => "review_life#delete_comment"

  get "get_reviews" => "main#get_reviews"
  get "get_house_reviews" => "review_houses#get_reviews"
  get "get_life_reviews" => "review_life#get_reviews"

  get "my_reviews" => "my_review#my_reviews"
  get "get_my_reviews" => "my_review#get_my_reviews"
  get "get_my_review_info" => "my_review#get_my_review_info"

  post "change_cover_img" => "my_review#change_cover_img"

  get "user_reviews/:id" => "my_review#user_reviews"
  get "user_reviews_h/:id" => "my_review#user_reviews_h"
  get "get_user_reviews_H/:id" => "my_review#get_user_reviews_H"
  get "get_user_review_info_H/:id" => "my_review#get_user_review_info_H"

  get "get_user_reviews/:id" => "my_review#get_user_reviews"
  get "get_user_review_info/:id" => "my_review#get_user_review_info"

  get "user_reviews_l/:id" => "my_review#user_reviews_l"
  get "get_user_reviews_L/:id" => "my_review#get_user_reviews_L"
  get "get_user_review_info_L/:id" => "my_review#get_user_review_info_L"

  get "users/user_signed_in" => "main#user_signed_in"

  get "my_scraps" => "my_review#my_scraps"
  get "get_my_scraps" => "my_review#get_my_scraps"

  get "search/:param" => "main#index"
  post "get_searched_reviews" => "main#search_item"
  post "valid_pw" => "user_info#check_current_password"

  get "notice" => "main#notice"
  get "qna" => "main#qna"
  post "qna" => "main#create_qna"
  get "terms" => "main#terms"
  get "policy" => "main#policy"


  post "get_more_all_new" => "main#get_more_new"
  post "get_more_all_best" => "main#get_more_best"
  post "get_more_all_hot" => "main#get_more_hot"

  post "get_more_oneroom_new" => "review_houses#get_more_new"
  post "get_more_oneroom_best" => "review_houses#get_more_best"
  post "get_more_oneroom_hot" => "review_houses#get_more_hot"

  post "get_more_life_new" => "review_life#get_more_new"
  post "get_more_life_best" => "review_life#get_more_best"
  post "get_more_life_hot" => "review_life#get_more_hot"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
