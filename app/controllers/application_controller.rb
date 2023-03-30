class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    if params[:lang] && I18n.available_locales.include?(params[:lang].to_sym)
      session[:lang] = params[:lang]
    end

    I18n.locale = session[:lang] || I18.default_locale
  end
end
