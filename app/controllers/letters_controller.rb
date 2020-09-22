class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy, :thanks]
  before_action :set_nav_write, only: [:new, :edit, :thanks]
  before_action :set_nav_letters, only: [:index, :show]

  def index
    @filter_langs = params[:filter_langs] || []
    @letters = Letter.published(@filter_langs).with_rich_text_body.with_attached_reviewed_pdf.order("id DESC").limit(100)
  end

  def show
    @filter_langs = params[:filter_langs]
    @prev = @letter.prev(@filter_langs)
    @next = @letter.next(@filter_langs)
  end


  def new
    @letter = Letter.new
    @feed_images = (1..16).to_a.shuffle.first(9).map { |i| "feed#{i}.jpg" }
  end


  def edit
  end

  def upload
    @nav = :upload
    @letter = Letter.new
    @letter.lang = I18n.locale
    @letter.catalog = true
  end


  def create
    @letter = Letter.new(letter_params)
    @letter.catalog ||= true

    # letter came via online form - personal data needed
    if @letter.body.present?
      @letter.lang ||= I18n.locale
      @letter.status = :draft
      @letter.save!
      return redirect_to edit_letter_url(@letter)
    end
    # letter came via upload - all data present
    if @letter.user_upload.present?
      @letter.status = :submitted
      @letter.save!
      ApplicationMailer.send_notifications(@letter)
      return redirect_to thanks_letter_url(@letter)
    end
    # corner case, e.g. empty letter submitted
    return redirect_to new_letter_url
  end


  def update
    @letter.status = :submitted

    respond_to do |format|
      if @letter.update(letter_params)
        ApplicationMailer.send_notifications(@letter)
        format.html { redirect_to thanks_letter_url(@letter) }
        format.json { render :show, status: :ok, location: @letter }
      else
        format.html { render :edit }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  def thanks

  end

  def destroy
    @letter.destroy
    respond_to do |format|
      format.html { redirect_to letters_url, notice: 'Letter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.find_by_slug(params[:slug])
    end

    # Only allow a list of trusted parameters through.
    def letter_params
      # make sure not to include here:
      # - status
      # - slug
      # - token
      # - id
      params.require(:letter).permit(:body, :name, :email, :age, :canton, :lang, :publish_name, :publish_age, :publish_canton, :terms, :privacy, :over_15, :newsletter, :user_upload)
    end

    def set_nav_write
      @nav = :write
    end

    def set_nav_letters
      @nav = :letters
    end
end
