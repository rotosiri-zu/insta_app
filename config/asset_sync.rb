AssetSync.configure do |config|
  config.enabled = false if Rails.env.development?
  config.fog_provider = 'AWS'
  config.fog_directory = 'insta-app-s3'
  config.aws_access_key_id = 'AKIAUPFN2NGLEFZ64L6A'
  config.aws_secret_access_key = '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'
  config.manifest = true
  config.aws_iam_roles = true
  config.fog_region = 'ap-northeast-1'
end
