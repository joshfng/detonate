# frozen_string_literal: true

# Lockbox.master_key = Rails.application.credentials.lockbox[:master_key]
Lockbox.master_key = ENV['LOCKBOX_MASTER_KEY']
