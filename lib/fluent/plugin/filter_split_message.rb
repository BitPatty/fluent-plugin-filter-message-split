require "fluent/plugin/filter"
require "fluent/time"

module Fluent
  module Plugin
    class SplitMessage < Filter
      Plugin.register_filter("split_message", self)

      config_param :field_key, :string, default: "message"
      config_param :delimiter, :string, default: ","

      def configure(conf)
        super
      end

      def filter_stream(tag, es)
        new_es = Fluent::MultiEventStream.new

        es.each do |time, record|
          begin
            unless record.key?(@field_key)
              return new_es
            end

            vals = record[@field_key].split(@delimiter)

            if vals.count > 1
              vals.each do |v|
                begin
                  new_record = record.dup
                  new_record[@field_key] = v.strip
                  new_es.add(time, new_record)
                end
              end
            else
              new_es.add(time, record)
            end
          rescue => e
            router.emit_error_event(tag, time, record, e)
          end
        end

        return new_es
      end
    end
  end
end
