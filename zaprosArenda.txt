WITH
-- считаем суммарные арендованные дни за 2025 год
rental_days AS (
  SELECT
    SUM(
      LEAST(COALESCE(end_date, '2025-12-31'), '2025-12-31') - GREATEST(start_date, '2025-01-01') + 1
    ) AS total_rented_days
  FROM rentals
  WHERE start_date <= '2025-12-31' AND (end_date IS NULL OR end_date >= '2025-01-01')
),

-- считаем общее количество помещений
total_properties AS (
  SELECT COUNT(*) AS count FROM properties
)

SELECT
  ROUND(
    (rental_days.total_rented_days::numeric / (365 * total_properties.count)) * 100,
    2
  ) AS occupancy_percent
FROM rental_days, total_properties;
