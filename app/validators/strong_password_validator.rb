class StrongPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless Devise.password_length.cover?(value)
      record.errors[attribute] << (
        options[:message] ||
          "Password must be at least #{Devise.password_length.min} characters and no more than #{Devise.password_length.max} characters"
      )
    end
  end
end
