class StrongPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if Devise.password_length.cover?(value.length)

    record.errors.add(
      attribute,
      options[:message] ||
        "Password must be at least #{Devise.password_length.min} characters and no more than #{Devise.password_length.max} characters." # rubocop:disable Style/LineLength
    )
  end
end
