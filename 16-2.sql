SELECT * FROM Documents
WHERE CONTAINS(Content, 'поиск');

SELECT * FROM Documents
WHERE CONTAINS(Content, '"админ*"');

SELECT * FROM Documents
WHERE CONTAINS(Content, '"резервное копирование"');

SELECT * FROM Documents
WHERE CONTAINS(Content, 'SQL AND базы');

SELECT * FROM Documents
WHERE CONTAINS(Content, 'индексы OR оптимизаци€');

SELECT * FROM Documents
WHERE CONTAINS(Content, 'SQL AND NOT руководство');

SELECT * FROM Documents
WHERE CONTAINS(Content, 'NEAR(базы, данных)');

SELECT * FROM Documents
WHERE CONTAINS(Content, 'NEAR((базы, данных), 10)');

SELECT * FROM Documents
WHERE CONTAINS(Content, 'FORMSOF(INFLECTIONAL, предоставл€ть)');

SELECT * FROM Documents
WHERE CONTAINS(Content, 'FORMSOF(THESAURUS, мощный)');

SELECT 
    DocumentID,
    Title,
    Author,
    CASE 
        WHEN CONTAINS(Content, '"резервное копирование"') THEN '¬ысокий приоритет'
        WHEN CONTAINS(Content, 'NEAR((SQL, Server), 5)') THEN '—редний приоритет'
        ELSE 'Ќизкий приоритет'
    END AS SearchPriority
FROM Documents
WHERE CONTAINS(Content, 
    '("резервное копирование" OR FORMSOF(INFLECTIONAL, оптимизировать) OR NEAR((база, данных), 3))');

SELECT * FROM Documents
WHERE FREETEXT(Content, 'поиск информации в тексте');

SELECT 
    d.DocumentID,
    d.Title,
    d.Author,
    k.RANK
FROM Documents d
INNER JOIN CONTAINSTABLE(Documents, Content, 'базы данных', 10) AS k
    ON d.DocumentID = k.[KEY]
ORDER BY k.RANK DESC;

SELECT * FROM Documents
WHERE CONTAINS(Content, 
    'ISABOUT (оптимизаци€ WEIGHT(0.9), индексы WEIGHT(0.7), данные WEIGHT(0.5))');