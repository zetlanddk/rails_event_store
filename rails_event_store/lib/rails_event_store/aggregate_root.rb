require 'active_support/inflector'

module RailsEventStore
  module AggregateRoot
    def apply(event)
      apply_event(event)
      unpublished_events << event
    end

    def apply_old_event(event)
      apply_event(event)
    end

    def unpublished_events
      @unpublished_events ||= []
    end

    private

    def apply_event(event)
      send("apply_#{event.event_type.underscore.gsub('/', '_')}", event)
    end

    def generate_uuid
      SecureRandom.uuid
    end
  end
end