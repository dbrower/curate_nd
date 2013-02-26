CurateNd::Application.routes.draw do
  Blacklight.add_routes(self)
  HydraHead.add_routes(self)
  Hydra::BatchEdit.add_routes(self)

  devise_for :users

  resources 'dashboard', :only=>:index do
    collection do
      get 'page/:page', :action => :index
      get 'facet/:id',  :action => :facet, :as => :dashboard_facet
      get 'related/:id',:action => :get_related_file, :as => :related_file
    end
  end

  namespace :curation_concern, path: :concern do
    resources :senior_theses, except: :index
    resources :generic_files, only: [:show, :edit]
  end

#  resource 'classify', :only => :index
  match "classify" => "classify#index"
  root to: 'welcome#index'
end
