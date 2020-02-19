require 'yaml'

module ActiveYaml

  class Base < ActiveFile::Base
    extend ActiveFile::HashAndArrayFiles

    class_attribute :erb_disabled

    class << self
      def set_erb_disabled(erb_disabled)
        self.erb_disabled = erb_disabled
      end

      def load_file
        if (data = raw_data).is_a?(Array)
          data
        elsif data.respond_to?(:values)
          data.values
        end
      end

      def extension
        "yml"
      end

      private
      def load_path(path)
        file = File.read(path)
        result = erb_disabled ? file : ERB.new(file).result
        YAML.load(result)
      end
    end
  end
end
