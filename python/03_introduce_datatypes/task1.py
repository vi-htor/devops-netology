boys = ['Peter', 'Alex', 'John', 'Arthur', 'Richard']
girls = ['Kate', 'Liza', 'Kira', 'Emma', 'Trisha']
if len(boys) != len(girls):
    print('Неравное количество парней и девушек.')
else:
    print('Пары:')
    for m, f in zip(sorted(boys), sorted(girls)):
        print(m, '&', f)