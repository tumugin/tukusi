class Util::HashCamelCaseConverter
  # @param hash Hash
  def self.convert(hash)
    hash.deep_stringify_keys
        .deep_transform_keys! { |key| key.camelize(:lower) }
  end
end
