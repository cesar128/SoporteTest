﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SoporteTest1
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class Entities : DbContext
    {
        public Entities()
            : base("name=Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Archivo> Archivos { get; set; }
        public virtual DbSet<AspNetRole> AspNetRoles { get; set; }
        public virtual DbSet<AspNetUserClaim> AspNetUserClaims { get; set; }
        public virtual DbSet<AspNetUserLogin> AspNetUserLogins { get; set; }
        public virtual DbSet<AspNetUser> AspNetUsers { get; set; }
        public virtual DbSet<Departamento> Departamentos { get; set; }
        public virtual DbSet<DepartamentoTI> DepartamentoTIs { get; set; }
        public virtual DbSet<Estatu> Estatus { get; set; }
        public virtual DbSet<FollowTable> FollowTables { get; set; }
        public virtual DbSet<Ticket> Tickets { get; set; }
        public virtual DbSet<rep_por_depto> rep_por_depto { get; set; }
        public virtual DbSet<rep_dept_ti> rep_dept_ti { get; set; }
    }
}
