class Letter < ApplicationRecord
  has_rich_text :body
  has_one_attached :user_upload
  has_one_attached :reviewed_pdf

  before_create :set_secure_tokens
  enum status: [ :draft, :submitted, :accepted, :declined ]

  def self.published(filter_langs = [])
    self.accepted.where("catalog = true").where(lang: filter_langs)
  end

  def next(filter_langs)
    return if private?
    Letter.published(filter_langs).where("id > ?", id).order("id ASC").first
  end

  def prev(filter_langs)
    return if private?
    Letter.published(filter_langs).where("id < ?", id).order("id DESC").first
  end

  def to_param
    slug
  end

  def private?
    !catalog?
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

  def set_secure_tokens
    loop do
      self.slug = SecureRandom.uuid
      break unless Letter.where(slug: slug).exists?
    end
    loop do
      self.token = SecureRandom.uuid
      break unless Letter.where(slug: token).exists?
    end
  end

end
