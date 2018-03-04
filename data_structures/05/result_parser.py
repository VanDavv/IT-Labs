import os
import re
import csv

global writer

with open('results.csv', 'w') as output_file:
    for index in range(1, 101):
        with open(os.path.join('results', 'result{}.txt'.format(index))) as result:
            counter = -1
            reports = list(range(30))
            for line in [line.rstrip('\n') for line in result]:
                if len(line) == 0:
                    counter += 1
                    continue

                reports[counter] = (reports[counter] + [line]) if reports[counter] != counter else [line]

            for i, report in enumerate(reports):
                report_obj = {}
                report_obj['result_id'] = index
                report_obj['randomized'] = i > 14
                report_obj['type'] = re.search('\[(.+?)\](.+)', report[0]).group(1)
                report_obj['count'] = int(re.search('\[(.+?)\](.+)', report[0]).group(2))

                report_obj['inserted'] = int(re.search('Inserted: (.+)', report[2]).group(1))
                seconds, milis = re.search('Time taken (\d+?) seconds (\d+?) milliseconds', report[3]).groups()
                report_obj['insert_time'] = int(seconds) * 1000 + int(milis)

                report_obj['search'] = int(re.search('Found: (.+)', report[5]).group(1))
                seconds, milis = re.search('Time taken (\d+?) seconds (\d+?) milliseconds', report[6]).groups()
                report_obj['search_time'] = int(seconds) * 1000 + int(milis)

                report_obj['removed'] = int(re.search('Removed: (.+)', report[8]).group(1))
                seconds, milis = re.search('Time taken (\d+?) seconds (\d+?) milliseconds', report[9]).groups()
                report_obj['remove_time'] = int(seconds) * 1000 + int(milis)

                if index == 1 and i == 0:
                    writer = csv.DictWriter(output_file, report_obj.keys())
                    writer.writeheader()
                writer.writerow(report_obj)

