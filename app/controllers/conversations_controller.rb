class ConversationsController < ApplicationController
  protect_from_forgery with: :null_session, only: [:create]
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
      render json: { message: "Conversation #{@conversation.name} was created successfully" }

    else
      render :new
    end
  end

  def edit; end

  def update
    if @conversation.update_attributes(permitted_parameters)
      render json: { message: "Conversation #{@conversation.name} was updated successfully" }
    else
      render :new
    end
  end

  protected

  def load_entities
    @conversations = Conversation.all
    @conversation = Conversation.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:conversation).permit(:name)
  end
end
