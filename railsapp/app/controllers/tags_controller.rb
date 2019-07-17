class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        if File.file? tmpfile4picture
          FileUtils.mv(tmpfile4picture,Tag.picture_realpath(@tag.code))
        end
        format.html { redirect_to @tag, notice: t('Tag') + t('was successfully created') }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        if File.file? tmpfile4picture
          FileUtils.mv(tmpfile4picture,Tag.picture_realpath(@tag.code))
        end
        format.html { redirect_to @tag, notice: t('Tag') + t('was successfully updated') }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    respond_to do |format|
      if @tag.products
        format.html { redirect_to tags_url, notice: t('Tag') + t('can not be deleted') }
        format.json { head :no_content }
      else 
        @tag.destroy
        format.html { redirect_to tags_url, notice: t('Tag') + t('was successfully destroyed') }
        format.json { head :no_content }
      end
    end
  end

  def picture
    code = params[:code]
    f = Tag.picture_realpath(code)
    if File.file? f
      send_file(f, type: 'image/jpeg', disposition: "inline")
    else
      head 404
      send_file(Rails.root.join('app', 'assets', 'images', 'no-photo.png'), type: 'image/jpeg', disposition: "inline", status: 404)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      pp =  params.require(:tag).permit(:code, :name, :copy, :memo, :picture)
      if pp[:picture]
        File.open(tmpfile4picture, 'w+b') do |fp|
          fp.write pp[:picture].read
        end
        # TODO: if the image is not jpg, convert it to jpg.
        # TODO: if the size is too large, smallen it.
        pp.delete(:picture)
      end
      pp
    end

    def tmpfile4picture
      TAG_IMAGES_DIR+"/"+ session[:session_id] +".jpg"
    end
end
