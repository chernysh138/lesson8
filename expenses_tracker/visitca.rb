require "rexml/document"
file_path = (__dir__ + "/visitca.xml")
if !File.exist?(file_path)
  abort "Ваш файл #{file_path} или засекречен или отсутствует"
end
file = File.new(file_path)
doc = REXML::Document.new(file)
file.close
visitca_mas = []
doc.elements.each("visit/user") do |item|
  visitca_mas << item.attributes["name"]
  visitca_mas << item.attributes["tel"]
  visitca_mas << item.attributes["email"]
  visitca_mas << item.attributes["category"]
end
puts visitca_mas
