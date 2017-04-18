FactoryGirl.define do
  factory :idea do
    sequence(:title) { |t| "New Idea Title #{t}" }
    description 'Description of the idea here'
  end
end
