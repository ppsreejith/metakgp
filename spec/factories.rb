FactoryGirl.define do
  factory :user do
    name     "Foo Bar"
    email    "foobar@example.com"
    roll_no  "11FO11111"
    password "foobar"
    password_confirmation "foobar"
  end
end