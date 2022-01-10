class ApplicationController < ActionController::Base

    before_action :authenticate_customer!,except: [:top]
    before_action :configure_permitted_parameters, if: :devise_controller?


    def after_sign_in_path_for(resource)
      case resource
      when Admin
      admin_top_path
      when Customer
      items_path
      end
    end

	  def after_sign_up_path_for(resource)
      case resource
      when Admin
      admin_top_path
      when Customer
      root_path
      end
    end


     def after_sign_out_path_for(resource)
      if resource == :admin
      new_admin_session_path
      else
      new_customer_session_path
      end
    end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
