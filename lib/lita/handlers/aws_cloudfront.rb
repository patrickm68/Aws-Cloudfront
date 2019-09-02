require 'aws-sdk-cloudfront'

module Lita
  module Handlers
    class AwsCloudfront < Handler
      distributions_help = { 'cloudfront distributions' => 'List cloudfront distributions' }
      route(/cloudfront distributions$/, help: distributions_help) do |response|
        distributions = client.list_distributions.distribution_list.items
        response.reply(render_template('distributions', distributions: distributions))
      end

      invalidations_help = { 'cloudfront invalidations' => 'List cloudfront invalidations' }
      route(/cloudfront invalidations\s+([a-z0-9]+)\s*$/, help: invalidations_help) do |response|
      end

      invalidate_help = { 'cloudfront invalidate ${distribution_id} ${path}' => 'Invalidate distribution for path' }
      route(/cloudfront invalidate\s+([a-z0-9]+)\s+(.+)\s*$/, help: invalidate_help) do |response|
      end

      private def client
        Aws::CloudFront::Client.new(
          region: ENV['AWS_REGION'],
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
        )
      end

      Lita.register_handler(self)
    end
  end
end
