namespace Nhom_1.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Anh")]
    public partial class Anh
    {
        public Anh(){}

        public Anh(int ma_SP, string duongDanAnh)
        {
            Ma_SP = ma_SP;
            DuongDanAnh = duongDanAnh;
        }


        [Key]
        public int Ma_Anh { get; set; }

        public int Ma_SP { get; set; }

        [StringLength(500)]
        public string DuongDanAnh { get; set; }

        public virtual SanPham SanPham { get; set; }
    }
}
