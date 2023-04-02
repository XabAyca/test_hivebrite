class InitNewUserService < Service::Base
  def call
    user = User.new
    create_user_template_attributes if CustomAttributes::UserTemplate.all.count.zero?
    init_user_custom_attributes(user)

    user
  end

  private

  def create_user_template_attributes
    [
      { name: "Address", required_create: true },
      { name: "City", required_create: true },
      { name: "Age" },
      { name: "Tel number" },
      { name: "Fix number" },
    ].each do |attrs|
      CustomAttributes::UserTemplate.create(attrs)
    end
  end

  def init_user_custom_attributes(user)
    CustomAttributes::UserTemplate.all.each do |ca|
      user.custom_attributes.build(
        name: ca.name,
        required_create: ca.required_create,
        required_update: ca.required_update
      )
    end
  end
end
