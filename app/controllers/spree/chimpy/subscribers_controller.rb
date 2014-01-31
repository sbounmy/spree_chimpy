module Spree
  class Chimpy::SubscribersController < StoreController
    respond_to :html

    def create
      @subscriber = Chimpy::Subscriber.where(email: params[:chimpy_subscriber][:email]).first_or_initialize
      @subscriber.update_attributes(params[:chimpy_subscriber])
      if @subscriber.save
        Chimpy::Subscription.new(@subscriber).subscribe
        flash[:notice] = I18n.t("spree.chimpy.subscriber.success")
      else
        flash[:error] = I18n.t("spree.chimpy.subscriber.failure")
      end

      respond_with @subscriber, location: request.referer
    end
  end
end