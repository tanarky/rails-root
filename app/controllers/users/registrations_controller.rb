# coding: utf-8
class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    destroy_user_session_path
  end
end
