-- Создание таблицы категорий автомобилей
CREATE TABLE car_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Создание таблицы статусов автомобилей
CREATE TABLE car_statuses (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Создание таблицы автомобилей
CREATE TABLE cars (
    car_id SERIAL PRIMARY KEY,
    license_plate VARCHAR(15) NOT NULL UNIQUE,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    category_id INTEGER REFERENCES car_categories(category_id),
    mileage DECIMAL(10, 2) DEFAULT 0,
    status_id INTEGER REFERENCES car_statuses(status_id),
    last_maintenance_date DATE,
    next_maintenance_date DATE
);

-- Создание таблицы клиентов
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    passport_number VARCHAR(50) NOT NULL,
    driver_license VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Создание таблицы сотрудников
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- Создание таблицы типов технического обслуживания
CREATE TABLE maintenance_types (
    maintenance_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    description TEXT,
    average_duration INTERVAL
);

-- Создание таблицы технического обслуживания
CREATE TABLE maintenance (
    maintenance_id SERIAL PRIMARY KEY,
    car_id INTEGER REFERENCES cars(car_id),
    maintenance_type_id INTEGER REFERENCES maintenance_types(maintenance_type_id),
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP,
    employee_id INTEGER REFERENCES employees(employee_id),
    notes TEXT,
    status VARCHAR(50) NOT NULL DEFAULT 'Запланировано'
);

-- Создание таблицы бронирований
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES clients(client_id),
    car_id INTEGER REFERENCES cars(car_id),
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    booking_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    employee_id INTEGER REFERENCES employees(employee_id),
    status VARCHAR(50) NOT NULL DEFAULT 'Подтверждено',
    notes TEXT
);

-- Создание таблицы аренд
CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    booking_id INTEGER REFERENCES bookings(booking_id),
    actual_start_date TIMESTAMP,
    actual_end_date TIMESTAMP,
    initial_mileage DECIMAL(10, 2),
    end_mileage DECIMAL(10, 2),
    fuel_level_start INTEGER,
    fuel_level_end INTEGER,
    employee_start_id INTEGER REFERENCES employees(employee_id),
    employee_end_id INTEGER REFERENCES employees(employee_id),
    status VARCHAR(50) NOT NULL,
    damage_description TEXT,
    additional_charges DECIMAL(10, 2) DEFAULT 0
);

-- Создание таблицы тарифов
CREATE TABLE tariffs (
    tariff_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES car_categories(category_id),
    name VARCHAR(100) NOT NULL,
    rate_per_hour DECIMAL(10, 2) NOT NULL,
    rate_per_day DECIMAL(10, 2) NOT NULL,
    min_rental_period INTERVAL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- Создание таблицы платежей
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    rental_id INTEGER REFERENCES rentals(rental_id),
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(100)
);

-- Вставка статусов автомобилей
INSERT INTO car_statuses (status_name, description) VALUES
('Свободен', 'Автомобиль доступен для аренды'),
('Занят', 'Автомобиль находится в аренде'),
('Неисправен', 'Автомобиль требует ремонта'),
('Назначен к ТО', 'Автомобиль запланирован на техническое обслуживание'),
('Исправен', 'Автомобиль прошел ТО и готов к аренде');

-- Вставка категорий автомобилей
INSERT INTO car_categories (category_name, description) VALUES
('На каждый день', 'Стандартные автомобили для повседневного использования'),
('Праздник', 'Премиальные автомобили для особых случаев'),
('Груз и шаттл', 'Грузовые автомобили и микроавтобусы'),
('Молния', 'Электрокары'),
('Жара', 'Внедорожники для экстремальных условий');

-- Вставка автомобилей
INSERT INTO cars (license_plate, brand, model, category_id, mileage, status_id) VALUES
('м324ст797', 'Geely', 'Coolray Flagship', 1, 34578.0, 1),
('е434ка797', 'Geely', 'Coolray Flagship', 1, 45718.0, 2),
('у831ое77', 'Geely', 'Coolray Flagship', 1, 56122.0, 1),
('с452оо77', 'Renault', 'Duster', 1, 178567.0, 2),
('м674то97', 'Renault', 'Duster', 1, 12478.0, 2),
('е592оу777', 'Renault', 'Duster', 1, 126789.0, 2),
('о553вс797', 'Renault', 'Duster', 1, 45890.0, 1),
('о444ту197', 'Volkswagen', 'Polo 6', 1, 78121.0, 2),
('с591ут97', 'Volkswagen', 'Polo 6', 1, 56477.0, 2),
('в667см97', 'Volkswagen', 'Polo 6', 1, 23045.0, 2),
('в569оо777', 'Volkswagen', 'Polo 6', 1, 40784.0, 1),
('с231оо797', 'Volkswagen', 'Polo 6', 1, 112089.0, 2),
('в583ее77', 'Volkswagen', 'Polo 6', 1, 89014.0, 2),
('о454вс77', 'Mercedes', 'E200', 2, 14875.0, 2),
('е982то97', 'Mercedes', 'E200', 2, 15277.0, 2),
('е337ео777', 'Mercedes', 'E200', 2, 89457.0, 1),
('о123оу777', 'Mercedes', 'C180', 2, 38457.0, 2),
('о093оо97', 'Mercedes', 'C180', 2, 103784.0, 2),
('е772ое777', 'Audi', 'A6', 2, 124561.0, 2),
('о438вм97', 'Ford', 'Transit', 3, 82467.0, 1),
('о127ум97', 'Ford', 'Transit', 3, 98453.0, 1),
('в673со77', 'Peugeot', 'Expert', 3, 123811.0, 2),
('е654аа777', 'Nissan', 'Leaf', 4, 68124.0, 2),
('а676ут797', 'Nissan', 'Leaf', 4, 36489.0, 1),
('т444от777', 'Jeep', 'Sahara', 5, 55012.0, 2);

-- Вставка клиентов (пример)
INSERT INTO clients (first_name, last_name, phone, email, passport_number, driver_license) VALUES
('Иван', 'Иванов', '+79161234567', 'ivanov@example.com', '1234567890', 'AB123456'),
('Петр', 'Петров', '+79169876543', 'petrov@example.com', '0987654321', 'CD654321'),
('Сергей', 'Сергеев', '+79161112233', 'sergeev@example.com', '1122334455', 'EF789012');

-- Вставка сотрудников (пример)
INSERT INTO employees (first_name, last_name, position, phone, email) VALUES
('Алексей', 'Смирнов', 'Администратор', '+79160000001', 'smirnov@carsharing.com'),
('Мария', 'Кузнецова', 'Менеджер', '+79160000002', 'kuznetsova@carsharing.com'),
('Дмитрий', 'Попов', 'Техник', '+79160000003', 'popov@carsharing.com');

-- Вставка типов технического обслуживания
INSERT INTO maintenance_types (type_name, description, average_duration) VALUES
('Регулярное ТО', 'Плановое техническое обслуживание', '2 hours'),
('Замена масла', 'Замена масла и фильтров', '1 hour'),
('Ремонт двигателя', 'Диагностика и ремонт двигателя', '8 hours'),
('Замена шин', 'Смена сезонных шин', '1 hour'),
('Кузовной ремонт', 'Устранение повреждений кузова', '24 hours');

-- Вставка бронирований (пример)
INSERT INTO bookings (client_id, car_id, start_date, end_date, employee_id, status) VALUES
(1, 1, '2025-03-01 10:00:00', '2025-03-05 18:00:00', 1, 'Подтверждено'),
(2, 3, '2025-03-01 09:00:00', '2025-03-04 17:00:00', 1, 'Подтверждено'),
(3, 4, '2025-02-28 14:00:00', '2025-03-02 12:00:00', 1, 'Завершено');

-- Вставка аренд (пример)
INSERT INTO rentals (booking_id, actual_start_date, initial_mileage, employee_start_id, status) VALUES
(1, '2025-03-01 10:15:00', 34578.0, 1, 'Активна'),
(2, '2025-03-01 09:05:00', 56122.0, 1, 'Активна'),
(3, '2025-02-28 14:20:00', 178567.0, 1, 'Завершена');

-- Вставка тарифов
INSERT INTO tariffs (category_id, name, rate_per_hour, rate_per_day, min_rental_period) VALUES
(1, 'Стандарт', 200.00, 1500.00, '1 hour'),
(2, 'Премиум', 500.00, 4000.00, '4 hours'),
(3, 'Грузовой', 300.00, 2500.00, '2 hours'),
(4, 'Электрокар', 250.00, 1800.00, '1 hour'),
(5, 'Внедорожник', 400.00, 3000.00, '3 hours');

-- Вставка платежей (пример)
INSERT INTO payments (rental_id, amount, payment_method, status, transaction_id) VALUES
(1, 6000.00, 'Кредитная карта', 'Оплачено', 'TXN123456'),
(2, 4500.00, 'Наличные', 'Оплачено', 'CASH789012'),
(3, 3000.00, 'Банковский перевод', 'Оплачено', 'BANK345678');