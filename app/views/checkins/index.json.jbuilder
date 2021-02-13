# frozen_string_literal: true

json.array! @checkins, partial: 'checkins/checkin', as: :checkin
