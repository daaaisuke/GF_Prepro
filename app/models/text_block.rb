class TextBlock < ApplicationRecord
  validates :text, :x1, :x2, :y1, :y2, :image_id, presence: true

  def self.view_css(image_id)
    texts = self.where(image_id: image_id)
    texts.map do |t|
      {
        x: t.x1,
        y: t.y1,
        width:  t.x2 - t.x1,
        height: t.y2 - t.y1
      }
    end
  end
end
