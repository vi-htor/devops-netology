from func import is_number

square_side = (input('Введите длину стороны квадрата: '))
if is_number(square_side) is False:
    print('Параметры квадрата:', '\nПериметр: 4({})'.format(square_side), '\nПлощадь: ({})**2'.format(square_side))
elif float(square_side) > 0:
    print('Параметры квадрата:', '\nПериметр:', float(square_side) * 4, '\nПлощадь: ', float(square_side) ** 2)
else:
    print('Сторона квадрата не может быть отрицательным числом!')
    exit(1)

rectangle_lengh = (input('Введите длину прямоугольника: '))
if is_number(rectangle_lengh) is True and float(rectangle_lengh) <= 0:
    print('Длина не может быть отрицательным числом!')
    exit(1)
rectangle_width = (input('Введите ширину прямоугольника: '))
if is_number(rectangle_width) is True and float(rectangle_width) <= 0:
    print('Ширина не может быть отрицательным числом!')
    exit(1)
if rectangle_lengh == rectangle_width:
    print('А мьсье знает толк в извращениях, по всей видимости ваш прямоугольник вполне себе квадрат...')
if is_number(rectangle_lengh) is False or is_number(rectangle_width) is False:
    print('Параметры прямоугольника:', '\nПериметр: 2({}+{})'.format(rectangle_width, rectangle_lengh), '\nПлощадь: {}*{}'.format(rectangle_width, rectangle_lengh))
else:
    print('Параметры прямоугольника:', '\nПериметр:', 2 * (float(rectangle_width) + float(rectangle_lengh)), '\nПлощадь: ', float(rectangle_width) * float(rectangle_lengh))