Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tsina, '1200875917', '6c39f5d18ae8dd938faba06c11ccae75'
  provider :twitter, 'YBIGwprqot6x6P36zV91A', 'pZPLDZQp8WW4gjNxpkCoH8OOmptImMoaOXp0y4901k'
end