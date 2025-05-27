CREATE TABLE owners (
    owner_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE properties (
    property_id SERIAL PRIMARY KEY,
    address TEXT NOT NULL,
    owner_id INTEGER REFERENCES owners(owner_id),
    category VARCHAR(50) NOT NULL
);

CREATE TABLE property_statuses (
    status_id SERIAL PRIMARY KEY,
    property_id INTEGER REFERENCES properties(property_id),
    status VARCHAR(20) NOT NULL CHECK (status IN ('Свободен', 'Занят', 'Грязный', 'Назначен к уборке', 'Чистый')),
    status_date DATE NOT NULL,
    departure_date DATE
);

CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES clients(client_id),
    property_id INTEGER REFERENCES properties(property_id),
    category VARCHAR(50),
    start_date DATE NOT NULL,
    end_date DATE,
    amount NUMERIC(12,2) NOT NULL,
    paid_amount NUMERIC(12,2) DEFAULT 0
);

CREATE TABLE cleaning_staff (
    staff_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE cleaning_schedule (
    schedule_id SERIAL PRIMARY KEY,
    property_id INTEGER REFERENCES properties(property_id),
    staff_id INTEGER REFERENCES cleaning_staff(staff_id),
    scheduled_date DATE NOT NULL,
    completed BOOLEAN DEFAULT FALSE
);

INSERT INTO public.owners (owner_id, full_name, phone) VALUES (1, 'Шевченко Ольга Викторовна', '89287878123');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (2, 'Мазалова Ирина Львовна', '89185647218');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (3, 'Семеняка Юрий Геннадьевич', '89684512323');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (4, 'Савельев Олег Иванович', '89287815445');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (5, 'Габиец Игорь Леонидович', '89185548899');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (6, 'Бунин Эдуард Михайлович', '89623124785');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (7, 'Бахшиев Павел Иннокентьевич', '89286682661');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (8, 'Байчорова Агата Рустамовна', '89643324574');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (9, 'Тюренкова Наталья Сергеевна', '89629987214');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (10, 'Александров Петр Константинович', '89187575654');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (11, 'Мазалова Ольга Николаевна', '89183269681');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (12, 'Лапшин Виктор Романович', '89180070523');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (13, 'Гусев Семен Петрович', '89188601163');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (14, 'Гладилина Вера Михайловна', '89629659651');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (15, 'Лукин Илья Федорович', '89634568714');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (16, 'Петров Станислав Игоревич', '89189187845');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (17, 'Филь Марина Федоровна', '89694545788');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (18, 'Михайлов Игорь Вадимович', '879845755');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (19, 'Масюк Динара Викторовна', '89567124523');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (20, 'Мартыненко Александр Сергеевич', '89183215428');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (21, 'Устьянцева Анна Станиславовна', '89387511119');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (22, 'Антоненко Дмитрий Игоревич', '89014674141');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (23, 'Любяшева Галина Аркадьевна', '89625674581');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (24, 'Захарящев Денис Сергеевич', '89282783331');
INSERT INTO public.owners (owner_id, full_name, phone) VALUES (25, 'Третьяк Ярослава Викторовна', '89186689458');

INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (1, 'улица Гагарина, дом 23, кв. 14', 1, 'Квартира 2-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (2, '4-й Парковый проезд, дом 45, кв. 67', 2, 'Квартира 2-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (3, 'Цветочная улица, дом 51, кв. 48', 3, 'Квартира 2-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (4, 'улица Талалихина, дом 49, кв. 44', 4, 'Квартира 2-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (5, 'улица Ивана Франко, дом 41, кв. 72', 5, 'Квартира 2-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (6, 'Изумрудная улица, дом 56, кв. 3', 6, 'Квартира 2-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (7, 'улица 8-го Марта, дом 5, кв. 11', 7, 'Квартира 3-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (8, 'Фестивальная улица, дом 34, кв. 78', 8, 'Квартира 3-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (9, 'Яблоневая улица, дом 1, квартира 134', 9, 'Квартира 3-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (10, 'улица Гайдара, дом 16, кв. 45', 10, 'Квартира 3-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (11, 'улица Гагарина, дом 78, кв. 22', 11, 'Квартира 3-комнатная');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (12, 'Ударная улица, дом 2', 12, 'Частное домовладение');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (13, 'Хвойная улица, дом 7', 13, 'Частное домовладение');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (14, 'Сабуровская улица, дом 3', 14, 'Частное домовладение');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (15, 'Фестивальная улица, дом 17', 15, 'Частное домовладение');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (16, 'Юбилейная улица, дом 23, оф. 4', 16, 'Офис бюджет');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (17, 'Набережная улица, дом 19, оф. 3', 17, 'Офис стандарт');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (18, 'улица Максима Горького, дом 36, оф. 12', 18, 'Офис стандарт');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (19, 'улица Максима Горького, дом 36, оф. 5', 19, 'Офис стандарт');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (20, 'улица Желобинского, дом 29, оф. 52', 20, 'Офис стандарт');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (21, 'Вагоностроительная улица, дом 61', 21, 'Офис стандарт');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (22, 'улица Щорса, строение 12', 22, 'Офис премиум');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (23, 'Фабричная улица, строение 22', 23, 'Склад');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (24, 'СНТ "Зоотехник", участок 66', 24, 'Садовый участок');
INSERT INTO public.properties (property_id, address, owner_id, category) VALUES (25, 'Панфиловский проезд, дом 1', 25, 'Загородный дом');

INSERT INTO public.clients (client_id, full_name, phone) VALUES (1, 'Александров Петр Константинович', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (2, 'Антоненко Дмитрий Игоревич', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (3, 'Байчорова Агата Рустамовна', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (4, 'Бахшиев Павел Иннокентьевич', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (5, 'Бунин Эдуард Михайлович', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (6, 'Габиец Игорь Леонидович', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (7, 'Гладилина Вера Михайловна', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (8, 'Гусев Семен Петрович', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (9, 'Захарящев Денис Сергеевич', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (10, 'Лапшин Виктор Романович', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (11, 'Лукин Илья Федорович', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (12, 'Любяшева Галина Аркадьевна', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (13, 'Мазалова Ирина Львовна', null);
INSERT INTO public.clients (client_id, full_name, phone) VALUES (14, 'Мазалова Ольга Николаевна', null);

INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (1, 1, 2, 'Квартира 2-комнатная', '2025-01-14', '2025-08-02', 15000.00, 0.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (2, 2, 22, 'Квартира 2-комнатная', '2024-12-12', '2026-09-01', 18200.00, 0.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (3, 3, 5, 'Квартира 2-комнатная', '2025-02-01', '2025-12-01', 14500.00, 14500.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (4, 4, 6, 'Квартира 2-комнатная', '2025-01-24', '2025-12-31', 17000.00, 17000.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (5, 5, 7, 'Квартира 3-комнатная', '2024-11-27', '2025-12-17', 24500.00, 0.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (6, 6, 8, 'Квартира 3-комнатная', '2025-02-01', '2026-03-20', 28000.00, 0.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (7, 7, 10, 'Квартира 3-комнатная', '2024-12-02', '2026-01-31', 32100.00, 32100.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (8, 8, 12, 'Частное домовладение', '2025-02-28', '2025-03-17', 11300.00, 0.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (9, 9, 17, 'Офис стандарт', '2025-01-04', null, 26000.00, 26000.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (10, 10, 18, 'Офис стандарт', '2024-11-10', '2026-03-15', 14000.00, 14000.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (11, 11, 19, 'Офис стандарт', '2024-10-01', '2025-03-15', 25200.00, 25200.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (12, 12, 21, 'Офис стандарт', '2025-02-27', '2026-02-18', 32400.00, 0.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (13, 13, 22, 'Офис премиум', '2025-02-28', null, 248750.00, 248750.00);
INSERT INTO public.rentals (rental_id, client_id, property_id, category, start_date, end_date, amount, paid_amount) VALUES (14, 14, 23, 'Склад', '2022-09-01', '2025-05-11', 112000.00, 0.00);

