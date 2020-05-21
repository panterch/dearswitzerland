class Letter < ApplicationRecord
  has_rich_text :body
  has_one_attached :user_upload
  has_one_attached :reviewed_pdf

  before_create :set_secure_tokens
  enum status: [ :draft, :submitted, :accepted, :declined ]

  def self.published(filter_langs)
    scope = self.accepted.where("catalog = true")
    return scope unless filter_langs.present?
    scope.where(lang: filter_langs)
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
    self.slug
  end

  def private?
    self.catalog? && self.submitted?
  end

  def display_name
    s = "#%04d" % id
    return s unless self.publish_name?
    s + ": " + name
  end

  def self.default_body
    "<div>#{I18n.t("letters.new.default_body")}<br><br></div>"
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
