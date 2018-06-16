use clinic
go

insert into employee_type (profession, specialization, descr) values (
    'Lekarz', 'Medycyna rodzinna', '')
go
insert into employee_type (profession, specialization, descr) values (
    'Lekarz', 'Neurolog', '')

 go 
insert into employee_type (profession, specialization, descr) values (
    'Lekarz', 'Kardiolog', '')
 go 
insert into employee_type (profession, specialization, descr) values (
    'Pielęgniarka', '', 'Punkt pobrania krwi')
 go 
insert into employee_type (profession, specialization, descr) values (
    'Pielęgniarka', '', '')
 go

insert into employee (pesel, name, degree, fulltime, started_working_date, phone, type) values (
    43122248594, 'Bernadetta Myszczyszyn', 'lekarz', 1, '2004-02-01', '694283582', 1)
 go 
insert into employee (pesel, name, degree, fulltime, started_working_date, phone, type) values (
    46111243215, 'Katarzyna Kowalska', 'doktor nauk medycznych', 1, '2008-06-01', '614423512', 2)
 go 
insert into employee (pesel, name, degree, fulltime, started_working_date, phone, type) values (
    66051854326, 'Krzysztof Adamski', 'lekarz', 0, '2004-01-01', '784928903', 3)
 go 
insert into employee (pesel, name, degree, fulltime, started_working_date, phone, type) values (
    85071184573, 'Patrycja Nowak', 'magister', 1, '2004-10-27', '948290572', 4)
go
insert into employee (pesel, name, degree, fulltime, started_working_date, phone, type) values (
    79103094729, 'Grażyna Wąchur', 'licencjat', 1, '2012-05-01', '', 5)
go
insert into employee (pesel, name, degree, fulltime, started_working_date, phone, type) values (
    8001129740, 'Wioletta Dziwadło', 'licencjat', 1, '2007-01-01', '', 5)
go

 go
insert into patient (pesel, name, address, phone, major_diseases, const_medications) values (
    71052004632, 'Fryderyk Szczepański', 'ul. Julii 44 20-710 Lublin', '79 799 61 07', '', '')
 go 
insert into patient (pesel, name, address, phone, major_diseases, const_medications) values (
    83072908511, 'Gabrjel Kucharski', 'ul. Traktorowa 15 91-130 Łódź', '53 635 55 68', 'ICD10.I10', 'enarenal 10mg x1')
 go
insert into patient (pesel, name, address, phone, major_diseases, const_medications) values (
    98051003431, 'Egidiusz Sokołowski', 'ul. Badury Szymona 10 40-862 Katowice', '51 508 13 00', '', '')

 go
insert into invoice (start_date, number, netto, tax, gross, contractor, nip) values (
'2016-01-12','F666', 150, 12, 162, 'Fryderyk Szczepański', ''
)
 go
insert into invoice (start_date, number, netto, tax, gross, contractor, nip) values (
'2016-05-12', 'F325',100, 8, 108, 'Gabrjel Kucharski', ''
)
 go
insert into invoice (start_date, number, netto, tax, gross, contractor, nip) values (
'2016-06-12', 'F333',100, 8, 108, 'Egidiusz Sokołowski', ''
)

 go
insert into slot (day_num, start_hour, end_hour) values (
1, '11:00:00', '11:15:00'
)

 go
insert into slot (day_num, start_hour, end_hour) values (
    1, '11:15:00', '11:30:00'
)

 go
insert into slot (day_num, start_hour, end_hour) values (
    2, '11:00:00', '11:30:00'
)

 go
insert into office_hours (day_num, start_date, end_date, employee) values (
    1, '11:00:00', '11:30:00', 43122248594
)
 go
insert into office_hours (day_num, start_date, end_date, employee) values (
    2, '11:00:00', '11:30:00', 46111243215
)
 go
insert into office_hours (day_num, start_date, end_date, employee) values (
    1, '11:00:00', '11:30:00', 85071184573
)

 go
insert into office_hours_m2m (slot, office_hours) values (
    1, 1
)
 go
insert into office_hours_m2m (slot, office_hours) values (
    2, 1
)
 go
insert into office_hours_m2m (slot, office_hours) values (
    3, 2
)

 go
insert into registerer (name) values (
 'Anna Małecka'
)
 go
insert into registerer (name) values (
 'Agata Krzysztofik'
)
 go
insert into registerer (name) values (
 'Beata Patrykowicz'
)

 go
insert into diagnosis (name, icd10, descr) values (
    'Do dalszej konsultacji', 'Do dalszej konsultacji', 'Do dalszej konsultacji'
)
 go
insert into diagnosis (name, icd10, descr) values (
    'Nadciśnienie tętnicze nieznanego pochodzenia', 'I10.0', ''
)
 go
insert into diagnosis (name, icd10, descr) values (
    'Trądzik', 'L70', ''
)
 go
insert into diagnosis (name, icd10, descr) values (
    'Kardiomiopatia rozstrzeniowa', 'I40.0', ''
)
 go
insert into diagnosis (name, icd10, descr) values (
    'Otoskleroza', 'H80.2', ''
)

 go
insert into medicine (int_name, detail_name, dose) values (
    'enalapryl', 'Enarenal', '10mg'
)
 go
insert into medicine (int_name, detail_name, dose) values (
    'gentamycyna', 'Gentamicin', '3 mg/ml'
)
 go
insert into medicine (int_name, detail_name, dose) values (
    'diazepam', 'Relanium', '2 mg'
)

 go
insert into prescription (prescription_id, medicine, additionals) values (
    '341541251', 1, ''
)

 go
insert into prescription (prescription_id, medicine, additionals) values (
    '5555151', 2, 'Wieczorem'
)

 go
insert into visit (date, patient, invoice, recorder) values (
    '2018-01-01', 71052004632, 1, 1
)
 go
insert into visit (date, patient, invoice, recorder) values (
    '2018-01-02', 83072908511, 2, 2
)
 go
insert into visit (date, patient, invoice, recorder) values (
    '2018-01-03', 98051003431, 3, 3
)
 go
insert into salary (employee, start_date, active, netto, vat_payer) values (
    43122248594, '2018-01-01', 1, '100', 0
)
 go
insert into salary (employee, start_date, active, netto, vat_payer) values (
    46111243215, '2017-01-01', 1, '120', 1
)

 go
insert into examination (name, value) values (
    'Konsultacja', 100
)
 go
insert into examination (name, value) values (
    'USG Jamy brzusznej', 150
)
 go
insert into examination (name, value) values (
    'USG Serca', 180
)

 go
insert into office (number, name) values (
    '122', 'Gabinet neurologiczny'
)
 go
insert into office (number, name) values (
    '101', 'Gabinet podstawowy'
)
 go
insert into office (number, name) values (
    '11', 'Punkt poboru krwi'
)

 go
insert into examination_on_visit (date, exam, diagnosis, staff, admission_hours, visit, office) values (
 '2018-01-01', 1, 1, 66051854326, 1, 1 ,1
)
 go
insert into examination_on_visit (date, exam, diagnosis, prescription, staff, admission_hours, visit, office) values (
'2018-01-01', 2, 4, 1, 46111243215, 2, 1, 2
)
 go
insert into examination_on_visit (date, exam, diagnosis, prescription, staff, admission_hours, visit, office) values (
'2018-01-02', 1, 3, 2, 43122248594, 3, 2, 3
)
 go
insert into examination_on_visit (date, exam, diagnosis, staff, admission_hours, visit, office) values (
'2018-01-02', 3, 1, 66051854326, 1, 3, 1
)
