namespace Nhom_1.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TaiKhoan")]
    public partial class TaiKhoan
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TaiKhoan()
        {
            DonHangs = new HashSet<DonHang>();
            GioHangs = new HashSet<GioHang>();
        }

        public TaiKhoan(string tenTK, string matKhauTK, int maQuyen)
        {
            Ten_TK = tenTK;
            MatKhau_TK = matKhauTK;
            TrangThai_TK = 1;
            MaQuyen = maQuyen;
        }

        public TaiKhoan(string tenTK, string matKhauTK, string anh, int maQuyen)
        {
            Ten_TK = tenTK;
            MatKhau_TK = matKhauTK;
            Anh_TK = anh;
            TrangThai_TK = 1;
            MaQuyen = maQuyen;
        }


        [Key]
        public int Ma_TK { get; set; }

        [StringLength(20)]
        public string Ten_TK { get; set; }

        [StringLength(10)]
        public string MatKhau_TK { get; set; }

        [StringLength(50)]
        public string HoTen_TK { get; set; }

        public int? Tuoi_TK { get; set; }

        [StringLength(150)]
        public string DiaChi_TK { get; set; }

        [StringLength(15)]
        public string DienThoai_TK { get; set; }

        [StringLength(30)]
        public string Email_TK { get; set; }

        [StringLength(100)]
        public string Anh_TK { get; set; }

        public int? TrangThai_TK { get; set; }

        public int MaQuyen { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DonHang> DonHangs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GioHang> GioHangs { get; set; }

        public virtual Quyen Quyen { get; set; }
    }
}
