# frozen_string_literal: true

namespace :local_to_s3 do
  task sync: :environment do
    ActiveStorage::Blob.find_each do |blob|
      file = Rails.application.routes.url_helpers
                  .rails_blob_path(blob, only_path: true)
      blob.service.upload blob.key, File.open(file), checksum: blob.checksum
    end
  end
end
