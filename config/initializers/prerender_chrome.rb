# PrerenderChrome.configure do |config|
#   config.timeout = 60
#   config.disabled = false
#   config.debug = true
#   config.logger = Rails.logger
#   config.bots = %w[
#     google
#     bing
#     linkedin
#     yahoo
#     lighthouse
#   ]

#   config.before_render = (Proc.new do |url, env|
#     PrerenderChrome.logger.info("In before render for #{url}")

#     request = ActionDispatch::Request.new(env)
#     if request.params.key?(:force_prerender)
#       Rails.cache.delete(url)
#     else
#       Rails.cache.read(url)
#     end
#   end)

#   config.after_render = (Proc.new do |url, response, env|
#     PrerenderChrome.logger.info("In after render for #{url}, #{response.body.bytesize}")

#     if !response.body.blank? && response.status == 200
#       Rails.cache.write(url, response)
#     end

#     response
#   end)
# end
