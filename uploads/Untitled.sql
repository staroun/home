CREATE TABLE [Members] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [email] nvarchar(255) UNIQUE NOT NULL,
  [password] nvarchar(255),
  [address] text,
  [phone] nvarchar(255),
  [created_at] datetime
)
GO

CREATE TABLE [Admins] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [email] nvarchar(255) UNIQUE NOT NULL,
  [password] nvarchar(255),
  [role] nvarchar(255),
  [created_at] datetime
)
GO

CREATE TABLE [Categories] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL,
  [description] text,
  [parent_id] int
)
GO

CREATE TABLE [Books] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [title] nvarchar(255) NOT NULL,
  [author] nvarchar(255),
  [description] text,
  [price] decimal(10,2),
  [stock] int,
  [category_id] int,
  [published_date] date,
  [created_at] datetime
)
GO

CREATE TABLE [Orders] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [member_id] int,
  [total_amount] decimal(10,2),
  [order_date] datetime,
  [status] nvarchar(255),
  [shipping_address] text
)
GO

CREATE TABLE [OrderItems] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [order_id] int,
  [book_id] int,
  [quantity] int,
  [price] decimal(10,2)
)
GO

CREATE TABLE [Boards] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [type] nvarchar(255) NOT NULL,
  [title] nvarchar(255) NOT NULL,
  [content] text,
  [created_at] datetime,
  [member_id] int,
  [admin_id] int,
  [book_id] int,
  [status] nvarchar(255),
  [answer] text,
  [answered_at] datetime,
  [is_pinned] boolean DEFAULT (false)
)
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Self-referencing for subcategories',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Categories',
@level2type = N'Column', @level2name = 'parent_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'QNA, ANNOUNCEMENT, REVIEW',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Boards',
@level2type = N'Column', @level2name = 'type';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Author of the post',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Boards',
@level2type = N'Column', @level2name = 'member_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Only used for ANNOUNCEMENT',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Boards',
@level2type = N'Column', @level2name = 'admin_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Only used for REVIEW',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Boards',
@level2type = N'Column', @level2name = 'book_id';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'For QNA: open, answered, closed',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Boards',
@level2type = N'Column', @level2name = 'status';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'For QNA only',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Boards',
@level2type = N'Column', @level2name = 'answer';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'For ANNOUNCEMENT only',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Boards',
@level2type = N'Column', @level2name = 'is_pinned';
GO

ALTER TABLE [Categories] ADD FOREIGN KEY ([parent_id]) REFERENCES [Categories] ([id])
GO

ALTER TABLE [Books] ADD FOREIGN KEY ([category_id]) REFERENCES [Categories] ([id])
GO

ALTER TABLE [Orders] ADD FOREIGN KEY ([member_id]) REFERENCES [Members] ([id])
GO

ALTER TABLE [OrderItems] ADD FOREIGN KEY ([order_id]) REFERENCES [Orders] ([id])
GO

ALTER TABLE [OrderItems] ADD FOREIGN KEY ([book_id]) REFERENCES [Books] ([id])
GO

ALTER TABLE [Boards] ADD FOREIGN KEY ([member_id]) REFERENCES [Members] ([id])
GO

ALTER TABLE [Boards] ADD FOREIGN KEY ([admin_id]) REFERENCES [Admins] ([id])
GO

ALTER TABLE [Boards] ADD FOREIGN KEY ([book_id]) REFERENCES [Books] ([id])
GO
