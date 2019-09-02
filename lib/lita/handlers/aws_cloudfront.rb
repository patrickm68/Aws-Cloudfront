module Lita
  module Handlers
    class AwsCloudfront < Handler
      distributions_help = { 'cloudfront distributions' => 'List cloudfront distributions' }
      route(/cloudfront distributions$/, help: distributions_help) do |response|
      end

      invalidations_help = { 'cloudfront invalidations' => 'List cloudfront invalidations' }
      route(/cloudfront invalidations\s+([a-z0-9]+)\s*$/, help: invalidations_help) do |response|
      end

      invalidate_help = { 'cloudfront invalidate ${distribution_id} ${path}' => 'Invalidate distribution for path' }
      route(/cloudfront invalidate\s+([a-z0-9]+)\s+(.+)\s*$/, help: invalidate_help) do |response|
      end

      Lita.register_handler(self)
    end
  end
end
