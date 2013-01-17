Ineed::Application.routes.draw do
	match '/' => 'public#index'
	match '/layout' => 'public#layout'

  resources :providers
  resources :requests
  resources :requesters

  match '/call' => 'hooks#call'
  match '/sms' => 'hooks#sms'
  match '/call/transcribed' => 'hooks#transcribed'
  match '/call/after_record' => 'hooks#after_record'
end
