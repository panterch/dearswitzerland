class Letter < ApplicationRecord
  has_rich_text :body
  before_create :set_slug
  enum status: [ :draft, :submitted ]

  def self.public(filter_langs = [])
    self.submitted.where("catalog = true").where(lang: filter_langs)
  end

  def next(filter_langs)
    return if private?
    Letter.public(filter_langs).where("id > ?", id).order("id ASC").first
  end

  def prev(filter_langs)
    return if private?
    Letter.public(filter_langs).where("id < ?", id).order("id DESC").first
  end

  def to_param
    slug
  end

  def private?
    !submitted? || !catalog?
  end

  def display_name
    s = "#%04d" % id
    return s unless self.publish_name?
    s + ": " + name
  end

  def self.default_body
    "<div class=\"trix-content\"><h1>#{I18n.t("letters.new.default_body")}</h1><div><br></div></div>"
  end

  private

  def set_slug
    loop do
      self.slug = SecureRandom.uuid
      break unless Letter.where(slug: slug).exists?
    end
  end

end
