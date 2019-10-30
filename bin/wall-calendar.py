#!/usr/bin/env python3

from datetime import date, timedelta
from bs4 import BeautifulSoup

def mk_cal(start, nweeks):
    # start calendar on previous Saturday
    cursor = start
    while cursor.strftime('%A') != 'Saturday':
        cursor -= timedelta(1)
    # list of nweeks weeks which are each a list of 7 days
    cal = []
    for i in range(nweeks):
        week = []
        for j in range(7):
            week.append(cursor)
            cursor += timedelta(1)
        cal.append(week)
    return cal

def tex_cal(cal, width, height):
    tex = tex_hdr(width, height) + tex_array(cal, height) + tex_ftr()
    return tex

def tex_hdr(width, height):
    # compute table spec for width (HACK)
    col_width = (width - 2.5) / 7
    col_spec = "p{{{}in}}".format(col_width)
    tspec = ' | '.join([col_spec] * 7)
    # escape backslashes and curlies
    return '''
\\documentclass{{article}}
\\usepackage[paperwidth={width}in,paperheight={height}in,margin=0.5in,heightrounded]{{geometry}}

\\newcommand{{\\dow}}[1]{{\multicolumn{{1}}{{c}}{{\\textbf{{#1}}}}}}

\\begin{{document}}
\\pagestyle{{empty}}

\Huge

\\begin{{center}}
\\begin{{tabular}}{{| {tspec} |}}

\\dow{{Saturday}} &
\\dow{{Sunday}} &
\\dow{{Monday}} &
\\dow{{Tuesday}} &
\\dow{{Wednesday}} &
\\dow{{Thursday}} &
\\dow{{Friday}} \\\\[0.25in]
'''.format(width=width, height=height, tspec=tspec)

def tex_array(cal, height):
    # compute row height (HACK)
    rh = (height - 7) / len(cal)
    # generate table
    weeks = []
    for week in cal:
        days = []
        for day in week:
            if day.day == 1:
                days.append('\\textbf{{{} 1}}'.format(day.strftime('%b')))
            else:
                days.append(str(day.day))
        weeks.append(' & '.join(days) + ' \\\\[{}in]'.format(rh))
    hl = '\\hline\n'
    return hl + hl.join(weeks) + hl

def tex_ftr():
    return '''
\\end{tabular}
\\end{center}

\\end{document}
'''

def html_cal(cal):
    html = html_hdr() + html_array(cal) + html_ftr()
    return BeautifulSoup(html, features='html.parser').prettify()

def html_hdr():
    return '''
<html>
<head>
  <link rel='stylesheet' media='screen' href='https://fontlibrary.org/face/cmu-concrete' type='text/css' />
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
'''

def html_array(cal):
    res = []
    for week in cal:
        res.append('<tr>')
        for day in week:
            if day.day == 1:
                res.append('<td class="first">{} 1</td>'.format(day.strftime('%b')))
            else:
                res.append('<td>{}</td>'.format(day.day))
        res.append('</tr>')
    return '\n'.join(res)

def html_ftr():
    return '''
</table>

</body>
</html>
'''

s = date.fromisoformat('2019-10-28')
c = mk_cal(s, 12)
print(tex_cal(c, 24, 36))
