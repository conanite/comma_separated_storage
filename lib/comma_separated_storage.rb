require "comma_separated_storage/version"

module CommaSeparatedStorage
  def comma_separated_storage attribute, options={ }
    name = attribute.to_s
    singular = options[:singular] || (name.respond_to?(:singularize) ? name.singularize : name.sub(/s$/, ''))
    interrogator = options[:interrogate] || :"has_#{singular}?"

    line = __LINE__ + 1
    code = %{
      def #{singular}_list= array
        array = [array] unless array.is_a?(Array)
        self.#{attribute}= array.join(',')
      end

      def #{singular}_list
        (self.#{attribute} || "").split(/,/).map &:strip
      end

      def #{interrogator} item
        #{singular}_list.include?(item.to_s) ? item : false
      end

      def multi_#{singular};   #{singular}_list.length > 1;                 end
      def each_#{singular};    #{singular}_list.each { |item| yield item }; end
      def default_#{singular}; #{singular}_list.first.to_sym;               end

      def single_#{singular}
        list = #{singular}_list
        return list[0] if list.size == 1
      end
    }

    class_eval code, __FILE__, line
  end
end
