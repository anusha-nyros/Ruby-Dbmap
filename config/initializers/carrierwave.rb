#development
if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

# test
if Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = true
  end
end

# production
if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :s3
    config.s3_access_key_id = 'AKIAITNQY6ZXL7UQKJRQ'
    config.s3_secret_access_key = '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'
    config.s3_bucket = 'cta_staging'
  end
end
