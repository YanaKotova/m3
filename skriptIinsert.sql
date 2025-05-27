
CREATE TABLE buildings (
    id SERIAL PRIMARY KEY,
    address TEXT NOT NULL,
    management_start DATE NOT NULL,
    floors INTEGER NOT NULL,
    apartments INTEGER,
    construction_year INTEGER,
    total_area NUMERIC(10,2)
);

CREATE TABLE apartments (
    id SERIAL PRIMARY KEY,
    building_id INTEGER REFERENCES buildings(id) ON DELETE CASCADE,
    number INTEGER NOT NULL
);

CREATE TABLE residents (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    phone TEXT
);

CREATE TABLE apartment_owners (
    id SERIAL PRIMARY KEY,
    apartment_id INTEGER REFERENCES apartments(id) ON DELETE CASCADE,
    resident_id INTEGER REFERENCES residents(id) ON DELETE CASCADE,
    ownership_start DATE DEFAULT CURRENT_DATE,
    ownership_end DATE
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    apartment_id INTEGER REFERENCES apartments(id) ON DELETE CASCADE,
    period TEXT NOT NULL,
    charged NUMERIC(10,2) NOT NULL,
    paid NUMERIC(10,2) DEFAULT 0
);

CREATE TABLE utility_debts (
    id SERIAL PRIMARY KEY,
    apartment_id INTEGER REFERENCES apartments(id) ON DELETE CASCADE,
    water_debt NUMERIC(12,2) DEFAULT 0,
    electricity_debt NUMERIC(12,2) DEFAULT 0,
    debt_date DATE NOT NULL
);

CREATE TABLE service_requests (
    id SERIAL PRIMARY KEY,
    apartment_id INTEGER REFERENCES apartments(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status TEXT CHECK (status IN ('Открыта заявка', 'Заявка в работе', 'Заявка закрыта')) NOT NULL
);

CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL -- Например, "администратор", "рабочий", "руководитель"
);

CREATE TABLE request_assignments (
    id SERIAL PRIMARY KEY,
    request_id INTEGER REFERENCES service_requests(id) ON DELETE CASCADE,
    staff_id INTEGER REFERENCES staff(id) ON DELETE CASCADE,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    resident_id INTEGER REFERENCES residents(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE financial_reports (
    id SERIAL PRIMARY KEY,
    period TEXT NOT NULL,
    resource_income NUMERIC(14,2) NOT NULL,
    resource_expenses NUMERIC(14,2) NOT NULL,
    profitability NUMERIC(10,4) -- Расчёт: доход / расходы
);

INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (1, 'ул. 45 Параллель, 4/2, Ставрополь', '2015-04-22', 9, 52, 2001, 1978.70);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (2, 'ул. Васильева, 1, Ставрополь', '2015-04-22', 9, 144, 1983, 7950.40);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (3, 'ул. Доваторцев, 66/2, Ставрополь', '2020-11-01', 9, 102, 1984, 3176.40);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (4, 'ул. Мира, 236, Ставрополь', '2007-11-04', 10, 62, 1991, 4423.10);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (5, 'ул. Мира, 272, Ставрополь', '2015-04-22', 9, 88, 2006, 6204.70);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (6, 'ул. Мира, 278, Ставрополь', '2019-08-01', 10, 40, 2008, 3294.10);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (7, 'пл. Выставочная, 40, Светлоград', '2018-12-01', 5, 70, 1985, 2369.20);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (8, 'пл. Выставочная, 43, Светлоград', '2019-07-01', 5, 68, 1987, 3702.80);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (9, 'пл. Выставочная, 45, Светлоград', '2019-12-01', 4, 68, 1990, 3731.50);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (10, 'пл. Выставочная, 47, Светлоград', '2019-07-01', 5, 68, 1993, 4079.20);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (11, 'пл. Выставочная, 48, Светлоград', '2018-12-01', 5, 68, 1995, 3654.60);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (12, 'пл. Выставочная, 49, Светлоград', '2021-06-01', 5, 60, 1995, 2891.70);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (13, 'пл. Выставочная, 50, Светлоград', '2019-02-01', 5, 60, 1995, 4014.50);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (14, 'пл. Выставочная, 57, Светлоград', '2020-02-01', 3, 36, 2015, 2075.70);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (15, 'пл. Выставочная, 58, Светлоград', '2021-11-01', 5, null, 2013, 3124.20);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (16, 'ул. Бассейная, 82, Светлоград', '2021-03-01', 5, 48, 1988, 3255.30);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (17, 'ул. Красная, 44а, Светлоград', '2022-03-01', 5, 60, 1983, 4317.40);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (18, 'ул. Матросова, 179а, Светлоград', '2022-02-18', 4, 28, 1979, 879.40);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (19, 'ул. Пушкина, 12, Светлоград', '2020-10-01', 5, 118, 1980, 5316.80);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (20, 'ул. Пушкина, 3а, Светлоград', '2018-12-01', 5, 48, 1990, 1007.90);
INSERT INTO public.buildings (id, address, management_start, floors, apartments, construction_year, total_area) VALUES (21, 'ул. Ярмарочная, 21, Светлоград', '2021-01-01', 5, 58, 1985, 2586.60);

INSERT INTO public.residents (id, full_name, phone) VALUES (1, 'Шевченко Ольга Викторовна', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (2, 'Мазалова Ирина Львовна', '89185647218');
INSERT INTO public.residents (id, full_name, phone) VALUES (3, 'Семеняка Юрий Геннадьевич', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (4, 'Савельев Олег Иванович', '89287815445');
INSERT INTO public.residents (id, full_name, phone) VALUES (5, 'Габиец Игорь Леонидович', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (6, 'Бунин Эдуард Михайлович', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (7, 'Бахшиев Павел Иннокентьевич', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (8, 'Байчорова Агата Рустамовна', '89643324574');
INSERT INTO public.residents (id, full_name, phone) VALUES (9, 'Тюренкова Наталья Сергеевна', '89629987214');
INSERT INTO public.residents (id, full_name, phone) VALUES (10, 'Александров Петр Константинович', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (11, 'Мазалова Ольга Николаевна', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (12, 'Лапшин Виктор Романович', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (13, 'Гусев Семен Петрович', '89188601163');
INSERT INTO public.residents (id, full_name, phone) VALUES (14, 'Гладилина Вера Михайловна', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (15, 'Лукин Илья Федорович', '89634568714');
INSERT INTO public.residents (id, full_name, phone) VALUES (16, 'Петров Станислав Игоревич', '89189187845');
INSERT INTO public.residents (id, full_name, phone) VALUES (17, 'Филь Марина Федоровна', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (18, 'Михайлов Игорь Вадимович', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (19, 'Масюк Динара Викторовна', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (20, 'Мартыненко Александр Сергеевич', '89183215428');
INSERT INTO public.residents (id, full_name, phone) VALUES (21, 'Устьянцева Анна Станиславовна', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (22, 'Антоненко Дмитрий Игоревич', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (23, 'Любяшева Галина Аркадьевна', '89625674581');
INSERT INTO public.residents (id, full_name, phone) VALUES (24, 'Захарящев Денис Сергеевич', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (25, 'Третьяк Ярослава Викторовна', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (26, 'Бондарь Сергей Вадимович', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (27, 'Петраков Артем Сергеевич', null);
INSERT INTO public.residents (id, full_name, phone) VALUES (28, 'Вальке Рита Владимировна', null);

INSERT INTO public.apartments (id, building_id, number) VALUES (1, 18, 1);
INSERT INTO public.apartments (id, building_id, number) VALUES (2, 18, 2);
INSERT INTO public.apartments (id, building_id, number) VALUES (3, 18, 3);
INSERT INTO public.apartments (id, building_id, number) VALUES (4, 18, 4);
INSERT INTO public.apartments (id, building_id, number) VALUES (5, 18, 5);
INSERT INTO public.apartments (id, building_id, number) VALUES (6, 18, 6);
INSERT INTO public.apartments (id, building_id, number) VALUES (7, 18, 7);
INSERT INTO public.apartments (id, building_id, number) VALUES (8, 18, 8);
INSERT INTO public.apartments (id, building_id, number) VALUES (9, 18, 9);
INSERT INTO public.apartments (id, building_id, number) VALUES (10, 18, 10);
INSERT INTO public.apartments (id, building_id, number) VALUES (11, 18, 11);
INSERT INTO public.apartments (id, building_id, number) VALUES (12, 18, 12);
INSERT INTO public.apartments (id, building_id, number) VALUES (13, 18, 13);
INSERT INTO public.apartments (id, building_id, number) VALUES (14, 18, 14);
INSERT INTO public.apartments (id, building_id, number) VALUES (15, 18, 15);
INSERT INTO public.apartments (id, building_id, number) VALUES (16, 18, 16);
INSERT INTO public.apartments (id, building_id, number) VALUES (17, 18, 17);
INSERT INTO public.apartments (id, building_id, number) VALUES (18, 18, 18);
INSERT INTO public.apartments (id, building_id, number) VALUES (19, 18, 19);
INSERT INTO public.apartments (id, building_id, number) VALUES (20, 18, 20);
INSERT INTO public.apartments (id, building_id, number) VALUES (21, 18, 21);
INSERT INTO public.apartments (id, building_id, number) VALUES (22, 18, 22);
INSERT INTO public.apartments (id, building_id, number) VALUES (23, 18, 23);
INSERT INTO public.apartments (id, building_id, number) VALUES (24, 18, 24);
INSERT INTO public.apartments (id, building_id, number) VALUES (25, 18, 25);
INSERT INTO public.apartments (id, building_id, number) VALUES (26, 18, 26);
INSERT INTO public.apartments (id, building_id, number) VALUES (27, 18, 27);
INSERT INTO public.apartments (id, building_id, number) VALUES (28, 18, 28);

INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (1, 1, 1, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (2, 2, 2, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (3, 3, 3, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (4, 4, 4, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (5, 5, 5, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (6, 6, 6, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (7, 7, 7, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (8, 8, 8, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (9, 9, 9, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (10, 10, 10, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (11, 11, 11, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (12, 12, 12, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (13, 13, 13, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (14, 14, 14, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (15, 15, 15, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (16, 16, 16, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (17, 17, 17, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (18, 18, 18, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (19, 19, 19, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (20, 20, 20, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (21, 21, 21, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (22, 22, 22, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (23, 23, 23, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (24, 24, 24, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (25, 25, 25, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (26, 26, 26, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (27, 27, 27, '2025-05-27', null);
INSERT INTO public.apartment_owners (id, apartment_id, resident_id, ownership_start, ownership_end) VALUES (28, 28, 28, '2025-05-27', null);

INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (1, 1, 'Март 2025', 3725.84, 3725.84);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (2, 2, 'Март 2025', 2914.56, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (3, 3, 'Март 2025', 4210.48, 4210.48);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (4, 4, 'Март 2025', 3712.88, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (5, 5, 'Март 2025', 1247.23, 1247.23);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (6, 6, 'Март 2025', 5714.12, 5714.12);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (7, 7, 'Март 2025', 3814.56, 3814.56);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (8, 8, 'Март 2025', 5946.54, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (9, 9, 'Март 2025', 7982.78, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (10, 10, 'Март 2025', 4328.84, 4328.84);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (11, 11, 'Март 2025', 3745.01, 3745.01);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (12, 12, 'Март 2025', 6748.12, 6748.12);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (13, 13, 'Март 2025', 7184.15, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (14, 14, 'Март 2025', 4879.69, 4879.69);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (15, 15, 'Март 2025', 3478.29, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (16, 16, 'Март 2025', 2841.48, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (17, 17, 'Март 2025', 6871.15, 6871.15);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (18, 18, 'Март 2025', 4982.15, 4982.15);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (19, 19, 'Март 2025', 5874.15, 5874.15);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (20, 20, 'Март 2025', 4318.95, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (21, 21, 'Март 2025', 5127.48, 5127.48);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (22, 22, 'Март 2025', 4986.61, 4986.61);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (23, 23, 'Март 2025', 3748.52, 0.00);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (24, 24, 'Март 2025', 8120.45, 8120.45);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (25, 25, 'Март 2025', 1244.67, 1244.67);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (26, 26, 'Март 2025', 5486.45, 5486.45);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (27, 27, 'Март 2025', 2486.98, 2486.98);
INSERT INTO public.payments (id, apartment_id, period, charged, paid) VALUES (28, 28, 'Март 2025', 3475.98, 3475.98);

INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (1, 2, 2455.20, 7541.81, '2025-03-01');
INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (2, 4, 14567.56, 48517.25, '2025-03-01');
INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (3, 8, 178451.00, 257891.10, '2025-03-01');
INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (4, 9, 56.12, 142.35, '2025-03-01');
INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (5, 13, 0.14, null, '2025-03-01');
INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (6, 15, 438.87, 1250.94, '2025-03-01');
INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (7, 16, 7837.45, 18991.79, '2025-03-01');
INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (8, 20, 1.27, 0.84, '2025-03-01');
INSERT INTO public.utility_debts (id, apartment_id, water_debt, electricity_debt, debt_date) VALUES (9, 23, 102.89, 387.58, '2025-03-01');
