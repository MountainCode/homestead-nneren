require 'ruby-rets'

module Homestead
  module Nneren
    class RetsImporter
      def initialize(login_config)
        @login_config = login_config
      end
      def with_session(login_config)
        client = ::RETS::Client.login login_config
        yield client
        client.logout
      end
      def for_each_property_type
        [
          :ResidentialProperty
        ].each do |type|
          yield type
        end
      end
      def update(search_type, klass, num_days = 1)
        with_session(@login_config) do |client|
          client.search(
            :search_type => search_type,
            :class => klass,
            :query => "(DateChange=#{num_days}.DAYSBACK.)"
          ) do |resource|
            p resource
          end
        end
      end
      def update_properties
        for_each_property_type {|t| update(:Property, t, 2)}
      end
    end
  end
end
