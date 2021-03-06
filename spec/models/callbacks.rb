class Artist
  include Mongoid::Document
  field :name
  embeds_many :songs
  embeds_many :labels

  before_create :before_create_stub
  after_create :create_songs

  protected
  def before_create_stub
    true
  end

  def create_songs
    2.times { |n| songs.create!(:title => "#{n}") }
  end
end

class Song
  include Mongoid::Document
  field :title
  embedded_in :artist, :inverse_of => :songs
end

class Label
  include Mongoid::Document
  field :name
  embedded_in :artist, :inverse_of => :labels
  before_validate :cleanup

  private
  def cleanup
    self.name = self.name.downcase.capitalize
  end
end
