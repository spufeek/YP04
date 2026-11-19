CREATE DATABASE HelpDesk_Golubenko;
GO

USE HelpDesk_Golubenko;
GO

CREATE TABLE Roles
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Categories
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Priorities
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE,
    SortOrder INT NOT NULL
);
GO

CREATE TABLE Statuses
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Users
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Login NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(150) NOT NULL,
    RoleId INT NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Users_Roles
        FOREIGN KEY (RoleId) REFERENCES Roles(Id)
);
GO

CREATE TABLE Tickets
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    CategoryId INT NOT NULL,
    Description NVARCHAR(1000) NOT NULL,
    PriorityId INT NOT NULL,
    StatusId INT NOT NULL,
    AssignedUserId INT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    UpdatedAt DATETIME2 NULL,

    CONSTRAINT FK_Tickets_Users
        FOREIGN KEY (UserId) REFERENCES Users(Id),
    CONSTRAINT FK_Tickets_Categories
        FOREIGN KEY (CategoryId) REFERENCES Categories(Id),
    CONSTRAINT FK_Tickets_Priorities
        FOREIGN KEY (PriorityId) REFERENCES Priorities(Id),
    CONSTRAINT FK_Tickets_Statuses
        FOREIGN KEY (StatusId) REFERENCES Statuses(Id),
    CONSTRAINT FK_Tickets_AssignedUser
        FOREIGN KEY (AssignedUserId) REFERENCES Users(Id)
);
GO

INSERT INTO Roles (Name)
VALUES
(N'Пользователь'),
(N'Специалист'),
(N'Администратор');
GO

SELECT * FROM Roles;

INSERT INTO Categories (Name)
VALUES
(N'Оборудование'),
(N'Программное обеспечение'),
(N'Сеть'),
(N'Учётная запись'),
(N'Периферия'),
(N'Другое');
GO

SELECT * FROM Categories;

INSERT INTO Priorities (Name, SortOrder)
VALUES
(N'Низкий', 1),
(N'Средний', 2),
(N'Высокий', 3);
GO

SELECT * FROM Priorities ORDER BY SortOrder;

INSERT INTO Statuses (Name)
VALUES
(N'Новая'),
(N'В работе'),
(N'Выполнена'),
(N'Отклонена');
GO

SELECT * FROM Statuses;

INSERT INTO Users
    (Login, PasswordHash, FullName, RoleId, IsActive)
VALUES
    (N'admin', N'TEMP_ADMIN', N'Администратор системы', 3, 1),
    (N'support1', N'TEMP_SUPPORT', N'Специалист технической поддержки', 2, 1),
    (N'user1', N'TEMP_USER', N'Тестовый пользователь', 1, 1);
GO

SELECT Id, Login, FullName, RoleId, IsActive
FROM Users;

INSERT INTO Tickets
    (UserId, CategoryId, Description, PriorityId, StatusId, AssignedUserId)
VALUES
    (3, 3, N'Нет доступа в Интернет', 3, 1, NULL),
    (3, 2, N'Не запускается Microsoft Word', 2, 2, 2),
    (3, 1, N'Не включается компьютер', 3, 2, 2),
    (3, 5, N'Не работает принтер', 2, 1, NULL),
    (3, 4, N'Не удаётся войти в учётную запись', 3, 4, 2);
GO

SELECT * FROM Tickets;

SELECT
    t.Id,
    u.FullName AS [Пользователь],
    c.Name AS [Категория],
    t.Description AS [Описание],
    p.Name AS [Приоритет],
    s.Name AS [Статус],
    t.CreatedAt AS [Дата создания]
FROM Tickets AS t
INNER JOIN Users AS u ON t.UserId = u.Id
INNER JOIN Categories AS c ON t.CategoryId = c.Id
INNER JOIN Priorities AS p ON t.PriorityId = p.Id
INNER JOIN Statuses AS s ON t.StatusId = s.Id;

