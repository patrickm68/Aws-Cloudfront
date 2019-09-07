# rubocop:disable Style/FrozenStringLiteralComment
require 'spec_helper'

describe Lita::Handlers::AwsCloudfront, lita_handler: true do # rubocop:disable Metrics/BlockLength
  describe 'Routing' do
    it { is_expected.to route('cloudfront distributions') }
    it { is_expected.to route('cloudfront invalidations dist') }
    it { is_expected.to route('cloudfront invalidate dist') }
    it { is_expected.to route('cloudfront invalidate dist /*') }
    it { is_expected.to route('cloudfront invalidate dist /images/*') }
  end

  describe 'Behavior' do # rubocop:disable Metrics/BlockLength
    let(:reply_message) {}

    subject { replies }

    shared_examples('a command that replies message') { it { is_expected.to include reply_message } }

    describe 'distributions command' do # rubocop:disable Metrics/BlockLength
      let(:cloudfront_response) {}

      before do
        allow_any_instance_of(Aws::CloudFront::Client)
          .to receive_message_chain(:list_distributions, :distribution_list, :items) { cloudfront_response }
        send_message 'cloudfront distributions'
      end

      context 'with empty distributions response' do
        let(:cloudfront_response) { [] }
        let(:reply_message) { "There are no distributions.\n" }

        it_behaves_like 'a command that replies message'
      end

      context 'with distribution response' do
        let(:cloudfront_origins) { OpenStruct.new(items: [OpenStruct.new(domain_name: 'origin_domain')]) }
        let(:cloudfront_response) { [OpenStruct.new(id: 1, domain_name: 'domain_name', origins: cloudfront_origins)] }
        let(:reply_message) do
          <<~MESSAGE
            --------------------------------------------------------
            ID: 1
            DomainName: domain_name
            Origins: origin_domain
            --------------------------------------------------------
          MESSAGE
        end

        it_behaves_like 'a command that replies message'
      end

      context 'with distributions response' do
        let(:cloudfront_origins) { OpenStruct.new(items: [OpenStruct.new(domain_name: 'origin_domain')]) }
        let(:cloudfront_response) do
          [
            OpenStruct.new(id: 1, domain_name: 'domain_name1', origins: cloudfront_origins),
            OpenStruct.new(id: 2, domain_name: 'domain_name2', origins: cloudfront_origins)
          ]
        end
        let(:reply_message) do
          <<~MESSAGE
            --------------------------------------------------------
            ID: 1
            DomainName: domain_name1
            Origins: origin_domain
            --------------------------------------------------------
            ID: 2
            DomainName: domain_name2
            Origins: origin_domain
            --------------------------------------------------------
          MESSAGE
        end

        it_behaves_like 'a command that replies message'
      end

      context 'when something raises error' do
        before do
          allow_any_instance_of(Aws::CloudFront::Client)
            .to receive_message_chain(:list_distributions, :distribution_list, :items).and_raise(StandardError)
        end

        let(:reply_message) { ':rage: Error has occurred' }
        it_behaves_like 'a command that replies message'
      end
    end

    describe 'invalidations command' do # rubocop:disable Metrics/BlockLength
      let(:cloudfront_response) {}

      before do
        allow_any_instance_of(Aws::CloudFront::Client)
          .to receive_message_chain(:list_invalidations, :invalidation_list, :items) { cloudfront_response }
        send_message 'cloudfront invalidations dist'
      end

      context 'with empty invalidations response' do
        let(:cloudfront_response) { [] }
        let(:reply_message) { "There are no invalidations.\n" }

        it_behaves_like 'a command that replies message'
      end

      context 'with invalidation response' do
        let(:cloudfront_response) { [OpenStruct.new(id: 1, create_time: '2019/08/07 20:00', status: 'Completed')] }
        let(:reply_message) do
          <<~MESSAGE
            --------------------------------------------------------
            ID: 1
            CreatedAt: 2019/08/07 20:00
            Status: Completed
            --------------------------------------------------------
          MESSAGE
        end

        it_behaves_like 'a command that replies message'
      end

      context 'with invalidations response' do
        let(:cloudfront_response) do
          [
            OpenStruct.new(id: 1, create_time: '2019/08/07 20:00', status: 'Completed'),
            OpenStruct.new(id: 2, create_time: '2019/08/07 20:00', status: 'Completed')
          ]
        end
        let(:reply_message) do
          <<~MESSAGE
            --------------------------------------------------------
            ID: 1
            CreatedAt: 2019/08/07 20:00
            Status: Completed
            --------------------------------------------------------
            ID: 2
            CreatedAt: 2019/08/07 20:00
            Status: Completed
            --------------------------------------------------------
          MESSAGE
        end

        it_behaves_like 'a command that replies message'
      end

      context 'when something raises error' do
        before do
          allow_any_instance_of(Aws::CloudFront::Client)
            .to receive_message_chain(:list_invalidations, :invalidation_list, :items).and_raise(StandardError)
        end

        let(:reply_message) { ':rage: Error has occurred' }
        it_behaves_like 'a command that replies message'
      end
    end

    describe 'invalidate command' do
      let(:cloudfront_response) { OpenStruct.new(id: 'ID_STRING') }
      let(:reply_message) { 'Invalidation ID_STRING for /* is created.' }

      before do
        allow_any_instance_of(Aws::CloudFront::Client)
          .to receive_message_chain(:create_invalidation, :invalidation) { cloudfront_response }
        send_message 'cloudfront invalidate dist'
      end

      it_behaves_like 'a command that replies message'

      context 'when something raises error' do
        before do
          allow_any_instance_of(Aws::CloudFront::Client)
            .to receive_message_chain(:create_invalidation, :invalidation).and_raise(StandardError)
          send_message 'cloudfront invalidate dist'
        end

        let(:reply_message) { ':rage: Error has occurred' }
        it_behaves_like 'a command that replies message'
      end
    end
  end
end
# rubocop:enable Style/FrozenStringLiteralComment
