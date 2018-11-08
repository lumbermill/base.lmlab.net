class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /messages
  # GET /messages.json
  def index
    if current_user.admin?
      # adminのときは宛先を選択可能にする
      receiver_id = params[:receiver_id].to_i
    else
      # 一般ユーザ
      receiver_id = 1
    end
    @messages = Message.find_by_users(current_user,User.find(receiver_id))
    @message = Message.new
    @message.sender_id = current_user.id
    @message.receiver_id = receiver_id
    @message.type = ''
    @message.opened = false
  end

  def index_by_users
    raise "not implemented" unless current_user.admin?
    # adminだけが使える
    @users = User.order(:id)
    @new_arrives = {}
    @users.each do |u|
      # TODO: 新着件数を表示したい
      @new_arrives[u.id] = 0
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        if @message.receiver_id == 1
          u = User.find(@message.sender_id)
          ApplicationHelper.slack_ping("#{u.name}様(id:#{u.id})からお問い合わせがありました。\nhttps://base.lmlab.net")
        end
        format.html { redirect_to messages_url(receiver_id: @message.receiver_id), notice: 'Message was successfully created.' }
        format.json { render :no_content }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender_id, :receiver_id, :type, :body, :opened)
    end
end
