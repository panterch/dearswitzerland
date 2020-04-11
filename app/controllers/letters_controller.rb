class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy, :thanks]
  before_action :set_nav_write, only: [:new, :edit, :thanks]
  before_action :set_nav_letters, only: [:index, :show]

  # GET /letters
  # GET /letters.json
  def index
    @letters = Letter.public.with_rich_text_body.order("id DESC").limit(100)
  end

  # GET /letters/1
  # GET /letters/1.json
  def show
  end

  # GET /letters/new
  def new
    @letter = Letter.new
    @letter.body.body = Letter.default_body
  end

  # GET /letters/1/edit
  def edit
  end

  # POST /letters
  # POST /letters.json
  def create
    @letter = Letter.new(letter_params)
    @letter.lang = I18n.locale
    @letter.catalog = true
    @letter.status = :draft

    respond_to do |format|
      if @letter.save
        format.html { redirect_to edit_letter_url(@letter) }
        format.json { render :show, status: :created, location: @letter }
      else
        format.html { render :new }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /letters/1
  # PATCH/PUT /letters/1.json
  def update
    @letter.status = :submitted

    respond_to do |format|
      if @letter.update(letter_params)
        ApplicationMailer.with(letter: @letter).thanks_email.deliver_later
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

  # DELETE /letters/1
  # DELETE /letters/1.json
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
      params.require(:letter).permit(:body, :name, :email, :age, :canton, :lang, :catalog, :publish_name, :publish_age, :publish_canton, :recall, :newsletter)
    end

    def set_nav_write
      @nav = :write
    end

    def set_nav_letters
      @nav = :letters
    end
end
