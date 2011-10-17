Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tsina, '1164312710', '8651fea6aad1c8e308ad741349f3f4ba'
  provider :twitter, 'YBIGwprqot6x6P36zV91A', 'pZPLDZQp8WW4gjNxpkCoH8OOmptImMoaOXp0y4901k'
end