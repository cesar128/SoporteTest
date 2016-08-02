








namespace SoporteTest1.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class rep_por_depto
    {
        public int? cantidad { get; set; }

        [Key]
        public string depto { get; set; }
    }
}
