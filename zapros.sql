SELECT 
    ROUND(
        COUNT(CASE WHEN p.paid = p.charged THEN 1 END) * 100.0 / 
        COUNT(DISTINCT ao.resident_id), 
    2
    ) AS payment_percentage
FROM 
    payments p
JOIN apartments a ON p.apartment_id = a.id
JOIN buildings b ON a.building_id = b.id
JOIN apartment_owners ao ON a.id = ao.apartment_id
WHERE 
    b.address = 'ул. Матросова, 179а, Светлоград'
    AND p.period = 'Март 2025'
    AND (ao.ownership_end IS NULL OR ao.ownership_end >= CURRENT_DATE);