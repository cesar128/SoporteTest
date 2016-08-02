/*
This script performs its actions in the following order:
1. Disable foreign-key constraints.
2. Perform DELETE commands. 
3. Perform UPDATE commands.
4. Perform INSERT commands.
5. Re-enable foreign-key constraints.
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @pv binary(16)
BEGIN TRANSACTION
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
ALTER TABLE [dbo].[FollowTables] DROP CONSTRAINT [FK_FollowTables_who]
ALTER TABLE [dbo].[FollowTables] DROP CONSTRAINT [FK_FollowTables_Follow]
ALTER TABLE [dbo].[AspNetUsers] DROP CONSTRAINT [FK_AspNetUsers_Depto]
ALTER TABLE [dbo].[Archivos] DROP CONSTRAINT [FK_Table_Tickets]
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_Tickets_DeptoTi]
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_Tickets_Estatus]
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_Tickets_Owner]
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_Tickets_Asigned]
SET IDENTITY_INSERT [dbo].[Tickets] ON
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (5, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'1234', N'1234hikvfgydf', '20160731 22:16:39.083', NULL, N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 2, 1)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (6, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'No puedo acceder a mi pc', N'Cuando intento entrar no puedo porque no se que pasa.', '20160731 22:17:20.000', NULL, N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 1, 3)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (7, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'11144', N'dsaf-lghsdfg', '20160731 17:52:58.000', '20160802 04:08:42.623', N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 3, 2)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (8, N'332ac4c9-d37e-48fe-9075-a5e474877456', N'Prueba del cliente 2', N'esto es un texto muy largo para llenar la descripcion m', '20160801 18:08:49.000', '20160802 04:08:28.297', N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 3, 1)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (9, N'ad795f49-71ab-4737-80f3-ab420224dfcf', N'Cliente 3 reporta alfo', N'Nadie sabe lo que reporta pero es algo muy urgente', '20160731 20:37:08.000', '20160802 04:08:10.483', N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 3, 1)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (10, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'subida', N'dubida', '20160731 23:20:16.233', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (11, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'aadf', N'fdfsafff', '20160731 23:24:46.977', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (13, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'Peurba Archivo', N'asdlllabc', '20160731 23:40:48.000', NULL, N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 1, 1)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (14, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'fdsa', N'fdaasdf', '20160731 23:50:29.000', '20160802 04:09:36.437', N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 3, 1)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (15, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'fggd', N'gss', '20160731 23:54:09.397', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (16, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'Imagen 2', N'Imagen 2', '20160731 23:55:16.000', '20160802 04:09:25.617', N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 3, 1)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (17, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'Prueba 5478', N'Ahora estoy probando para que me de el id del vaina pa cambiar el archivo', '20160801 00:02:54.130', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (18, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'qwe123', N'ggsssdf', '20160801 00:08:29.857', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (19, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'relaciones sin hora', N'de archivos y tickets', '20160801 00:16:39.000', NULL, N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 2, 1)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (20, N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'Esta tiene foto adjunta', N'sdfs444554', '20160801 00:23:23.000', NULL, N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', 1, 1)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (21, N'332ac4c9-d37e-48fe-9075-a5e474877456', N'4324', N'ffffsdf', '20160801 16:51:46.397', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (22, N'332ac4c9-d37e-48fe-9075-a5e474877456', N'4324', N'hffyfy', '20160801 16:56:13.330', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (23, N'332ac4c9-d37e-48fe-9075-a5e474877456', N'54352', N'52345', '20160801 17:01:26.177', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (24, N'332ac4c9-d37e-48fe-9075-a5e474877456', N'3456789', N'sdfghjkl', '20160801 17:58:28.840', NULL, NULL, 1, NULL)
INSERT INTO [dbo].[Tickets] ([Id], [OwnerID], [Titulo], [Descripcion], [Date_added], [Date_solved], [Asig_id], [Estatus_ID], [DepartamentoPertenece]) VALUES (25, N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', N'Tal cosa', N'Para probar.', '20160801 22:54:36.697', NULL, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Tickets] OFF
SET IDENTITY_INSERT [dbo].[Archivos] ON
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (1, N'19corbata.jpg', 19)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (2, N'20inv.png', 20)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (3, N'23Koala.jpg', 23)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (4, N'23Lighthouse.jpg', 23)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (5, N'23Penguins.jpg', 23)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (6, N'23Tulips.jpg', 23)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (7, N'24Chrysanthemum.jpg', 24)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (8, N'24Desert.jpg', 24)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (9, N'24Hydrangeas.jpg', 24)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (10, N'25individual.jpg', 25)
INSERT INTO [dbo].[Archivos] ([Id], [Filename], [TicketId]) VALUES (11, N'25inv.png', 25)
SET IDENTITY_INSERT [dbo].[Archivos] OFF
INSERT INTO [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Departamento_Id]) VALUES (N'27846bf5-e99a-47ce-bdf3-2a6ae98e5f42', N'cliente1@cliente.com', 0, N'AClk0DpgsX1ldYPhhYndnJ+YRxgPZUPmL9/6BaK2Q2/OCZu+ulIbfwA2FwQl886gFg==', N'f43d97d0-3d15-4fcd-acf5-50339bac4551', NULL, 0, 0, NULL, 1, 0, N'cliente1@cliente.com', 1)
INSERT INTO [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Departamento_Id]) VALUES (N'2dd90471-d571-4119-b9fa-6c2ff0f5d5db', N'cliente5@cliente.com', 0, N'AHj+VyG+oYZWpMfNwOdyrOT32dKJZYwmv2GncFTpWOvz8jza82nvwPCNfzjFYZuuvw==', N'e8a154f7-21a1-43b3-b47a-ee92cea9eb41', NULL, 0, 0, NULL, 1, 0, N'cliente5@cliente.com', 2)
INSERT INTO [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Departamento_Id]) VALUES (N'332ac4c9-d37e-48fe-9075-a5e474877456', N'cliente2@cliente.com', 0, N'ANVlYKExQkHamIC+VKVSgtBPqX4ypzn82WSChzVKnddL5ioweeRdqFpkNwB4u0mn3w==', N'cad3aa23-f93d-4965-9ff3-21b5c4e2c651', NULL, 0, 0, NULL, 1, 0, N'cliente2@cliente.com', 2)
INSERT INTO [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Departamento_Id]) VALUES (N'97d36e88-a074-4602-8abe-ee94b230b9d4', N'cliente4@cliente.com', 0, N'AEFkh4pG5MAL4yLpU4AGw7UfUExqDenwEY8dg8x9zUm780BIFTxt/HLDmYjSLtr+pA==', N'222e57cb-3ea1-4508-ad0a-01ea1c4d6469', NULL, 0, 0, NULL, 1, 0, N'cliente4@cliente.com', 1)
INSERT INTO [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Departamento_Id]) VALUES (N'ad795f49-71ab-4737-80f3-ab420224dfcf', N'cliente3@cliente.com', 0, N'ABk0lqJNjiQAHReJTTZUSUeMBEsuhhlAAsD4fHBwZN2mIYNjJE/iA+bhiuhr1M9Ndw==', N'aab6f9a9-9e11-4cf3-a21a-f0a8fa14747d', NULL, 0, 0, NULL, 1, 0, N'cliente3@cliente.com', 3)
INSERT INTO [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Departamento_Id]) VALUES (N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'admin@admin.com', 0, N'AMce/kMinaapWMFIhFljDKGl0ASFXYSozOLphpU8IXFWVyqvGUymM5PcvR8cQXzzoA==', N'ad15afdc-4b9c-489d-9499-9ef18b8eac15', NULL, 0, 0, NULL, 1, 0, N'admin@admin.com', 4)
SET IDENTITY_INSERT [dbo].[FollowTables] ON
INSERT INTO [dbo].[FollowTables] ([ID], [Who], [Follow]) VALUES (1, N'ad795f49-71ab-4737-80f3-ab420224dfcf', N'332ac4c9-d37e-48fe-9075-a5e474877456')
INSERT INTO [dbo].[FollowTables] ([ID], [Who], [Follow]) VALUES (9, N'332ac4c9-d37e-48fe-9075-a5e474877456', N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0')
SET IDENTITY_INSERT [dbo].[FollowTables] OFF
INSERT INTO [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fadb6386-2f63-4d4e-87e1-0cc36dc33db0', N'1')
SET IDENTITY_INSERT [dbo].[DepartamentoTIs] ON
INSERT INTO [dbo].[DepartamentoTIs] ([Id], [DeptoTI]) VALUES (1, N'Soporte')
INSERT INTO [dbo].[DepartamentoTIs] ([Id], [DeptoTI]) VALUES (2, N'Desarrollo')
INSERT INTO [dbo].[DepartamentoTIs] ([Id], [DeptoTI]) VALUES (3, N'Produccion')
SET IDENTITY_INSERT [dbo].[DepartamentoTIs] OFF
SET IDENTITY_INSERT [dbo].[Departamentos] ON
INSERT INTO [dbo].[Departamentos] ([Id], [Depto]) VALUES (1, N'Contabilidad')
INSERT INTO [dbo].[Departamentos] ([Id], [Depto]) VALUES (2, N'Recursos Humanos')
INSERT INTO [dbo].[Departamentos] ([Id], [Depto]) VALUES (3, N'Tesorería')
INSERT INTO [dbo].[Departamentos] ([Id], [Depto]) VALUES (4, N'Tecnología de la información')
SET IDENTITY_INSERT [dbo].[Departamentos] OFF
SET IDENTITY_INSERT [dbo].[Estatus] ON
INSERT INTO [dbo].[Estatus] ([Id], [Estado]) VALUES (1, N'Pendiente')
INSERT INTO [dbo].[Estatus] ([Id], [Estado]) VALUES (2, N'En proceso')
INSERT INTO [dbo].[Estatus] ([Id], [Estado]) VALUES (3, N'Cerrado/Completado')
SET IDENTITY_INSERT [dbo].[Estatus] OFF
INSERT INTO [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'1', N'Admin')
INSERT INTO [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'2', N'Desarrollo')
INSERT INTO [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'3', N'Soporte')
INSERT INTO [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'4', N'Cliente')
ALTER TABLE [dbo].[AspNetUserLogins]
    ADD CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[AspNetUserClaims]
    ADD CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[AspNetUserRoles]
    ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[AspNetUserRoles]
    ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[FollowTables]
    ADD CONSTRAINT [FK_FollowTables_who] FOREIGN KEY ([Who]) REFERENCES [dbo].[AspNetUsers] ([Id])
ALTER TABLE [dbo].[FollowTables]
    ADD CONSTRAINT [FK_FollowTables_Follow] FOREIGN KEY ([Follow]) REFERENCES [dbo].[AspNetUsers] ([Id])
ALTER TABLE [dbo].[AspNetUsers]
    ADD CONSTRAINT [FK_AspNetUsers_Depto] FOREIGN KEY ([Departamento_Id]) REFERENCES [dbo].[Departamentos] ([Id])
ALTER TABLE [dbo].[Archivos]
    ADD CONSTRAINT [FK_Table_Tickets] FOREIGN KEY ([TicketId]) REFERENCES [dbo].[Tickets] ([Id])
ALTER TABLE [dbo].[Tickets]
    ADD CONSTRAINT [FK_Tickets_DeptoTi] FOREIGN KEY ([DepartamentoPertenece]) REFERENCES [dbo].[DepartamentoTIs] ([Id])
ALTER TABLE [dbo].[Tickets]
    ADD CONSTRAINT [FK_Tickets_Estatus] FOREIGN KEY ([Estatus_ID]) REFERENCES [dbo].[Estatus] ([Id])
ALTER TABLE [dbo].[Tickets]
    ADD CONSTRAINT [FK_Tickets_Owner] FOREIGN KEY ([OwnerID]) REFERENCES [dbo].[AspNetUsers] ([Id])
ALTER TABLE [dbo].[Tickets]
    ADD CONSTRAINT [FK_Tickets_Asigned] FOREIGN KEY ([Asig_id]) REFERENCES [dbo].[AspNetUsers] ([Id])
COMMIT TRANSACTION
