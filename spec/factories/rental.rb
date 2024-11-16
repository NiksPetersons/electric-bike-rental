FactoryBot.define do
  factory :rental do
    start_time { Time.current }
    end_time { Time.current + 1.hour }
    association :bike
    association :employee
    canceled { false }
  end
end
