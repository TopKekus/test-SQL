-- Скрипт для создания структуры базы данных

-- Создание таблицы групп анализов, если она еще не существует
CREATE TABLE IF NOT EXISTS Groups (
    gr_id SERIAL PRIMARY KEY,        -- ID группы
    gr_name VARCHAR(255) NOT NULL,   -- Название группы
    gr_temp VARCHAR(255)             -- Температурный режим хранения
);

-- Создание таблицы анализов, если она еще не существует
CREATE TABLE IF NOT EXISTS Analysis (
    an_id SERIAL PRIMARY KEY,        -- ID анализа
    an_name VARCHAR(255) NOT NULL,   -- Название анализа
    an_cost NUMERIC(10, 2) NOT NULL, -- Себестоимость анализа
    an_price NUMERIC(10, 2) NOT NULL,-- Розничная цена анализа
    an_group INTEGER,                -- Группа анализов (внешний ключ)
    FOREIGN KEY (an_group) REFERENCES Groups(gr_id) -- Внешний ключ и связывание полей, чтобы гарантировать, что анализ относится к существующей группе.
);

-- Создание таблицы заказов, если она еще не существует
CREATE TABLE IF NOT EXISTS Orders (
    ord_id SERIAL PRIMARY KEY,         -- ID заказа
    ord_datetime TIMESTAMP NOT NULL,   -- Дата и время заказа
    ord_an INTEGER NOT NULL,           -- ID анализа (внешний ключ)
    FOREIGN KEY (ord_an) REFERENCES Analysis(an_id) -- Внешний ключ и связывание полей, чтобы гарантировать, что заказы содержат только существующие анализы.
);
