//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Ticket
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Ticket()
        {
            this.Archivos = new HashSet<Archivo>();
        }
    
        public int Id { get; set; }
        public string OwnerID { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public System.DateTime Date_added { get; set; }
        public Nullable<System.DateTime> Date_solved { get; set; }
        public string Asig_id { get; set; }
        public int Estatus_ID { get; set; }
        public Nullable<int> DepartamentoPertenece { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Archivo> Archivos { get; set; }
        public virtual AspNetUser AspNetUser { get; set; }
        public virtual AspNetUser AspNetUser1 { get; set; }
        public virtual DepartamentoTI DepartamentoTI { get; set; }
        public virtual Estatu Estatu { get; set; }
    }
}