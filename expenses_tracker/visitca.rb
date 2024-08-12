require "rexml/document"
file_path = (__dir__ + "/visitca.xml")
if !File.exist?(file_path)
  abort "Ваш файл #{file_path} или засекречен или отсутствует"
end
file = File.new(file_path)
doc = REXML::Document.new(file)
file.close
visitca_mas = {}
["name", "tel", "email", "profil"].each do |item|
  visitca_mas[item] = doc.root.elements[item].text
end
puts "#{visitca_mas["name"]} tel: #{visitca_mas["tel"]}"
puts visitca_mas["email"]
puts "profil: #{visitca_mas["profil"]}"
