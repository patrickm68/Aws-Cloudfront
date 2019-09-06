require "spec_helper"

describe Lita::Handlers::AwsCloudfront, lita_handler: true do
  describe 'Routing' do
    it { is_expected.to route('cloudfront distributions') }
    it { is_expected.to route('cloudfront invalidations dist') }
    it { is_expected.to route('cloudfront invalidate dist') }
    it { is_expected.to route('cloudfront invalidate dist /*') }
    it { is_expected.to route('cloudfront invalidate dist /images/*') }
  end
end
