GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "mig"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[__MigrationHistory]...';


GO
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId]    NVARCHAR (150)  NOT NULL,
    [ContextKey]     NVARCHAR (300)  NOT NULL,
    [Model]          VARBINARY (MAX) NOT NULL,
    [ProductVersion] NVARCHAR (32)   NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED ([MigrationId] ASC, [ContextKey] ASC)
);


GO
PRINT N'Creating [dbo].[Archivos]...';


GO
CREATE TABLE [dbo].[Archivos] (
    [Id]       INT          IDENTITY (1, 1) NOT NULL,
    [Filename] VARCHAR (50) NOT NULL,
    [TicketId] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetRoles]...';


GO
CREATE TABLE [dbo].[AspNetRoles] (
    [Id]   NVARCHAR (128) NOT NULL,
    [Name] NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetRoles].[RoleNameIndex]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex]
    ON [dbo].[AspNetRoles]([Name] ASC);


GO
PRINT N'Creating [dbo].[AspNetUserClaims]...';


GO
CREATE TABLE [dbo].[AspNetUserClaims] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [UserId]     NVARCHAR (128) NOT NULL,
    [ClaimType]  NVARCHAR (MAX) NULL,
    [ClaimValue] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetUserClaims].[IX_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserClaims]([UserId] ASC);


GO
PRINT N'Creating [dbo].[AspNetUserLogins]...';


GO
CREATE TABLE [dbo].[AspNetUserLogins] (
    [LoginProvider] NVARCHAR (128) NOT NULL,
    [ProviderKey]   NVARCHAR (128) NOT NULL,
    [UserId]        NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC, [UserId] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetUserLogins].[IX_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserLogins]([UserId] ASC);


GO
PRINT N'Creating [dbo].[AspNetUserRoles]...';


GO
CREATE TABLE [dbo].[AspNetUserRoles] (
    [UserId] NVARCHAR (128) NOT NULL,
    [RoleId] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetUserRoles].[IX_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserRoles]([UserId] ASC);


GO
PRINT N'Creating [dbo].[AspNetUserRoles].[IX_RoleId]...';


GO
CREATE NONCLUSTERED INDEX [IX_RoleId]
    ON [dbo].[AspNetUserRoles]([RoleId] ASC);


GO
PRINT N'Creating [dbo].[AspNetUsers]...';


GO
CREATE TABLE [dbo].[AspNetUsers] (
    [Id]                   NVARCHAR (128) NOT NULL,
    [Email]                NVARCHAR (256) NULL,
    [EmailConfirmed]       BIT            NOT NULL,
    [PasswordHash]         NVARCHAR (MAX) NULL,
    [SecurityStamp]        NVARCHAR (MAX) NULL,
    [PhoneNumber]          NVARCHAR (MAX) NULL,
    [PhoneNumberConfirmed] BIT            NOT NULL,
    [TwoFactorEnabled]     BIT            NOT NULL,
    [LockoutEndDateUtc]    DATETIME       NULL,
    [LockoutEnabled]       BIT            NOT NULL,
    [AccessFailedCount]    INT            NOT NULL,
    [UserName]             NVARCHAR (256) NOT NULL,
    [Departamento_Id]      INT            NULL,
    CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetUsers].[UserNameIndex]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex]
    ON [dbo].[AspNetUsers]([UserName] ASC);


GO
PRINT N'Creating [dbo].[Departamentos]...';


GO
CREATE TABLE [dbo].[Departamentos] (
    [Id]    INT            IDENTITY (1, 1) NOT NULL,
    [Depto] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Departamentos] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[DepartamentoTIs]...';


GO
CREATE TABLE [dbo].[DepartamentoTIs] (
    [Id]      INT            IDENTITY (1, 1) NOT NULL,
    [DeptoTI] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_DepartamentoTIs] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Estatus]...';


GO
CREATE TABLE [dbo].[Estatus] (
    [Id]     INT            IDENTITY (1, 1) NOT NULL,
    [Estado] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Estatus] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[FollowTables]...';


GO
CREATE TABLE [dbo].[FollowTables] (
    [ID]     INT            IDENTITY (1, 1) NOT NULL,
    [Who]    NVARCHAR (128) NOT NULL,
    [Follow] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_FollowTables] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[Tickets]...';


GO
CREATE TABLE [dbo].[Tickets] (
    [Id]                    INT            IDENTITY (1, 1) NOT NULL,
    [OwnerID]               NVARCHAR (128) NOT NULL,
    [Titulo]                NVARCHAR (MAX) NOT NULL,
    [Descripcion]           NVARCHAR (MAX) NOT NULL,
    [Date_added]            DATETIME       NOT NULL,
    [Date_solved]           DATETIME       NULL,
    [Asig_id]               NVARCHAR (128) NULL,
    [Estatus_ID]            INT            NOT NULL,
    [DepartamentoPertenece] INT            NULL,
    CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Tickets]...';


GO
ALTER TABLE [dbo].[Tickets]
    ADD DEFAULT (sysdatetime()) FOR [Date_added];


GO
PRINT N'Creating [dbo].[FK_Table_Tickets]...';


GO
ALTER TABLE [dbo].[Archivos] WITH NOCHECK
    ADD CONSTRAINT [FK_Table_Tickets] FOREIGN KEY ([TicketId]) REFERENCES [dbo].[Tickets] ([Id]);


GO
PRINT N'Creating [dbo].[FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]...';


GO
ALTER TABLE [dbo].[AspNetUserClaims] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]...';


GO
ALTER TABLE [dbo].[AspNetUserLogins] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]...';


GO
ALTER TABLE [dbo].[AspNetUserRoles] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]...';


GO
ALTER TABLE [dbo].[AspNetUserRoles] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_AspNetUsers_Depto]...';


GO
ALTER TABLE [dbo].[AspNetUsers] WITH NOCHECK
    ADD CONSTRAINT [FK_AspNetUsers_Depto] FOREIGN KEY ([Departamento_Id]) REFERENCES [dbo].[Departamentos] ([Id]);


GO
PRINT N'Creating [dbo].[FK_FollowTables_who]...';


GO
ALTER TABLE [dbo].[FollowTables] WITH NOCHECK
    ADD CONSTRAINT [FK_FollowTables_who] FOREIGN KEY ([Who]) REFERENCES [dbo].[AspNetUsers] ([Id]);


GO
PRINT N'Creating [dbo].[FK_FollowTables_Follow]...';


GO
ALTER TABLE [dbo].[FollowTables] WITH NOCHECK
    ADD CONSTRAINT [FK_FollowTables_Follow] FOREIGN KEY ([Follow]) REFERENCES [dbo].[AspNetUsers] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Tickets_DeptoTi]...';


GO
ALTER TABLE [dbo].[Tickets] WITH NOCHECK
    ADD CONSTRAINT [FK_Tickets_DeptoTi] FOREIGN KEY ([DepartamentoPertenece]) REFERENCES [dbo].[DepartamentoTIs] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Tickets_Estatus]...';


GO
ALTER TABLE [dbo].[Tickets] WITH NOCHECK
    ADD CONSTRAINT [FK_Tickets_Estatus] FOREIGN KEY ([Estatus_ID]) REFERENCES [dbo].[Estatus] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Tickets_Owner]...';


GO
ALTER TABLE [dbo].[Tickets] WITH NOCHECK
    ADD CONSTRAINT [FK_Tickets_Owner] FOREIGN KEY ([OwnerID]) REFERENCES [dbo].[AspNetUsers] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Tickets_Asigned]...';


GO
ALTER TABLE [dbo].[Tickets] WITH NOCHECK
    ADD CONSTRAINT [FK_Tickets_Asigned] FOREIGN KEY ([Asig_id]) REFERENCES [dbo].[AspNetUsers] ([Id]);


GO
PRINT N'Creating [dbo].[rep_dept_ti]...';


GO
CREATE VIEW [dbo].[rep_dept_ti]
	AS select count(t.id) Cantidad, dti.deptoti 
		 from departamentoTIs dti
		 join tickets t on t.DepartamentoPertenece = dti.id
	 GROUP BY deptoti;
GO
PRINT N'Creating [dbo].[rep_por_depto]...';


GO
CREATE VIEW [dbo].[rep_por_depto]
	AS select count(t.id) as cantidad, depto 
	     from AspNetUsers u
		 join tickets t on u.id = t.ownerid
		 join departamentos d on d.id = u.departamento_id
	 group by depto;
GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Archivos] WITH CHECK CHECK CONSTRAINT [FK_Table_Tickets];

ALTER TABLE [dbo].[AspNetUserClaims] WITH CHECK CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId];

ALTER TABLE [dbo].[AspNetUserLogins] WITH CHECK CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId];

ALTER TABLE [dbo].[AspNetUserRoles] WITH CHECK CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId];

ALTER TABLE [dbo].[AspNetUserRoles] WITH CHECK CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId];

ALTER TABLE [dbo].[AspNetUsers] WITH CHECK CHECK CONSTRAINT [FK_AspNetUsers_Depto];

ALTER TABLE [dbo].[FollowTables] WITH CHECK CHECK CONSTRAINT [FK_FollowTables_who];

ALTER TABLE [dbo].[FollowTables] WITH CHECK CHECK CONSTRAINT [FK_FollowTables_Follow];

ALTER TABLE [dbo].[Tickets] WITH CHECK CHECK CONSTRAINT [FK_Tickets_DeptoTi];

ALTER TABLE [dbo].[Tickets] WITH CHECK CHECK CONSTRAINT [FK_Tickets_Estatus];

ALTER TABLE [dbo].[Tickets] WITH CHECK CHECK CONSTRAINT [FK_Tickets_Owner];

ALTER TABLE [dbo].[Tickets] WITH CHECK CHECK CONSTRAINT [FK_Tickets_Asigned];


GO
PRINT N'Update complete.';


GO
