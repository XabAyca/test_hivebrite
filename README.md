# Backend Test
### Develop a functionality allowing administrators to customize:

- the User profile
- the User signup form
- an Event Registration form   

In order to focus on the important parts, no need to develop a UI. The code will be run through the tests, and possibly through the console. We want to focus on models, possibly service classes with clean interfaces, but not controllers/views.

### Use cases that the service must support:

- Admin manages the global User custom attributes
  - With `CustomAttributes::UserTemplate` 
- Admin manages a specific Event’s custom attributes
  - With `CustomAttributes::Event`
  - And nested attributes  
- Admin makes a custom attribute optional/required on the User profile
  - With `CustomAttributes::User`
  - And `required_update` field specific validates  
- Admin makes a custom attribute optional/required on the User signup form
  - With `CustomAttributes::User`
  - And `InitNewUserService` service to initialize a new instance of user with all global custom attributes
  - And `required_create` field specific validates  
- Admin makes a custom attribute optional/required on a specific Event Registration form
  - With `CustomAttributes::Registration`
  - And `required_create` field specific validates  
- User fills in a custom attribute on his profile
  - With `CustomAttributes::User`
  - And nested attributes
- User fills in a custom attribute on the signup form
  - With `CustomAttributes::User`
  - And nested attributes
- User fills in a custom attribute on an Event Registration form
  - With `CustomAttributes::Registration`
  - And `InitNewRegistrationService` service to initialize a new instance of registration with event specific custom attributes
  - And nested attributes
- User reads his custom attributes on his profile
  - With `CustomAttributes::User`
  - and `User` relation
- Admin reads an Event registration’s custom attributes
  - With `CustomAttributes::Registration`
  - And `Registration` relation
- Custom attributes types supported:
  - Text
  - Boolean
    - Overide `value` getter and setter in `CustomAttributes`


### Project
- Ruby `3.1.1`
- Rails `7.0.4.3`
- No docker

*test*
- `gh repo clone XabAyca/test_hivebrite`
- Create db and run migrations `rails db:create && rails db:migrate`
- Run rspec test `rspec` 
