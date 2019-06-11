if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider              => 'AWS',
      :region                => ENV['S3_REGION'],
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
    config.fog_attributes = {cache_control: 'max-age=31536000', expires: 1.year.from_now.httpdate}
    config.fog_public = true
    config.asset_host = 'https://d2b556l5j4mfna.cloudfront.net'
  end
end
