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
    
    public partial class Archivo
    {
        public int Id { get; set; }
        public string Filename { get; set; }
        public int TicketId { get; set; }
    
        public virtual Ticket Ticket { get; set; }
    }
}
