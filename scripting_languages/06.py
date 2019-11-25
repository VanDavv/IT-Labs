import re
import datetime

with open('plan_zajec.ics') as f:
    text = f.read()
entries = re.findall(r"^BEGIN:VEVENT$\n(.*?)\n^END:VEVENT$", text, re.DOTALL|re.MULTILINE)


def get_time(entity):
    start = datetime.datetime.strptime(re.search(r'DTSTART.*:(.*)', entity).group(1), "%Y%m%dT%H%M%S")
    end = datetime.datetime.strptime(re.search(r'DTEND.*:(.*)', entity).group(1), "%Y%m%dT%H%M%S")
    return end - start

total_time = sum(map(get_time, entries), datetime.timedelta())
print(total_time / datetime.timedelta(minutes=45))
