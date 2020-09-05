module Admin
  class LettersController < ApplicationController
    before_action :set_letter, only: [:edit, :update]

    # do not enter an unprotected action here like #index
    # it would display all, also private letters without permission
    # checks
    def index
      raise "not allowed error"
    end

    def edit
    end

    def update
      @letter.update!(letter_params)
      redirect_to edit_admin_letter_url(@letter.token)
    end

    private

    # for admins letters are gathered by a secret token, not the public
    # uuid
    def set_letter
      @letter = Letter.find_by_token(params[:token])
    end

    def letter_params
      params.require(:letter).permit(:body, :name, :email, :age, :canton, :lang, :publish_name, :publish_age, :publish_canton, :terms, :privacy, :over_15, :newsletter, :user_upload, :status, :reviewed_pdf)
    end

  end
end
