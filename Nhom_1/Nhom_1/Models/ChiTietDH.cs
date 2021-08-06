namespace Nhom_1.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ChiTietDH")]
    public partial class ChiTietDH
    {
        public ChiTietDH(){}

        public ChiTietDH(int ma_DH, int ma_SP, int? soLuong_CT)
        {
            Ma_DH = ma_DH;
            Ma_SP = ma_SP;
            SoLuong_CT = soLuong_CT;
        }


        [Key]
        public int Ma_CT { get; set; }

        public int Ma_DH { get; set; }

        public int Ma_SP { get; set; }

        public int? SoLuong_CT { get; set; }

        public virtual DonHang DonHang { get; set; }

        public virtual SanPham SanPham { get; set; }
    }
}
