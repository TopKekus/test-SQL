-- Запросы для решения тестовых задач

-- 1. Выручка за второй квартал текущего года
SELECT
    SUM(a.an_price) AS revenue
FROM
    Orders o
JOIN
    Analysis a ON o.ord_an = a.an_id
WHERE
    EXTRACT(QUARTER FROM o.ord_datetime) = 2
    AND EXTRACT(YEAR FROM o.ord_datetime) = EXTRACT(YEAR FROM CURRENT_DATE);

-- 2. Количество анализов за последний год
SELECT
    COUNT(*) AS total_analyses
FROM
    Orders
WHERE
    ord_datetime >= CURRENT_DATE - INTERVAL '1 year';

-- 3. Название и цена анализов за август 2023
SELECT
    a.an_name,
    a.an_price
FROM
    Orders o
JOIN
    Analysis a ON o.ord_an = a.an_id
WHERE
    o.ord_datetime BETWEEN '2023-08-01' AND '2023-08-31';

-- 4. Самое популярное время заказа анализов
SELECT
    EXTRACT(HOUR FROM ord_datetime) AS order_hour,
    COUNT(*) AS order_count
FROM
    Orders
GROUP BY
    order_hour
ORDER BY
    order_count DESC
LIMIT 1;

-- 5. Самый популярный температурный режим хранения
SELECT
    g.gr_temp,
    COUNT(*) AS group_count
FROM
    Orders o
JOIN
    Analysis a ON o.ord_an = a.an_id
JOIN
    Groups g ON a.an_group = g.gr_id
GROUP BY
    g.gr_temp
ORDER BY
    group_count DESC
LIMIT 1;

-- 6. Количество повторов групп анализов за последний год
SELECT
    g.gr_name,
    COUNT(*) AS repeat_count
FROM
    Orders o
JOIN
    Analysis a ON o.ord_an = a.an_id
JOIN
    Groups g ON a.an_group = g.gr_id
WHERE
    o.ord_datetime >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY
    g.gr_name;

-- 7. Название и цена анализов, которые продавались с 5 февраля 2023 до конца недели
SELECT
    a.an_name,
    a.an_price
FROM
    Orders o
JOIN
    Analysis a ON o.ord_an = a.an_id
WHERE
    o.ord_datetime BETWEEN '2023-02-05' AND '2023-02-12';
