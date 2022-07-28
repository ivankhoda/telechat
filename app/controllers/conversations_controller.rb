class ConversationsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :load_entities

  def index
    @conversations = Conversation.all
    render json: @conversations
  end

  def new
    @conversation = Conversation.new
  end

  def show
    @message = Message.new conversation: @conversation
    @messages = @conversation.messages.includes(:user)
  end

  def create
    @conversation = Conversation.new permitted_parameters

    if @conversation.save

      render json: @conversation

    else
      render json: { error: @conversation.errors }
    end
  end

  def edit; end

  def update
    if @conversation.update_attributes(permitted_parameters)
      render json: @conversation
    else
      render :new
    end
  end

  def destroy
    if @conversation.delete
      render json: { message: 'Success' }
    else
      render json: { message: @conversation.errors }
    end
  end

  protected

  def load_entities
    @conversations = Conversation.all
    @conversation = Conversation.find(params[:id]) if params[:id]
  end

  private

  def permitted_parameters
    params.require(:conversation).permit(:name)
  end
end
