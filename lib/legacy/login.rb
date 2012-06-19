require 'digest/sha1'

module Legacy
  class Login
    def self.authenticate(email, password)
      user = ::User.find_by_email(email.to_s)
      self.matches?(user, password) if user.present? and user.legacy_password?
    end

    private

      def self.encrypt(password)
        salt = Rails.configuration.legacy_login_salt
        encrypted = Digest::SHA1.hexdigest "#{salt}#{password.to_s}"
        encrypted
      end

      def self.matches?(user, password)
        user if user.legacy_password.eql? self.encrypt(password)
      end
  end
end
