# frozen_string_literal: true

class PageChannel < Turbo::StreamsChannel
  def subscribed
    if (stream_name = verified_stream_name_from_params).present? && subscription_allowed?(stream_name)
      stream_from stream_name

      identity, action, link_id = stream_name.split(':')
      PageJob.perform_later(Link.find(link_id))
    else
      reject
    end
  end

  private

  def subscription_allowed?(stream_name)
    identity, action, link_id = stream_name.split(':')
    return false unless %w[page].include?(action)
    user = User.find_by(identity:)
    return false unless user.present?
    return user.links.where(id: link_id).exists?
  end
end
