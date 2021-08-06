namespace Nhom_1.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("GioHang")]
    public partial class GioHang
    {
        public GioHang(){}

        public GioHang(int ma_TK, int ma_SP, int? soLuong_GH)
        {
            Ma_TK = ma_TK;
            Ma_SP = ma_SP;
            SoLuong_GH = soLuong_GH;
        }

        [Key]
        public int Ma_GH { get; set; }

        public int Ma_TK { get; set; }

        public int Ma_SP { get; set; }

        public int? SoLuong_GH { get; set; }

        public virtual TaiKhoan TaiKhoan { get; set; }

        public virtual SanPham SanPham { get; set; }
    }
}
