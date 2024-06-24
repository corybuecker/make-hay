# frozen_string_literal: true

class PageJob < ApplicationJob
  include ActionView::RecordIdentifier
  queue_as :default
  discard_on StandardError

  def perform(link)
    raw = PageFetcher.fetch(url: link.url)
    title = TitleParser.parse(contents: raw)
    parsed = ContentParser.parse(contents: raw)

    link.broadcast_update_later_to(
      link.user.identity,
      [:page, link.id],
      channel: PageChannel,
      target: dom_id(link, :page),
      partial: 'links/page',
      locals: {
        user: link.user,
        link: link,
        title: title,
        content: parsed
      }
    )
  end
end
