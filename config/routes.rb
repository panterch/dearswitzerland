Rails.application.routes.draw do

  namespace :admin do
    resources :letters, param: :token
  end

  scope "/:locale" do
    resources :letters, param: :slug do
      collection do
        get "upload"
      end
      member do
        get "thanks"
      end
    end

    get 'about', to: 'statics#about'
    get 'faq', to: 'statics#faq'

  end


  get "/:locale", to: redirect('/%{locale}/letters/new')
  root to: redirect('/en/letters/new')
  
end

