FactoryBot.define do
  factory :post_image do
    shop_name { Faker::Lorem.characters(number: 5) }
    caption { Faker::Lorem.characters(number: 20) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'))}
    user
  end
end