# frozen_string_literal: true

class UserResource < Avo::BaseResource
  self.title = :email
  self.includes = [:switches]

  field :email, as: :text
end
