# frozen_string_literal: true

RSpec.describe RuboCop::Cop::FactoryBotExtension::CreateAssociationInHook do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using `#create` in hooks outside trait' do
    expect_offense(<<~RUBY)
      FactoryBot.define do
        factory :user do
          name { 'willnet' }

          after(:build) do |user|
            create(:post, user: user)
            ^^^^^^^^^^^^^^^^^^^^^^^^^ Create association records in hooks inside `trait { ... }`
          end
        end        
      end
    RUBY
  end

  it 'registers an offense when using `FactoryBot.create` in hooks outside trait' do
    expect_offense(<<~RUBY)
      FactoryBot.define do
        factory :user do
          name { 'willnet' }

          after(:build) do |user|
            FactoryBot.create(:post, user: user)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Create association records in hooks inside `trait { ... }`
          end
        end        
      end
    RUBY
  end

  it 'registers an offense when using `#create` in hooks inside trait' do
    expect_no_offenses(<<~RUBY)
      FactoryBot.define do
        factory :user do
          name { 'willnet' }

          trait(:with_posts) do
            after(:build) do |user|
              create(:post, user: user)
            end
          end
        end        
      end
    RUBY
  end
end
