Rails.application.routes.draw do
  scope "/:locale" do
    resources :letters, param: :slug do
      member do
        get "thanks"
      end
    end

    get 'about', to: 'statics#about'
    get 'faq', to: 'statics#faq'

  end

  root to: redirect('/en/letters/new')

end

