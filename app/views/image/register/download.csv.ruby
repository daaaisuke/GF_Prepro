require 'csv'
CSV.generate do |csv|
  field_names = %w(id filename text x1 y1 x2 y2)
  csv << field_names
  TextBlock.all.each do |t|
    record = field_names.map do |field_name|
      case field_name
      when "filename"
        Image.find(t.image_id).filename
      else
        t[field_name]
      end
    end
    csv << record
  end
end.encode('CP932')
