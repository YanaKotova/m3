WITH rental_hours_per_car AS (
    SELECT
        r.rental_id,
        c.car_id,
        -- ограничим расчёт периодом конкретной даты, например 2025-03-01
        GREATEST(r.actual_start_date, TIMESTAMP '2025-03-01 00:00:00') AS period_start,
        LEAST(COALESCE(r.actual_end_date, NOW()), TIMESTAMP '2025-03-01 23:59:59') AS period_end
    FROM rentals r
    JOIN bookings b ON r.booking_id = b.booking_id
    JOIN cars c ON b.car_id = c.car_id
    WHERE
        -- аренда началась до конца дня и закончилась после начала дня
        r.actual_start_date <= TIMESTAMP '2025-03-01 23:59:59' AND
        COALESCE(r.actual_end_date, NOW()) >= TIMESTAMP '2025-03-01 00:00:00'
),
usage_hours AS (
    SELECT
        car_id,
        EXTRACT(EPOCH FROM (period_end - period_start)) / 3600.0 AS hours_used
    FROM rental_hours_per_car
),
daily_utilization AS (
    SELECT
        car_id,
        ROUND(SUM(hours_used) / 24 * 100, 2) AS utilization_percent
    FROM usage_hours
    GROUP BY car_id
)
SELECT
    c.car_id,
    c.license_plate,
    c.brand,
    c.model,
    COALESCE(d.utilization_percent, 0) AS utilization_percent
FROM cars c
LEFT JOIN daily_utilization d ON c.car_id = d.car_id
ORDER BY utilization_percent DESC;
