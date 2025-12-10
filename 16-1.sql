SELECT FULLTEXTSERVICEPROPERTY('IsFullTextInstalled') AS IsFullTextInstalled;

CREATE TABLE Documents (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200),
    Content NVARCHAR(MAX),
    Author NVARCHAR(100),
    CreatedDate DATETIME DEFAULT GETDATE()
);

INSERT INTO Documents (Title, Content, Author) VALUES
('Руководство по SQL Server', 'SQL Server предоставляет мощные средства для работы с базами данных', 'Иванов И.И.'),
('Оптимизация запросов', 'Использование индексов значительно ускоряет выполнение запросов', 'Петров П.П.'),
('Администрирование баз данных', 'Резервное копирование и восстановление данных - важные задачи администрирования', 'Сидоров С.С.'),
('Полнотекстовый поиск в SQL', 'Full-Text Search позволяет искать слова и фразы в текстовых полях', 'Иванов И.И.');

CREATE FULLTEXT CATALOG ftCatalog AS DEFAULT;

CREATE FULLTEXT INDEX ON Documents (
    Title LANGUAGE Russian,
    Content LANGUAGE Russian,
    Author LANGUAGE Russian
)
KEY INDEX PK__Documents__DocumentID
ON ftCatalog
WITH CHANGE_TRACKING AUTO;

SELECT * FROM Documents
WHERE CONTAINS((Title, Content, Author), 'SQL');

SELECT 
    DocumentID,
    Title,
    Content,
    Author
FROM Documents
WHERE CONTAINS((Title, Content), 
    'ISABOUT (SQL WEIGHT(0.8), оптимизация WEIGHT(0.6), базы* WEIGHT(0.4))');

SELECT * FROM Documents
WHERE CONTAINS(Title, 'SQL') 
   OR CONTAINS(Content, 'индексы')
   OR CONTAINS(Author, 'Иванов');