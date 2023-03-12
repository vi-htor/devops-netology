from func import is_number

salary = (input('Введите заработную плату в месяц: '))
if is_number(salary) is False:
    print('Зарплата должна быть числом!')
    exit(1)
elif float(salary) <= 0:
    print('Долги это грустно(')
    exit()
mor_per = (input('Введите, какой процент(%) уходит на ипотеку: '))
if is_number(mor_per) is False:
    print('Процент должен быть числом!')
    exit(1)
elif float(mor_per) not in range(0,101):
    print('Проценты должны быть в диапазоне от 0 до 100 иначе о каких накоплениях речь??')
    exit()
life_per = (input('Введите, какой процент(%) уходит на жизнь: '))
if is_number(life_per) is False:
    print('Процент должен быть числом!')
    exit(1)
elif float(life_per) not in range(0,101):
    print('Проценты должны быть в диапазоне от 0 до 100 иначе о каких накоплениях речь??')
    exit()
year_salary = float(salary) * 12
year_mor = year_salary * float(mor_per) / 100
year_life = year_salary * float(life_per) / 100
print('Вывод:', '\nНа ипотеку было потрачено:', year_mor, '\nБыло накоплено:', year_salary - year_life - year_mor)