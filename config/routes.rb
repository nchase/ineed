Ineed::Application.routes.draw do
	match '/' => 'public#index'
	match '/layout' => 'public#layout'
end
