class ConversationsController < ApplicationController
  layout "dashboard"
  # TODO: Require login, access to conversation
  before_filter :find_conversation, :only => [:show, :reply, :destroy]
  # before_filter :find_or_initialize, :only => [:new, :create]

  def new
    @object = get_instance_from(params)
    @conversation = find_or_initialize_for(@object, current_user)
    respond_to do |format|
      format.js { render :partial => "conversations/ajax_new", :layout => false }
      format.html
    end
  end

  def create
    # TODO: REFACTOR!
    object = get_instance_from(params)
    conversation = find_or_initialize_for(object, current_user)
    recipient_id = get_recipient_for(object, current_user)

    message = conversation.messages.build({
      sender_id: current_user.id,
      recipient_id: recipient_id,
      content: params[:content]
    })
    
    if conversation.persisted?
      message.save
    else
      conversation.recipient_id = recipient_id
      conversation.save
    end

    if message.persisted?
      respond_to do |format|
        format.html { redirect_to conversation_url(conversation) }
        format.js { render :nothing => true }
      end
    else
      respond_to do |format|
        format.html { render :new }
        # TODO: Handle errors with js
        format.js { }
      end
    end
  end

  def index
    @conversations = Conversation.for_user(current_user)
  end

  def show
    @message = Message.new
  end

  def reply
    @message = @conversation.messages.build(params[:message])
    @message.sender = current_user
    @message.recipient = @conversation.recipient
    if @message.save
      redirect_to conversation_url(params[:id]), notice: "Reply added successfully."
    else
      redirect_to conversation_url(params[:id]), notice: "Failed to add the reply."
    end
  end

  private

    def find_conversation
      @conversation = Conversation.find(params[:id])
    end

    def get_instance_from(params)
      klass = params[:type].constantize
      instance = klass.find(params[:id])
    rescue NameError
      # Deal with someone trying to use a class that doesn't exist
    end

    def get_recipient_for(object, sender)

      recipient = case object.class.name
                  when "Item"
                    object.user_id
                  when "Order"
                    if object.buyer_id == sender.id
                      object.seller_id
                    else
                      object.buyer_id
                    end
                  end
    end

    def find_or_initialize_for(object, sender)
      if object.respond_to?('conversations')
        conversation = object.conversations.first_or_initialize({
          sender_id: sender.id
        })
      else
        # Deal with wrong type of object being called
      end
      conversation
    end
end
