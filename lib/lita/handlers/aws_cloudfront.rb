require 'aws-sdk-cloudfront'

module Lita
  module Handlers
    class AwsCloudfront < Handler
      config :aws_region
      config :aws_access_key_id
      config :aws_secret_access_key

      distributions_help = { 'cloudfront distributions' => 'List cloudfront distributions' }
      route(/cloudfront distributions$/, help: distributions_help) do |response|
        distributions = client.list_distributions.distribution_list.items
        response.reply(render_template('distributions', distributions: distributions))
      rescue StandardError => e
        response.reply ':rage: Error has occurred'
        response.reply e.to_s
      end

      invalidations_help = { 'cloudfront invalidations' => 'List cloudfront invalidations' }
      route(/cloudfront invalidations\s+([a-zA-Z0-9]+)\s*$/, help: invalidations_help) do |response|
        distribution_id = response.matches.first[0]
        invalidations = client.list_invalidations(distribution_id: distribution_id).invalidation_list.items
        response.reply(render_template('invalidations', invalidations: invalidations))
      rescue StandardError => e
        response.reply ':rage: Error has occurred'
        response.reply e.to_s
      end

      invalidate_help = { 'cloudfront invalidate ${distribution_id} ${path}' => 'Invalidate distribution for path' }
      route(/cloudfront invalidate\s+([a-zA-Z0-9]+)\s*(.*)$/, help: invalidate_help) do |response|
        distribution_id = response.matches.first[0]
        path = response.matches.first[1]&.gsub(/\s/, '')
        path =  '/*' if path.nil? || path.empty?
        invalidation = client.create_invalidation(
          distribution_id: distribution_id,
          invalidation_batch: {
            paths: {
              quantity: 1,
              items: [path]
            },
            caller_reference: SecureRandom.uuid
          }
        ).invalidation
        response.reply("Invalidation #{invalidation.id} for #{path} is created.")
      rescue StandardError => e
        response.reply ':rage: Error has occurred'
        response.reply e.to_s
      end

      private def client
        Aws::CloudFront::Client.new(
          region: config.aws_region || ENV['AWS_REGION'],
          access_key_id: config.aws_access_key_id || ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: config.aws_secret_access_key || ENV['AWS_SECRET_ACCESS_KEY']
        )
      end

      Lita.register_handler(self)
    end
  end
end
