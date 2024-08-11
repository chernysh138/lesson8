require "rexml/document"
require "date"

file_name = __dir__ + "/my_expenses.xml"
if !File.exist?(file_name)
  abort "Извиняемся, хозяин, файлик #{file_name} не найден."
end
file = File.new(file_name)
doc = REXML::Document.new(file)
file.close

amount_by_day = {}

doc.elements.each("expenses/expense") do |item|
  loss_sum = item.attributes["amount"].to_i
  loss_date = Date.parse(item.attributes["date"])
  amount_by_day[loss_date] ||= 0
  amount_by_day[loss_date] += loss_sum
end

# Сделаем хэш, в который соберем сумму расходов за каждый месяц
sum_by_month = {}

# В цикле по всем датам хэша amount_by_day накопим в хэше sum_by_month значения
# потраченных сумм каждого дня
amount_by_day.keys.sort.each do |key|
  # key.strftime('%B %Y') вернет одинаковую строку для всех дней одного месяца
  # поэтому можем использовать ее как уникальный для каждого месяца ключ
  sum_by_month[key.strftime("%B %Y")] ||= 0

  # Приплюсовываем к тому что было сумму следующего дня
  sum_by_month[key.strftime("%B %Y")] += amount_by_day[key]
end

# Пришло время выводить статистику на экран в цикле пройдемся по всем месяцам и
# начнем с первого
current_month = amount_by_day.keys.sort[0].strftime("%B %Y")

# Выводим заголовок для первого месяца
puts "------[ #{current_month}, всего потрачено: " \
     "#{sum_by_month[current_month]} р. ]--------"

# Цикл по всем дням
amount_by_day.keys.sort.each do |key|
  # Если текущий день принадлежит уже другому месяцу...
  if key.strftime("%B %Y") != current_month

    # То значит мы перешли на новый месяц и теперь он станет текущим
    current_month = key.strftime("%B %Y")

    # Выводим заголовок для нового текущего месяца
    puts "------[ #{current_month}, всего потрачено: " \
         "#{sum_by_month[current_month]} р. ]--------"
  end

  # Выводим расходы за конкретный день
  puts "\t#{key.day}: #{amount_by_day[key]} р."
end
