class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title
  
  validates :title, :presence => true, :uniqueness => true
  validates :content, :presence => true
  
  def self.published_pages
    where('published_on IS NOT NULL AND published_on <= ?', Time.now).order('published_on desc')
  end
  
  def self.unpublished_pages
    where('published_on IS NULL OR published_on > ?', Time.now).order('published_on desc')
  end

  def words
    { id: self.id, word_count: self.content.split.size + self.title.split.size }
  end
  
  def publish_now
    self.published_on = Time.now
  end
  
end
