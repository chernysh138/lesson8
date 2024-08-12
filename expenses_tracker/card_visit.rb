require "nokogiri"
require "open-uri"
file_path = __dir__ + "/card_visit.html"
if !File.exist?(file_path)
  abort "файл не найден"
end
file = File.new(file_path)
doc = Nokogiri::HTML(URI.open("./card_visit.html"))
doc.
  file.close
visit = []
