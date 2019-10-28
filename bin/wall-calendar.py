#!/usr/bin/env python3

from datetime import date, timedelta

NWEEKS = 12
ONE_DAY = timedelta(1)

start = date.fromisoformat('2019-10-28')

# our calendars start on saturdays
while start.strftime('%A') != 'Saturday':
    start -= ONE_DAY

print('''
<html>
<head>
    <link rel="stylesheet" media="screen" href="https://fontlibrary.org/face/cmu-concrete" type="text/css" />
    <style>
        table {
            font-family: 'CMUConcreteRoman';
            font-weight: normal;
            font-style: normal;
            width: 100%;
            height: 100%;
            padding: 1em;
            border-collapse: collapse;
        }
        th {
            height: 1.5em;
        }
        td {
            font-size: 14pt;
            width: 14%;
            text-align: left;
            vertical-align: top;
            padding: 0.2em 0 0 0.2em;
            border: 1px solid black;
        }
        th, td.first {
            font-size: 16pt;
        }
    </style>
</head>
<body>

<table>
    <tr>
        <th>Sat</th>
        <th>Sun</th>
        <th>Mon</th>
        <th>Tue</th>
        <th>Wed</th>
        <th>Thu</th>
        <th>Fri</th>
    </tr>
''')

cursor = start
for i in range(NWEEKS):
    print('    <tr>')
    for j in range(7):
        day = str(cursor.day)
        if day == "1":
            month = cursor.strftime('%b')
            print('        <td class="first">{month} {day}</td>'.format(month=month,day=day))
        else:
            print('        <td>{day}</td>'.format(day=day))
        cursor += ONE_DAY
    print('    </tr>')

print('''
</table>

</body>
</html>
''')
