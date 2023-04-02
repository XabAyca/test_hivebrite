class InitNewRegistrationService < Service::Base
  def call
    registration = @event.registrations.build
    registration.user = @user
    init_registration_custom_attributes(registration)

    registration
  end

  private

  def init_registration_custom_attributes(registration)
    @event.custom_attributes.each do |ca|
      registration.custom_attributes.build(
        name: ca.name,
        required_create: ca.required_create,
        required_update: ca.required_update
      )
    end
  end
end
