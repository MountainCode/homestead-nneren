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
      def newly_modified(search_type, klass, num_days = 1, q = [])
        with_session(@login_config) do |client|
          client.search(
            :search_type => search_type,
            :class => klass,
            :query => ["(DateChange=#{num_days}.DAYSBACK.)"].concat(q).join(',')
          ) do |resource|
            yield resource
          end
        end
      end
      def newly_listed(search_type, klass, num_days = 1, q = [])
        with_session(@login_config) do |client|
          client.search(
            :search_type => search_type,
            :class => klass,
            :query => ["(ListDate=#{num_days}.DAYSBACK.)"].concat(q).join(',')
          ) do |resource|
            yield resource
          end
        end
      end
      def update_properties(num_days = 1, q = [])
        for_each_property_type do |t|
          newly_modified(:Property, t, num_days, q) do |resource|
            yield resource
          end
          newly_listed(:Property, t, num_days, q) do |resource|
            yield resource
          end
        end
      end
    end
  end
end
