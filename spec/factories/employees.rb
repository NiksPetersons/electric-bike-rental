FactoryBot.define do
  factory :employee do
    first_name { "Jānis" }
    last_name { "Vītiņš" }
    email { "example@email.com" }
    active { true }
  end
end
