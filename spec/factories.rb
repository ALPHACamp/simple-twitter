FactoryBot.define do
  factory :tweet do
    description FFaker::Tweet.body
    user
  end

  factory :reply do
    comment FFaker::Tweet.body
    user
    tweet
  end

  factory :user do
    email FFaker::Internet.email
    password '123456'
    name FFaker::Name.html_safe_last_name
    role 'normal'

    factory :user_with_tweets do
      transient do
        tweets_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:tweet, evaluator.tweets_count, user: user)
      end
    end
  end
end
