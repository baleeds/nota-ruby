# frozen_string_literal: true

FactoryBot.define do
  factory :user_annotation_favorite do
    user
    annotation
  end
end
