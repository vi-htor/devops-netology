zodiac = 0
month = int(input('Введите номер месяца Вашего рождения '))
if month == 0 or month > 12:
  print('ошибка в месяце')
  exit()
day = int(input('Введите день Вашего рождения '))

if month == 1 and day in range(21,32) or month == 2 and day in range(1,19):
    zodiac = 'Водолей'
elif month == 2 and day in range(19,32) or month == 3 and day in range(1,21):
    zodiac = 'Рыбы'
elif month == 3 and day in range(21,31) or month == 4 and day in range(1,21):
    zodiac = 'Овен'
elif month == 4 and day in range(21,32) or month == 5 and day in range(1,22):
    zodiac = 'Телец'
elif month == 5 and day in range(22,31) or month == 6 and day in range(1,22):
    zodiac = 'Близнецы'
elif month == 6 and day in range(22,32) or month == 7 and day in range(1,23):
    zodiac = 'Рак'
elif month == 7 and day in range(23,32) or month == 8 and day in range(1,24):
    zodiac = 'Лев'
elif month == 8 and day in range(24,31) or month == 9 and day in range(1,23):
    zodiac = 'Дева'
elif month == 9 and day in range(23,32) or month == 10 and day in range(1,24):
    zodiac = 'Весы'
elif month == 10 and day in range(24,31) or month == 11 and day in range(1,23):
    zodiac = 'Скорпион'
elif month == 11 and day in range(23,32) or month == 12 and day in range(1,22):
    zodiac = 'Стрелец'
elif month == 12 and day in range(22,32) or month == 1 and day in range(1,21):
    zodiac = 'Козерог'

if zodiac == 0:
  print('ошибка в дне')
else:
  print('Ваш знак зодиака - ' + zodiac)
