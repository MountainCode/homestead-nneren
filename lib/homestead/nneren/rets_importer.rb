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
      def property_classes
        {
          :ResidentialProperty => ::Homestead::ResidentialListing
        }
      end
      def property_type_codes
        {
          ::Homestead::ResidentialListing => 'R'
        }
      end
      def fetch_newly_modified(search_type, klass, num_days = 1, q = [])
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
      def fetch_newly_listed(search_type, klass, num_days = 1, q = [])
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
      def fetch_properties(num_days = 1, q = [])
        for_each_property_type do |type|
          fetch_newly_modified(:Property, type, num_days, q) do |resource|
            yield resource, type
          end
          fetch_newly_listed(:Property, type, num_days, q) do |resource|
            yield resource, type
          end
        end
      end
      def update_properties(num_days = 1, q = [])
        fetch_properties(num_days, q) do |resource, type|
          active = ListingStatus.where(code: 'A').first
          state = State.where(name: resource['StateOrProvince']).first
          klass = property_classes[type]
          code = property_type_codes[klass]
          prop_type = PropertyType.where(code: code).first
          sub_prop = SubPropertyType.where(property_type_id: prop_type.id).first

          address = Address.where(
            line1: "#{resource['StreetNumberIDX']} #{resource['StreetNameIDX']}",
            city: resource['City'],
            state_id: state.id,
            postal_code: resource['PostalCode']
          ).first_or_create
          listing = klass.where(
            :listing_number => resource['ListingID']
          ).first_or_create
          listing.sub_property_type = sub_prop
          listing.status = active
          listing.list_price = resource['ListPrice']
          listing.list_date = resource['ListDate']
          listing.remarks = resource['PublicRemarks']
          listing.save
          yield listing
        end
      end
    end
  end
end
