Tykee.routes do

  route 'api/items' do
    status 201
    {
      post_params: post_params,
      get_params: get_params
    }
  end

end
