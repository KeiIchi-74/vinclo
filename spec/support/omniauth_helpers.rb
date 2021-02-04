module OmniAuthHelpers
  def set_omniauth(service = :google_oauth2)
    OmniAuth.config.mock_auth[service] = OmniAuth::AuthHash.new({
      provider: service.to_s,
      uid: '12345678910',
      info: {
        email: 'sample@sample.com'
      }
    })
  end
end